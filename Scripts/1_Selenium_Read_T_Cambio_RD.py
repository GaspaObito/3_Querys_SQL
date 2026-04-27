#IMPORTA LIBRERIAS
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

driver = webdriver.Chrome()

url = "https://dgii.gov.do/estadisticas/tasaCambio/Paginas/default.aspx"
driver.get(url)

wait = WebDriverWait(driver, 15)

div = wait.until(
    EC.presence_of_element_located((By.CLASS_NAME, "doc-card__download"))
)
#FECHA TRAIDA
texto = div.text
print(texto)

#SEPARA TEXTO
fecha, valor = texto.split(" - ")
valor = valor.replace("RD$", "").strip()

print("Fecha:", fecha)
print("Valor:", valor)

#INSERTA DATOS
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

# Validar en BD principal
cursor1.execute(
    "SELECT COUNT(*) FROM MTCAMBIO WHERE FECHA = ?",
    fecha
)

exists = cursor1.fetchone()[0]

if exists == 0:
    # Insert en BD1
    cursor1.execute(
        "INSERT INTO MTCAMBIO (FECHA, VALOR, TASAVEN, DIA) VALUES (?, ?, ?, DATENAME(WEEKDAY, GETDATE()))",
        fecha, valor, valor
    )

    # Insert en BD2
    cursor2.execute(
        "INSERT INTO MTCAMBIO (FECHA, VALOR, TASAVEN, DIA) VALUES (?, ?, ?, DATENAME(WEEKDAY, GETDATE()))",
        fecha, valor, valor
    )

    conn1.commit()
    conn2.commit()

    print("Insertado en ambas BD")
else:
    print("Ya existe ese registro")

conn1.commit()
conn2.commit()

conn1.close()
conn2.close()

driver.quit()