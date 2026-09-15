from zeep import Client
from zeep.transports import Transport
from requests import Session
from requests_pkcs12 import Pkcs12Adapter
from datetime import datetime

# py -m pip install requests-pkcs12
# =========================
# CONFIGURACIÓN
# =========================
PFX_FILE = "D:\CertificadoVERONA DISTRIBUCIONES.pfx"
PASSWORD = "72309943"
WSDL = "https://vpfe-hab.dian.gov.co/WcfDianCustomerServices.svc?wsdl"

# =========================
# SESIÓN CON CERTIFICADO
# =========================
session = Session()
session.mount('https://', Pkcs12Adapter(
    pkcs12_filename=PFX_FILE,
    pkcs12_password=PASSWORD
))

transport = Transport(session=session)
client = Client(wsdl=WSDL, transport=transport)

# =========================
# FACTURAS (SIMULADO)
# =========================
facturas = [
    {"numero": "VR012568", "cufe": "CUFE_1", "fecha": "2026-06-26"},
    {"numero": "VR012569", "cufe": "CUFE_2", "fecha": "2026-06-26"},
]

# =========================
# FILTRAR (HOY o ÚLTIMAS 100)
# =========================

hoy = datetime.today().strftime("%Y-%m-%d")

facturas_hoy = [f for f in facturas if f["fecha"] == hoy]

# Si quieres últimas 100:
facturas_100 = facturas[-100:]

# =========================
# CONSULTAR ESTADO
# =========================

resultado = []

for f in facturas_100:
    try:
        response = client.service.GetStatus(f["cufe"])

        estado = response.StatusDescription  # depende de la respuesta real

        resultado.append({
            "numero": f["numero"],
            "estado": estado
        })

    except Exception as e:
        resultado.append({
            "numero": f["numero"],
            "estado": "ERROR"
        })

# =========================
# MOSTRAR RESULTADO
# =========================

for r in resultado:
    print(f"Factura: {r['numero']} | Estado: {r['estado']}")