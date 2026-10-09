import os
from io import StringIO
from pathlib import Path
from dotenv import load_dotenv
import pandas as pd
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import Select
from selenium.common.exceptions import TimeoutException
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import pyodbc
try:
    SQL_SERVER = "COLNOTEXNT18"
    SQL_DATABASE = "VERONASAS"
    SQL_USUARIO = "sa"
    SQL_PASSWORD = "sonia2013*"

    if not all([
        SQL_SERVER,
        SQL_DATABASE,
        SQL_USUARIO,
        SQL_PASSWORD
    ]):
        raise ValueError(
            "Faltan datos de conexión SQL en Datos.env"
        )

    conexion_sql = pyodbc.connect(
        "DRIVER={ODBC Driver 18 for SQL Server};"
        f"SERVER={SQL_SERVER};"
        f"DATABASE={SQL_DATABASE};"
        f"UID={SQL_USUARIO};"
        f"PWD={SQL_PASSWORD};"
        "Encrypt=yes;"
        "TrustServerCertificate=yes;",
        timeout=15
    )

    cursor_sql = conexion_sql.cursor()
    def consultar_factura_sql(
    cursor,
    folio,
    tipo_dcto
    ):
        consulta = """
            SELECT TOP (1)
                FECHA,
                (BRUTO+IVABRUTO)-DESCUENTO AS VALORTOTAL
            FROM trade
            WHERE NRODCTO = ?
            AND TIPODCTO = ?
            ORDER BY FECHA DESC
        """

        cursor.execute(
            consulta,
            str(folio),
            str(tipo_dcto)
        )

        fila = cursor.fetchone()

        if fila is None:
            return None, None

        fecha = fila[0]
        valor_total = fila[1]

        return fecha, valor_total    
    #"C:\Users\joseA\AppData\Local\Programs\Python\Python313\python.exe" -m pip install pywin32 python-dotenv pandas selenium lxml openpyxl
    driver = webdriver.Chrome()
    wait = WebDriverWait(driver, 90)
    # Carpeta donde se encuentra datosdianvisual.py
    CARPETA_SCRIPT = Path(__file__).resolve().parent

    # Ruta completa de Datos.env
    ARCHIVO_ENV = CARPETA_SCRIPT / "Datos.env"
    
    # Cargar las variables
    load_dotenv(ARCHIVO_ENV, override=True)
    
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
           "VR01","VR02","VR03","VR04","VR05","VR06","VR07","VR08","VR09","VR10","VR11","VR12","VR13","VR14","VR15","VR16","VR18","VR19","VR20","VR21","VR22","VR23"
    ]
    CONFIG_PREFIJOS = {
        "VR01": {
            "codigo_ofima": "FA25",
            "tipo_dcto": "25",
            "punto_venta": "Sincelejo 6"
        },
        "VR02": {
            "codigo_ofima": "FA11",
            "tipo_dcto": "11",
            "punto_venta": "Monteria"
        },
        "VR03": {
            "codigo_ofima": "FA16",
            "tipo_dcto": "16",
            "punto_venta": "Cartago"
        },
        "VR05": {
            "codigo_ofima": "FA10",
            "tipo_dcto": "10",
            "punto_venta": "Santa Marta"
        },
        "VR06": {
            "codigo_ofima": "FA06",
            "tipo_dcto": "24",
            "punto_venta": "Sincelejo 1"
        },
        "VR07": {
            "codigo_ofima": "FA07",
            "tipo_dcto": "07",
            "punto_venta": "Sincelejo 3"
        },
        "VR08": {
            "codigo_ofima": "FA08",
            "tipo_dcto": "08",
            "punto_venta": "Sincelejo 4"
        },
        "VR09": {
            "codigo_ofima": "FA09",
            "tipo_dcto": "09",
            "punto_venta": "Sincelejo 5"
        },
        "VR10": {
            "codigo_ofima": "FA22",
            "tipo_dcto": "22",
            "punto_venta": "MultiTelas"
        },
        "VR14": {
            "codigo_ofima": "FA14",
            "tipo_dcto": "14",
            "punto_venta": "Cali Centro"
        },
        "VR15": {
            "codigo_ofima": "FA20",
            "tipo_dcto": "20",
            "punto_venta": "MultiFabric Cali"
        },
        "VR16": {
            "codigo_ofima": "FA15",
            "tipo_dcto": "15",
            "punto_venta": "Tulua"
        },
        "VR18": {
            "codigo_ofima": "FA02",
            "tipo_dcto": "02",
            "punto_venta": "Nueva York"
        },
        "VR19": {
            "codigo_ofima": "FA05",
            "tipo_dcto": "05",
            "punto_venta": "Restrepo"
        },
        "VR20": {
            "codigo_ofima": "FA21",
            "tipo_dcto": "21",
            "punto_venta": "Multifabrics"
        },
        "VR21": {
            "codigo_ofima": "FA01",
            "tipo_dcto": "01",
            "punto_venta": "Romelio"
        },
        "VR22": {
            "codigo_ofima": "FA03",
            "tipo_dcto": "03",
            "punto_venta": "Superganga"
        },
        "VR23": {
            "codigo_ofima": "FA04",
            "tipo_dcto": "04",
            "punto_venta": "Carulla"
        }
    }
    
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
            WebDriverWait(driver, 90).until(
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

                PUNTOS_VENTA = {
                    "VR01": "FA25 + 25 + Sincelejo 6","VR02": "FA11 + 11 + Monteria","VR03": "FA16 + 16 + Cartago","VR05": "FA10 + 10 + Santa Marta",  "VR06": "FA06 + 24 + Sincelejo 1", 
                    "VR07": "FA07 + 07 + Sincelejo 3","VR08": "FA08 + 08 + Sincelejo 4","VR09": "FA09 + 09 + Sincelejo 5",
                    "VR10": "FA22 + 22 + MultiTelas","VR14": "FA14 + 14 + Cali Centro", "VR15": "FA20 + 20 + MultiFabric Cali", "VR16": "FA15 + 15 + Tulua","VR18": "FA02 + 02 + Nueva York",
                    "VR19": "FA05 + 05 + Restrepo","VR20": "FA21 + 21 + Multifabrics", "VR21": "FA01 + 01 + Romelio", "VR22": "FA03 + 03 + Superganga","VR23": "FA04 + 04 + Carulla",
                }

                for folio in faltantes:
                    configuracion = CONFIG_PREFIJOS.get(prefijo)

                    if configuracion is None:
                        detalle_faltantes.append({
                            "Prefijo": prefijo,
                            "CodigoOfima + TipoDcto + PuntoVenta":
                                "Sin asignar",
                            "Folio faltante": folio,
                            "Fecha Ofima": None,
                            "Valor total Ofima": None,
                            "Estado Ofima": "Prefijo sin configurar"
                        })

                        continue

                    codigo_ofima = configuracion["codigo_ofima"]
                    tipo_dcto = configuracion["tipo_dcto"]
                    punto_venta = configuracion["punto_venta"]

                    fecha_ofima, valor_ofima = consultar_factura_sql(
                        cursor=cursor_sql,
                        folio=folio,
                        tipo_dcto=tipo_dcto
                    )

                    detalle_faltantes.append({
                        "Prefijo": prefijo,

                        "CodigoOfima + TipoDcto + PuntoVenta": (
                            f"{codigo_ofima} + "
                            f"{tipo_dcto} + "
                            f"{punto_venta}"
                        ),

                        "Folio faltante": folio,
                        "Fecha Ofima": fecha_ofima,

                        "Valor total Ofima": (
                            float(valor_ofima)
                            if valor_ofima is not None
                            else None
                        ),

                        "Estado Ofima": (
                            "Encontrado"
                            if fecha_ofima is not None
                            else "No encontrado"
                        )
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

    # ENVIA CORREO LIBRERIA
    import win32com.client as win32 #pywin32

    # Evitar enviar miles de filas dentro del correo
    MAX_FILAS_CORREO = 200

    df_correo = df_detalle_faltantes.head(MAX_FILAS_CORREO)

    tabla_html = df_correo.to_html(
        index=False,
        border=0,
        justify="center",
        na_rep=""
    )

    cuerpo_html = f"""
    <html>
    <head>
    <style>
        body {{
            font-family: Arial, sans-serif;
            font-size: 11pt;
            color: #222222;
        }}
        table {{
            border-collapse: collapse;
            width: 100%;
            font-size: 9pt;
        }}
        th {{
            background-color: #1F4E78;
            color: white;
            border: 1px solid #BFBFBF;
            padding: 6px;
            text-align: center;
        }}
        td {{
            border: 1px solid #D9D9D9;
            padding: 5px;
        }}
        tr:nth-child(even) {{
            background-color: #F2F2F2;
        }}
    </style>
    </head>
    <body>
        <p>Buenos días,</p>
        <p>
            Se genera reporte de DATA PUNTOS POS VERONA con cruce de DIAN encontrado: 
            <strong>{len(df_final)}</strong> registros encontrando <strong>{len(df_correo)}</strong> facturas no ingresadas a la DIAN:
        </p>

        {tabla_html}

        <p>Saludos.</p>
    </body>
    </html>
    """

    # Conectarse con Outlook
    outlook = win32.Dispatch("Outlook.Application")

    # 0 significa un nuevo correo
    correo = outlook.CreateItem(0)

    correo.To = "ylopez@colnotex.com"
    correo.CC = ""
    correo.Subject = "Reporte de facturas por prefijo VRN"

    # Abrir el borrador para que Outlook cargue la firma
    correo.Display()

    # Conservar la firma de Outlook
    firma = correo.HTMLBody
    correo.HTMLBody = cuerpo_html + firma

    # Adjuntar el Excel generado
    correo.Attachments.Add(str(archivo_salida.resolve()))
    # Enviar Correo
    correo.Send()
finally:    
    driver.quit()