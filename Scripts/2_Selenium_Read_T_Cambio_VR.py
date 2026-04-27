#IMPORTA LIBRERIAS
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

#FECHA TRAIDA
textoTRM = div1.text
# quitar puntos (miles) y dejar coma decimal
textoTRM = textoTRM.replace('.', '')
textoTRM = textoTRM.replace(',', '.')

div2 = wait.until(
    EC.presence_of_element_located((By.CLASS_NAME, "tilefecha"))
)

wait.until(lambda driver: div2.text.strip() != "")

#FECHA TRAIDA
textoFECHA = div2.text


print("Fecha:", textoFECHA)
print("Valor:", textoTRM)

#INSERTA DATOS
import pyodbc

conn1 = pyodbc.connect(
    "DRIVER={SQL Server};"
    "SERVER=COLNOTEXNT18;"
    "DATABASE=VERONASAS;"
    "Trusted_Connection=yes;"
)

cursor1 = conn1.cursor()

# Validar en BD principal
cursor1.execute(
    "SELECT COUNT(*) FROM MTCAMBIO WHERE FECHA = ?",
    textoFECHA
)

exists = cursor1.fetchone()[0]

if exists == 0:
    # Insert en BD1
    cursor1.execute(
        "INSERT INTO MTCAMBIO (FECHA, VALOR, DIA) VALUES (?, ?, DATENAME(WEEKDAY, GETDATE()))",
        textoFECHA, textoTRM
    )
   
    conn1.commit()

    print("Insertado en BD Verona")
else:
    print("Ya existe ese registro")

conn1.commit()

conn1.close()

driver.quit()