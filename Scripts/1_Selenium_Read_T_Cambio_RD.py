# IMPORTA LIBRERIAS
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

driver = webdriver.Chrome()

url = "https://dgii.gov.do/estadisticas/tasaCambio/Paginas/default.aspx"
driver.get(url)

wait = WebDriverWait(driver, 15)

div = wait.until(
    EC.visibility_of_element_located((By.CLASS_NAME, "doc-card__download"))
)

# FECHA TRAIDA
texto = div.text
print(texto)

# SEPARA TEXTO
fecha, valor = texto.split(" - ")
valor = valor.replace("RD$", "").strip()

# convertir a número
valor = float(valor.replace(",", ""))

print("Fecha:", fecha)
print("Valor:", valor)

# INSERTA DATOS
import pyodbc

conn1 = pyodbc.connect(
    "DRIVER={SQL Server};"
    "SERVER=COLNOTEXNT18;"
    "DATABASE=SUPERTODO;"
    "Trusted_Connection=yes;"
)

conn2 = pyodbc.connect(
    "DRIVER={SQL Server};"
    "SERVER=COLNOTEXNT18;"
    "DATABASE=BESTPRICE;"
    "Trusted_Connection=yes;"
)

cursor1 = conn1.cursor()
cursor2 = conn2.cursor()

# ✅ VALIDACIÓN OPTIMIZADA
cursor1.execute("""
    SELECT CASE 
        WHEN EXISTS (
            SELECT 1 
            FROM MTCAMBIO
            WHERE FECHA >= CAST(GETDATE() AS DATE)
              AND FECHA < DATEADD(DAY, 1, CAST(GETDATE() AS DATE))
        )
        THEN 1 ELSE 0 
    END
""")

existe = cursor1.fetchone()[0]

if existe > 0:
    print("Ya existe ese registro, no se inserta")
else:
    # Insert en BD1
    cursor1.execute("""
        INSERT INTO MTCAMBIO (FECHA, VALOR, TASAVEN, DIA)
        VALUES (CAST(GETDATE() AS DATE), ?, ?, DATENAME(WEEKDAY, GETDATE()))
    """, valor, valor)

    # Insert en BD2
    cursor2.execute("""
        INSERT INTO MTCAMBIO (FECHA, VALOR, TASAVEN, DIA)
        VALUES (CAST(GETDATE() AS DATE), ?, ?, DATENAME(WEEKDAY, GETDATE()))
    """, valor, valor)

    conn1.commit()
    conn2.commit()

    print("Insertado en ambas BD")

conn1.close()
conn2.close()
driver.quit()