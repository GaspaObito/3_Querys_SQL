Sub Z_EJECUTAR_INFORME()
    Application.Run "'Informe de ingresos compras (LP_ST).xlsm'!Z_Actualizar_informe"
    
    Application.Run "'Informe de ingresos compras (LP_ST).xlsm'!ZZ_Generar_Archivo_Enviar"
    
    'Ubicar Inicio
    Sheets(1).Select
    Range("A1").Select
    
    'Guarda libro con los cambios hechos
    ThisWorkbook.Save
    
    Application.Run "'Informe de ingresos compras (LP_ST) Actualizado.xlsm'!EnviarCorreo"
    
End Sub
    
Sub ZZ_Generar_Archivo_Enviar()
    ' Abre el archivo donde se pegará la información
    Workbooks.Open Filename:= _
        "D:\Informacion\Informes Ofimatica\LPZ\Informe de ingresos compras (LP_ST) Actualizado.xlsm"  ' Cambia la dirección según la ubicación del archivo en el usuario
    
    For i = 1 To 2
        ' Activa la ventana del archivo desde donde se copiará la información
        Windows("Informe de ingresos compras (LP_ST).xlsm").Activate
        
        ' Selecciona la hoja desde donde se copiará la información
        Sheets(i).Select  ' Cambiar Hoja a reemplazar
        
        ' Selecciona todas las celdas en la hoja desde donde se copiará la información
        Cells.Select
        
        ' Copia todas las celdas seleccionadas
        Selection.Copy
        
        ' Activa la ventana del archivo donde se pegará la información
        Windows("Informe de ingresos compras (LP_ST) Actualizado.xlsm").Activate
        
        ' Selecciona la hoja donde se pegará la información
        Sheets(i).Select  ' Cambiar Hoja a reemplazar
        
        ' Selecciona todas las celdas en la hoja donde se pegará la información
        Cells.Select
        
        ' Pega todas las celdas copiadas en la hoja destino
        ActiveSheet.Paste
        
        ' Selecciona la celda A1
        Range("A1").Select
    Next
    ' Activa la ventana del archivo desde donde se copiará la información
    Windows("Informe de ingresos compras (LP_ST).xlsm").Activate
        
    'Copia los archivos en formato plano
    Range("Tabla_Consulta_desde_SUPERTODO4").Select
    Selection.Copy
    
    ' Activa la ventana del archivo donde se pegará la información
    Windows("Informe de ingresos compras (LP_ST) Actualizado.xlsm").Activate
    
    'Selecciona la ubicacion a pegar
    Sheets(2).Select
    Range("B5").Select
    
    'Pega los archivos planos
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
End Sub
