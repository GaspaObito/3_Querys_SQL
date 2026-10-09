@echo off
setlocal

set "PYTHON=C:\Users\Josea\AppData\Local\Programs\Python\Python313\python.exe"
set "SCRIPT=D:\Informacion\3_Querys_SQL\Scripts\Extraer_Info_Xlsx_VISUALDTE\1_QRY_datosdianvisual V3.py"
set "LOG=D:\Informacion\3_Querys_SQL\Scripts\Extraer_Info_Xlsx_VISUALDTE\1_Salida_datosdianvisual.txt"

echo.>> "%LOG%"
echo ===== INICIO: %date% %time% =====>> "%LOG%"

"%PYTHON%" "%SCRIPT%" >> "%LOG%" 2>&1

set "CODIGO=%ERRORLEVEL%"
echo ===== FIN: %date% %time% | Codigo: %CODIGO% =====>> "%LOG%"

exit /b %CODIGO%