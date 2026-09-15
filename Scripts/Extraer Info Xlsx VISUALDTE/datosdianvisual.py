import os
from io import StringIO
from pathlib import Path
from dotenv import load_dotenv #Ejecutar Env
#py -m pip install lxml openpyxl
import pandas as pd
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import Select
from selenium.webdriver.common.keys import Keys
from selenium.common.exceptions import TimeoutException
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC


driver = webdriver.Chrome()
wait = WebDriverWait(driver, 30)

try:
    #Carga Datos Env
    load_dotenv("Datos.env")
    
    # Abrir el inicio de sesión
    driver.get("https://www.visualdte.com.co/login")

    # Escribir usuario
    usuario = wait.until(
        EC.visibility_of_element_located((By.ID, "id_nom_usuario"))
    )
    usuario.send_keys(os.environ["VISUALDTE_USUARIO"])

    # Escribir contraseña
    password = wait.until(
        EC.visibility_of_element_located((By.ID, "id_password"))
    )
    password.send_keys(os.environ["VISUALDTE_PASSWORD"])

    # Localizar el botón visible <a> que contiene el input btnPaisCO
    boton_colombia = wait.until(
        EC.element_to_be_clickable(
            (By.XPATH, "//input[@id='btnPaisCO']/ancestor::a[1]")
        )
    )

    # Pulsar el botón Colombia
    boton_colombia.click()

    # Confirmar que el inicio de sesión llevó a /menuerp
    wait.until(EC.url_contains("/menuerp"))
    print("Inicio de sesión correcto:", driver.current_url)

    # Abrir la página de las facturas conservando la sesión

    driver.get("https://www.visualdte.com.co/facturasxrango")

    # Esperar y seleccionar el prefijo por el texto visible
    # Prefijos que deseas consultar
    PREFIJOS = [
        "NC",
        "ND",
        "VR09",
        "VR10",
        "VR05",
        "VR01",
        "VR06",
        "VR02",
        "VR07",
        "VR08",
    ]

    RANGO_INICIAL = 1
    RANGO_FINAL = 100000
    NO_FILAS = 100000
    
    # Aquí se almacenará el resultado de cada prefijo
    resultados = []

    driver.get("https://www.visualdte.com.co/facturasxrango")

    # Rango final
    campo_nfinal = wait.until(
        EC.visibility_of_element_located((By.ID, "nfilas"))
    )
    campo_nfinal.clear()
    campo_nfinal.send_keys(str(NO_FILAS))
    
    for prefijo_actual in PREFIJOS:
        print(f"Consultando prefijo: {prefijo_actual}")

        # Volver a localizar el selector en cada iteración
        selector_prefijo = wait.until(
            EC.visibility_of_element_located((By.ID, "prefijo"))
        )

        Select(selector_prefijo).select_by_visible_text(prefijo_actual)
                    
        # Rango inicial
        campo_inicial = wait.until(
            EC.visibility_of_element_located((By.ID, "inicial"))
        )
        campo_inicial.clear()
        campo_inicial.send_keys(str(RANGO_INICIAL))

        # Rango final
        campo_final = wait.until(
            EC.visibility_of_element_located((By.ID, "final"))
        )
        campo_final.clear()
        campo_final.send_keys(str(RANGO_FINAL))
                   
        # Guardar el contenido actual para detectar la actualización
        cuerpo_tabla = driver.find_element(By.ID, "lventas")
        contenido_anterior = cuerpo_tabla.get_attribute("innerHTML")

        # Pulsar Buscar
        boton_buscar = wait.until(
            EC.element_to_be_clickable(
                (By.CSS_SELECTOR, "button[onclick='getInfoRango()']")
            )
        )
        boton_buscar.click()

        try:
            # Esperar a que el contenido de la tabla cambie
            WebDriverWait(driver, 20).until(
                lambda navegador: navegador.find_element(
                    By.ID, "lventas"
                ).get_attribute("innerHTML") != contenido_anterior
            )

        except TimeoutException:
            print(
                f"No se detectaron resultados nuevos para {prefijo_actual}"
            )
            continue

        # Comprobar si existen filas con datos
        filas = driver.find_elements(
            By.XPATH,
            "//table[@id='tablexcel']//tbody/tr[td]"
        )

        if not filas:
            print(f"El prefijo {prefijo_actual} no devolvió registros")
            continue

        # Obtener la tabla actualizada
        tabla = driver.find_element(By.ID, "tablexcel")
        html_tabla = tabla.get_attribute("outerHTML")

        df_prefijo = pd.read_html(
            StringIO(html_tabla),
            flavor="lxml"
        )[0]

        # Eliminar la columna adicional del icono
        df_prefijo = df_prefijo.iloc[:, :16]

        # Eliminar la fila "Totales" generada por la página
        if "Nombre" in df_prefijo.columns:
            df_prefijo = df_prefijo[
                df_prefijo["Nombre"].astype(str).str.strip() != "Totales"
            ]

        # Registrar explícitamente qué prefijo se consultó
        df_prefijo["Prefijo consultado"] = prefijo_actual

        resultados.append(df_prefijo)

        print(
            f"{prefijo_actual}: {len(df_prefijo)} registros encontrados"
        )

        # Unir todas las consultas
        if resultados:
            df_final = pd.concat(resultados, ignore_index=True)

            # Asegurar que Folio sea numérico
            df_final["Folio"] = pd.to_numeric(df_final["Folio"], errors="coerce")

            resumen_prefijos = []
            detalle_faltantes = []

            for prefijo, grupo in df_final.groupby("Prefijo"):
                folios = sorted(grupo["Folio"].dropna().astype(int).unique())

                if not folios:
                    continue

                folio_min = min(folios)
                folio_max = max(folios)

                esperados = set(range(folio_min, folio_max + 1))
                existentes = set(folios)
                faltantes = sorted(esperados - existentes)

                resumen_prefijos.append({
                    "Prefijo": prefijo,
                    "Desde": folio_min,
                    "Hasta": folio_max,
                    "Cantidad encontrada": len(folios),
                    "Cantidad esperada": len(esperados),
                    "Cantidad faltante": len(faltantes),
                    "Folios faltantes": ", ".join(map(str, faltantes))
                })

                for folio in faltantes:
                    detalle_faltantes.append({
                        "Prefijo": prefijo,
                        "Folio faltante": folio
                    })

            df_resumen_prefijos = pd.DataFrame(resumen_prefijos)
            df_detalle_faltantes = pd.DataFrame(detalle_faltantes)

            archivo_salida = Path(__file__).with_name(
                "facturas_todos_los_prefijos.xlsx"
            )

            with pd.ExcelWriter(archivo_salida, engine="openpyxl") as writer:
                df_final.to_excel(writer, sheet_name="Facturas", index=False)
                df_resumen_prefijos.to_excel(
                    writer,
                    sheet_name="Resumen prefijos",
                    index=False
                )
                df_detalle_faltantes.to_excel(
                    writer,
                    sheet_name="Folios faltantes",
                    index=False
                )

            print(f"Total exportado: {len(df_final)} registros")
            print(f"Archivo guardado en: {archivo_salida}")
        else:
            print("Ningún prefijo devolvió información")
finally:
    driver.quit()