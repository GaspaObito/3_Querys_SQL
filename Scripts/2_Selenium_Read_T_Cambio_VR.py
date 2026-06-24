# IMPORTA LIBRERIAS
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

driver = webdriver.Chrome()

url = "https://suameca.banrep.gov.co/estadisticas-economicas/informacionSerie/1/tasa_cambio_peso_colombiano_trm_dolar_usd"
driver.get(url)

wait = WebDriverWait(driver, 15)

div1 = wait.until(
    EC.visibility_of_element_located((By.CLASS_NAME, "tileValor"))
)

wait.until(lambda driver: div1.text.strip() != "")

# TRM
textoTRM = div1.text
textoTRM = textoTRM.replace('.', '')
textoTRM = textoTRM.replace(',', '.')
textoTRM = float(textoTRM)

div2 = wait.until(
    EC.presence_of_element_located((By.CLASS_NAME, "tilefecha"))
)

wait.until(lambda driver: div2.text.strip() != "")

# FECHA TRAIDA
textoFECHA = div2.text

print("Valor:", textoTRM)

# INSERTA DATOS
import pyodbc

conn1 = pyodbc.connect(
    "DRIVER={SQL Server};"
    "SERVER=COLNOTEXNT18;"
    "DATABASE=VERONASAS;"
    "Trusted_Connection=yes;"
)

conn2 = pyodbc.connect(
    "DRIVER={SQL Server};"
    "SERVER=COLNOTEXNT18;"
    "DATABASE=COLNOTEXSA;"
    "Trusted_Connection=yes;"
)

cursor1 = conn1.cursor()
cursor2 = conn2.cursor()

# VALIDAR SI YA EXISTE REGISTRO HOY
cursor1.execute("""
    SELECT CASE 
        WHEN EXISTS (
            SELECT 1 
            FROM MTCAMBIO 
            WHERE FECHA >= CAST(GETDATE() AS DATE)
              AND FECHA < DATEADD(DAY,1,CAST(GETDATE() AS DATE))
        ) 
        THEN 1 ELSE 0 
    END
""")

existe = cursor1.fetchone()[0]

if existe > 0:
    print("Ya se ejecutó hoy, no se insertan datos")
else:
    cursor1.execute("""
        INSERT INTO MTCAMBIO (FECHA, VALOR, DIA)
        VALUES (CAST(GETDATE() AS DATE), ?, DATENAME(WEEKDAY, GETDATE()))
    """, textoTRM)

    cursor2.execute("""
        INSERT INTO MTCAMBIO (FECHA, VALOR, DIA)
        VALUES (CAST(GETDATE() AS DATE), ?, DATENAME(WEEKDAY, GETDATE()))
    """, textoTRM)

    conn1.commit()
    conn2.commit()

    print("Insertado correctamente")

print("Proceso terminado")

conn1.close()
conn2.close()
driver.quit()