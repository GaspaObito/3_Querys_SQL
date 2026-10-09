import os
from io import StringIO
from pathlib import Path

import pandas as pd
import pyodbc
import win32com.client as win32
from dotenv import load_dotenv
from selenium import webdriver
from selenium.common.exceptions import TimeoutException
from selenium.webdriver.common.by import By
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.ui import Select, WebDriverWait


# ============================================================
# 1. CONFIGURACION DE PREFIJOS
# Relaciona el prefijo de VisualDTE con el tipo de documento
# almacenado en Ofima.
# ============================================================

CONFIG_PREFIJOS = {
    "VR01": {
        "codigo_ofima": "FA25",
        "tipo_dcto": "25",
        "punto_venta": "Sincelejo 6",
    },
    "VR02": {
        "codigo_ofima": "FA11",
        "tipo_dcto": "11",
        "punto_venta": "Monteria",
    },
    "VR03": {
        "codigo_ofima": "FA16",
        "tipo_dcto": "16",
        "punto_venta": "Cartago",
    },
    "VR05": {
        "codigo_ofima": "FA10",
        "tipo_dcto": "10",
        "punto_venta": "Santa Marta",
    },
    "VR06": {
        "codigo_ofima": "FA06",
        "tipo_dcto": "24",
        "punto_venta": "Sincelejo 1",
    },
    "VR07": {
        "codigo_ofima": "FA07",
        "tipo_dcto": "07",
        "punto_venta": "Sincelejo 3",
    },
    "VR08": {
        "codigo_ofima": "FA08",
        "tipo_dcto": "08",
        "punto_venta": "Sincelejo 4",
    },
    "VR09": {
        "codigo_ofima": "FA09",
        "tipo_dcto": "09",
        "punto_venta": "Sincelejo 5",
    },
    "VR10": {
        "codigo_ofima": "FA22",
        "tipo_dcto": "22",
        "punto_venta": "MultiTelas",
    },
    "VR14": {
        "codigo_ofima": "FA14",
        "tipo_dcto": "14",
        "punto_venta": "Cali Centro",
    },
    "VR15": {
        "codigo_ofima": "FA20",
        "tipo_dcto": "20",
        "punto_venta": "MultiFabric Cali",
    },
    "VR16": {
        "codigo_ofima": "FA15",
        "tipo_dcto": "15",
        "punto_venta": "Tulua",
    },
    "VR18": {
        "codigo_ofima": "FA02",
        "tipo_dcto": "02",
        "punto_venta": "Nueva York",
    },
    "VR19": {
        "codigo_ofima": "FA05",
        "tipo_dcto": "05",
        "punto_venta": "Restrepo",
    },
    "VR20": {
        "codigo_ofima": "FA21",
        "tipo_dcto": "21",
        "punto_venta": "Multifabrics",
    },
    "VR21": {
        "codigo_ofima": "FA01",
        "tipo_dcto": "01",
        "punto_venta": "Romelio",
    },
    "VR22": {
        "codigo_ofima": "FA03",
        "tipo_dcto": "03",
        "punto_venta": "Superganga",
    },
    "VR23": {
        "codigo_ofima": "FA04",
        "tipo_dcto": "04",
        "punto_venta": "Carulla",
    },
}

RANGO_INICIAL = 1
RANGO_FINAL = 100000
NO_FILAS = 100000
TIEMPO_ESPERA = 90
MAX_FILAS_CORREO = 200

URL_LOGIN = "https://www.visualdte.com.co/login"
URL_CONSULTA = "https://www.visualdte.com.co/facturasxrango"


# ============================================================
# 2. FUNCIONES AUXILIARES
# ============================================================

def normalizar_tipo_dcto(valor):
    """Convierte 1, 01 y 1.0 al mismo formato: 01."""
    if pd.isna(valor):
        return None

    texto = str(valor).strip().upper()

    if texto.endswith(".0") and texto[:-2].isdigit():
        texto = texto[:-2]

    if texto.isdigit():
        texto = texto.zfill(2)

    return texto or None


def establecer_valor(driver, elemento, valor):
    """Asigna un valor y dispara los eventos usados por la pagina."""
    driver.execute_script(
        """
        const campo = arguments[0];
        campo.value = arguments[1];
        campo.dispatchEvent(new Event('input', {bubbles: true}));
        campo.dispatchEvent(new Event('change', {bubbles: true}));
        campo.dispatchEvent(
            new KeyboardEvent('keyup', {
                bubbles: true,
                key: 'Enter',
                code: 'Enter',
                keyCode: 13,
                which: 13
            })
        );
        """,
        elemento,
        str(valor),
    )


def consultar_documentos_ofima(conexion):
    """Consulta una sola vez los documentos que se compararan."""
    consulta = """
        SELECT
            FECHA AS Fecha_Ofima,
            TIPODCTO AS Tipo_Dcto,
            TRY_CONVERT(BIGINT, NRODCTO) AS Folio,
            (
                COALESCE(BRUTO, 0)
                + COALESCE(IVABRUTO, 0)
                - COALESCE(DESCUENTO, 0)
            ) AS Valor_Total_Ofima
        FROM trade
        WHERE ORIGEN = 'FAC'
          AND TIPODCTO NOT IN ('PD', 'PV', 'FE', 'AN', 'FA', 'ND')
          AND FECHA >='20260801'
    """

    cursor = conexion.cursor()
    cursor.execute(consulta)

    columnas = [columna[0] for columna in cursor.description]
    filas = [tuple(fila) for fila in cursor.fetchall()]
    cursor.close()

    return pd.DataFrame(filas, columns=columnas)


def enviar_correo(destinatario, archivo_salida, df_final, df_faltantes):
    """Envia el resumen y adjunta el archivo generado."""
    df_correo = df_faltantes.head(MAX_FILAS_CORREO)

    tabla_html = df_correo.to_html(
        index=False,
        border=0,
        justify="center",
        na_rep="",
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
        <p>Buenos dias,</p>
        <p>
            Se compararon <strong>{len(df_final)}</strong> registros de
            VisualDTE. Se encontraron
            <strong>{len(df_faltantes)}</strong> documentos de Ofima que no
            aparecen en VisualDTE.
        </p>
        <p>
            El correo muestra como maximo {MAX_FILAS_CORREO} registros.
            El detalle completo se encuentra en el archivo adjunto.
        </p>
        {tabla_html}
        <p>Saludos.</p>
    </body>
    </html>
    """

    outlook = win32.Dispatch("Outlook.Application")
    correo = outlook.CreateItem(0)
    correo.To = destinatario
    correo.CC = ""
    correo.Subject = "Reporte de facturas por prefijo VRN"
    correo.HTMLBody = cuerpo_html
    correo.Attachments.Add(str(archivo_salida.resolve()))
    correo.Send()


# ============================================================
# 3. INICIO DEL PROGRAMA PRINCIPAL
# ============================================================

def main():
    driver = None
    conexion_sql = None

    carpeta_script = Path(__file__).resolve().parent
    archivo_env = carpeta_script / "Datos.env"

    load_dotenv(archivo_env, override=True)

    usuario_visual = os.getenv("VISUALDTE_USUARIO")
    password_visual = os.getenv("VISUALDTE_PASSWORD")
    sql_server = os.getenv("SQL_SERVER")
    sql_database = os.getenv("SQL_DATABASE")
    sql_usuario = os.getenv("SQL_USUARIO")
    sql_password = os.getenv("SQL_PASSWORD")
    correo_destino = os.getenv("CORREO_DESTINO")

    if not all(
        [
            usuario_visual,
            password_visual,
            sql_server,
            sql_database,
            sql_usuario,
            sql_password,
        ]
    ):
        raise ValueError(
            "Faltan credenciales de VisualDTE o SQL en Datos.env"
        )

    # El diccionario inverso permite convertir 25 -> VR01, 11 -> VR02, etc.
    tipo_a_prefijo = {
        normalizar_tipo_dcto(datos["tipo_dcto"]): prefijo
        for prefijo, datos in CONFIG_PREFIJOS.items()
    }

    # Solamente se descargan prefijos que tienen equivalencia configurada.
    prefijos = list(CONFIG_PREFIJOS.keys())

    try:
        # ------------------------------------------------------------
        # 3.1 CONEXION A SQL SERVER
        # ------------------------------------------------------------
        conexion_sql = pyodbc.connect(
            "DRIVER={ODBC Driver 18 for SQL Server};"
            f"SERVER={sql_server};"
            f"DATABASE={sql_database};"
            f"UID={sql_usuario};"
            f"PWD={sql_password};"
            "Encrypt=yes;"
            "TrustServerCertificate=yes;",
            timeout=15,
        )

        # ------------------------------------------------------------
        # 3.2 INICIO DE SESION EN VISUALDTE
        # ------------------------------------------------------------
        driver = webdriver.Chrome()
        wait = WebDriverWait(driver, TIEMPO_ESPERA)

        driver.get(URL_LOGIN)

        campo_usuario = wait.until(
            EC.visibility_of_element_located((By.ID, "id_nom_usuario"))
        )
        campo_usuario.send_keys(usuario_visual)

        campo_password = wait.until(
            EC.visibility_of_element_located((By.ID, "id_password"))
        )
        campo_password.send_keys(password_visual)

        boton_colombia = wait.until(
            EC.element_to_be_clickable(
                (By.XPATH, "//input[@id='btnPaisCO']/ancestor::a[1]")
            )
        )
        boton_colombia.click()

        wait.until(EC.url_contains("/menuerp"))
        print("Inicio de sesion correcto:", driver.current_url)

        # ------------------------------------------------------------
        # 3.3 DESCARGA DE TODOS LOS PREFIJOS DE VISUALDTE
        # ------------------------------------------------------------
        resultados = []

        for prefijo_actual in prefijos:
            print(f"Consultando prefijo: {prefijo_actual}")

            # Cada prefijo comienza con una pagina limpia. Esto evita que
            # una consulta lenta afecte al siguiente prefijo.
            driver.get(URL_CONSULTA)

            selector_prefijo = wait.until(
                EC.visibility_of_element_located((By.ID, "prefijo"))
            )
            Select(selector_prefijo).select_by_visible_text(prefijo_actual)

            campo_nfilas = wait.until(
                EC.presence_of_element_located((By.ID, "nfilas"))
            )
            establecer_valor(driver, campo_nfilas, NO_FILAS)

            campo_inicial = wait.until(
                EC.presence_of_element_located((By.ID, "inicial"))
            )
            establecer_valor(driver, campo_inicial, RANGO_INICIAL)

            campo_final = wait.until(
                EC.presence_of_element_located((By.ID, "final"))
            )
            establecer_valor(driver, campo_final, RANGO_FINAL)

            cuerpo_tabla = driver.find_element(By.ID, "lventas")
            contenido_anterior = cuerpo_tabla.get_attribute("innerHTML")

            boton_buscar = wait.until(
                EC.element_to_be_clickable(
                    (By.CSS_SELECTOR, "button[onclick='getInfoRango()']")
                )
            )
            boton_buscar.click()

            try:
                WebDriverWait(driver, TIEMPO_ESPERA).until(
                    lambda navegador: navegador.find_element(
                        By.ID, "lventas"
                    ).get_attribute("innerHTML")
                    != contenido_anterior
                )
            except TimeoutException:
                print(
                    f"No se detectaron resultados para {prefijo_actual} "
                    f"despues de {TIEMPO_ESPERA} segundos"
                )
                continue

            filas = driver.find_elements(
                By.XPATH,
                "//table[@id='tablexcel']//tbody/tr[td]",
            )

            if not filas:
                print(f"{prefijo_actual} no devolvio registros")
                continue

            tabla = driver.find_element(By.ID, "tablexcel")
            html_tabla = tabla.get_attribute("outerHTML")

            df_prefijo = pd.read_html(
                StringIO(html_tabla),
                flavor="lxml",
            )[0]

            # La ultima celda contiene un icono sin encabezado.
            df_prefijo = df_prefijo.iloc[:, :16]

            if "Nombre" in df_prefijo.columns:
                df_prefijo = df_prefijo[
                    df_prefijo["Nombre"].astype(str).str.strip() != "Totales"
                ]

            df_prefijo["Prefijo consultado"] = prefijo_actual
            resultados.append(df_prefijo)

            print(
                f"{prefijo_actual}: {len(df_prefijo)} registros encontrados"
            )

        if not resultados:
            raise ValueError("VisualDTE no devolvio ningun documento")

        # Aqui termina la descarga web y se crea una sola tabla consolidada.
        df_final = pd.concat(resultados, ignore_index=True)

        # ------------------------------------------------------------
        # 3.4 PREPARACION DE LAS LLAVES DE VISUALDTE
        # ------------------------------------------------------------
        df_final["Prefijo"] = (
            df_final["Prefijo"].astype(str).str.strip().str.upper()
        )
        df_final["Folio"] = pd.to_numeric(
            df_final["Folio"], errors="coerce"
        ).astype("Int64")

        documentos_visual = (
            df_final[["Prefijo", "Folio"]]
            .dropna()
            .drop_duplicates()
        )

        # ------------------------------------------------------------
        # 3.5 CONSULTA UNICA DE TODOS LOS DOCUMENTOS DE OFIMA
        # ------------------------------------------------------------
        print("Consultando documentos de Ofima...")

        df_ofima = consultar_documentos_ofima(
            conexion_sql
        )

        df_ofima["Tipo_Dcto_Normalizado"] = df_ofima["Tipo_Dcto"].apply(
            normalizar_tipo_dcto
        )
        df_ofima["Prefijo"] = df_ofima["Tipo_Dcto_Normalizado"].map(
            tipo_a_prefijo
        )
        df_ofima["Folio"] = pd.to_numeric(
            df_ofima["Folio"], errors="coerce"
        ).astype("Int64")
        df_ofima["Fecha_Ofima"] = pd.to_datetime(
            df_ofima["Fecha_Ofima"], errors="coerce"
        )

        # Se comparan solamente los tipos incluidos en CONFIG_PREFIJOS.
        df_ofima_comparable = df_ofima[
            df_ofima["Prefijo"].notna() & df_ofima["Folio"].notna()
        ].copy()

        print(
            f"Ofima devolvio {len(df_ofima_comparable)} documentos "
            "con prefijo configurado"
        )

        # ------------------------------------------------------------
        # 3.6 CRUCE: OFIMA CONTRA VISUALDTE
        # ------------------------------------------------------------
        comparacion = df_ofima_comparable.merge(
            documentos_visual,
            on=["Prefijo", "Folio"],
            how="left",
            indicator=True,
        )

        # left_only significa: existe en Ofima, pero no en VisualDTE.
        df_no_cruzados = comparacion[
            comparacion["_merge"] == "left_only"
        ].copy()
        df_no_cruzados.drop(columns=["_merge"], inplace=True)

        codigo_por_prefijo = {
            prefijo: datos["codigo_ofima"]
            for prefijo, datos in CONFIG_PREFIJOS.items()
        }
        punto_por_prefijo = {
            prefijo: datos["punto_venta"]
            for prefijo, datos in CONFIG_PREFIJOS.items()
        }

        df_no_cruzados["Codigo Ofima"] = df_no_cruzados["Prefijo"].map(
            codigo_por_prefijo
        )
        df_no_cruzados["Punto de venta"] = df_no_cruzados["Prefijo"].map(
            punto_por_prefijo
        )
        df_no_cruzados["CodigoOfima + TipoDcto + PuntoVenta"] = (
            df_no_cruzados["Codigo Ofima"]
            + " + "
            + df_no_cruzados["Tipo_Dcto_Normalizado"]
            + " + "
            + df_no_cruzados["Punto de venta"]
        )

        df_detalle_faltantes = (
            df_no_cruzados[
                [
                    "Prefijo",
                    "CodigoOfima + TipoDcto + PuntoVenta",
                    "Folio",
                    "Fecha_Ofima",
                    "Valor_Total_Ofima",
                ]
            ]
            .rename(
                columns={
                    "Folio": "Folio faltante",
                    "Fecha_Ofima": "Fecha Ofima",
                    "Valor_Total_Ofima": "Valor total Ofima",
                }
            )
            .sort_values(["Prefijo", "Folio faltante"])
            .reset_index(drop=True)
        )

        print(
            f"Documentos de Ofima no encontrados en VisualDTE: "
            f"{len(df_detalle_faltantes)}"
        )

        # ------------------------------------------------------------
        # 3.7 RESUMEN POR PREFIJO
        # ------------------------------------------------------------
        cantidad_ofima = (
            df_ofima_comparable.groupby("Prefijo")
            .size()
            .rename("Cantidad Ofima")
        )
        cantidad_visual = (
            documentos_visual.groupby("Prefijo")
            .size()
            .rename("Cantidad VisualDTE")
        )
        cantidad_no_cruzada = (
            df_detalle_faltantes.groupby("Prefijo")
            .size()
            .rename("No encontrados en VisualDTE")
        )

        df_resumen_prefijos = pd.concat(
            [cantidad_ofima, cantidad_visual, cantidad_no_cruzada],
            axis=1,
        ).fillna(0)

        columnas_cantidad = [
            "Cantidad Ofima",
            "Cantidad VisualDTE",
            "No encontrados en VisualDTE",
        ]
        df_resumen_prefijos[columnas_cantidad] = df_resumen_prefijos[
            columnas_cantidad
        ].astype(int)
        df_resumen_prefijos.reset_index(inplace=True)

        # ------------------------------------------------------------
        # 3.8 EXPORTACION DEL ARCHIVO EXCEL
        # ------------------------------------------------------------
        archivo_salida = carpeta_script / "comparacion_ofima_visualdte.xlsx"

        with pd.ExcelWriter(archivo_salida, engine="openpyxl") as writer:
            df_final.to_excel(
                writer,
                sheet_name="VisualDTE",
                index=False,
            )
            df_ofima_comparable.to_excel(
                writer,
                sheet_name="Ofima",
                index=False,
            )
            df_resumen_prefijos.to_excel(
                writer,
                sheet_name="Resumen",
                index=False,
            )
            df_detalle_faltantes.to_excel(
                writer,
                sheet_name="No encontrados",
                index=False,
            )

        print(f"Total VisualDTE: {len(df_final)}")
        print(f"Archivo guardado en: {archivo_salida}")

        # ------------------------------------------------------------
        # 3.9 ENVIO DEL CORREO
        # ------------------------------------------------------------
        if correo_destino:
            enviar_correo(
                correo_destino,
                archivo_salida,
                df_final,
                df_detalle_faltantes,
            )
            print("Correo enviado correctamente")
        else:
            print(
                "No se envio correo porque CORREO_DESTINO no esta "
                "configurado en Datos.env"
            )

    finally:
        if conexion_sql is not None:
            conexion_sql.close()

        if driver is not None:
            driver.quit()


# ============================================================
# 4. FIN DEL PROGRAMA
# Al ejecutar este archivo directamente, Python llama a main().
# ============================================================

if __name__ == "__main__":
    main()
