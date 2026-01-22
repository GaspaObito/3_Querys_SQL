Sub Z_EJECUTAR_INFORME()
    Call Z_Informe_GerencialCTX
        
    Call ZZ_Generar_Archivo_Enviar
    
    'Guarda libro con los cambios hechos
    ThisWorkbook.Save

    Application.Run "'Informe Gerencial CTX Actualizado.xlsm'!EnviarCorreo"
End Sub

Sub ZZ_Generar_Archivo_Enviar()
    ' Abre el archivo donde se pegará la información
    Workbooks.Open Filename:= _
        "D:\Informacion\Informes Ofimatica\CTX\Informe Gerencial CTX Actualizado.xlsm"  ' Cambia la dirección según la ubicación del archivo en el usuario
    
    For i = 1 To 4 ' Cantidad De Hojas a Copiar
        ' Activa la ventana del archivo desde donde se copiará la información
        Windows("Informe Gerencial CTX.xlsm").Activate
        
        ' Selecciona la hoja desde donde se copiará la información
        Sheets(i).Select  ' Cambiar Hoja a reemplazar
        
        ' Selecciona todas las celdas en la hoja desde donde se copiará la información
        Cells.Select
        
        ' Copia todas las celdas seleccionadas
        Selection.Copy
        
        ' Activa la ventana del archivo donde se pegará la información
        Windows("Informe Gerencial CTX Actualizado.xlsm").Activate
        
        ' Selecciona la hoja donde se pegará la información
        Sheets(i).Select  ' Cambiar Hoja a reemplazar
        
        ' Selecciona todas las celdas en la hoja donde se pegará la información
        Cells.Select
        
        ' Pega todas las celdas copiadas en la hoja destino
        Selection.PasteSpecial Paste:=xlPasteAll, Operation:=xlNone, SkipBlanks:= _
            False, Transpose:=False
        
        ' Selecciona la celda A1
        Range("A1").Select
    Next
End Sub
