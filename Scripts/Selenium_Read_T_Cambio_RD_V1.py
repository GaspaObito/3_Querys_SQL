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

conn = pyodbc.connect(
    "DRIVER={SQL Server};"
    "SERVER=ANA_BASEDTJUNIO\\SQLEXPRESS01;"
    "DATABASE=SupertodoBackup;"
    "Trusted_Connection=yes;"
)
cursor = conn.cursor()

#VALIDA SI YA EXISTE EL REGISTRO 
cursor.execute(
    "SELECT COUNT(*) FROM MTCAMBIO WHERE FECHA = ?",
    fecha
)

exists = cursor.fetchone()[0]
if exists == 0:
    cursor.execute(
        "INSERT INTO MTCAMBIO (FECHA, VALOR, DIA) VALUES (?, ?, DATENAME(WEEKDAY, GETDATE()))",
        fecha, valor
    )
    conn.commit()
    print("Insertado")
else:
    print("Ya existe ese registro")

conn.commit()

conn.close()
driver.quit()