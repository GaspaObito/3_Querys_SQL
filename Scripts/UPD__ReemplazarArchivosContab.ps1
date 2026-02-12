<#
Reemplaza todos los archivos que se encuentren de origen a destinos
para Contabilidad

Informe Diario de Caja - Total STD V3

Habilitar Permisos
-Primero Consultar debe estar Restricecd
Get-ExecutionPolicy
-Cambia a Bypass
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
#>

$origenSTD  = "D:\Informacion\Informes Ofimatica\INF_COMPARTIDOS\Informe Diario de Caja - Total STD V3.xlsm"
$origenLPZ  = "D:\Informacion\Informes Ofimatica\INF_COMPARTIDOS\Informe Diario de Caja - Total LPZ V3.xlsm"

$destinosSTD = @(
    "\\26.146.195.209\informes ofimatica\SUPERTODO\2025",# LIZETTE FLOREZ
    "\\26.75.138.26\informes ofimatica\BESTPRICE",# ANGIE QUINTERO
    "\\26.11.60.111\Informes Ofimatica\2025\Supertodo",# CAMILA GUAUTA
    "\\26.60.74.76\Informes Ofimatica\SUPERTODO",#ESTEFANY ESCOBAR
    "\\26.55.88.252\Informes Ofimatica\2025",# PAULA VARGAS
    "\\26.189.121.219\Informes Ofimatica\2025",# SAMIRA GONZALEZ
    "\\192.168.19.22\Informes Ofimatica\SUPERTODO\2025",# ANGIE HIGUERA
    "\\26.223.56.166\Informes Ofimatica\2025\SUPERTODO"# CRISTINA CASTELLANOS
    "\\26.13.47.47\Informes Ofimatica\SUPERTODO"# PAULA RICARDO
    "\\COLNOTEXNT7\Informes Ofimatica\Supertodo\Informes Ofimatica Lea Niddam\2025" # LEA NIDDAN
)

$destinosLPZ = @(
    "\\26.146.195.209\informes ofimatica\BESTPRICE\2025",# LIZETTE FLOREZ
    "\\26.75.138.26\informes ofimatica\SUPERTODO",# ANGIE QUINTERO
    "\\26.11.60.111\Informes Ofimatica\2025\BESTPRICE",# CAMILA GUAUTA
    "\\26.60.74.76\Informes Ofimatica\BESTPRICE",#ESTEFANY ESCOBAR
    "\\26.55.88.252\Informes Ofimatica\2025",# PAULA VARGAS
    "\\26.189.121.219\Informes Ofimatica\2025",# SAMIRA GONZALEZ
    "\\192.168.19.22\Informes Ofimatica\BESTPRICE\2025",# ANGIE HIGUERA
    "\\26.223.56.166\Informes Ofimatica\2025\BESTPRICE",# CRISTINA CASTELLANOS
    "\\26.13.47.47\Informes Ofimatica\BESTPRICE"# PAULA RICARDO
    "\\COLNOTEXNT7\Informes Ofimatica\Supertodo\Informes Ofimatica Lea Niddam\2025" # LEA NIDDAN
)
foreach ($destino in $destinosSTD) {
    if (Test-Path $destino) {
        Copy-Item $origenSTD $destino -Force
    } else {
        Write-Host "No accesible: $destino"
    }
}

foreach ($destino in $destinosLPZ) {
    if (Test-Path $destino) {
        Copy-Item $origenLPZ $destino -Force
    } else {
        Write-Host "No accesible: $destino"
    }
}

Read-Host -Prompt "Press Enter to continue"