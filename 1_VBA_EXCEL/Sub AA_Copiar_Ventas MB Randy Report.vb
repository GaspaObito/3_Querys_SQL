Sub COPIAR_INFORMACION()
    Dim ArchivoZigma As String
    Dim ArchivoInforme As String
    ArchivoInforme = "Ventas y MB Resumen Enero 2026 RNY.xlsm"
    ArchivoZigma = "venta 14-01-2026.XLS" 'CAMBIAR NOMBRE DEACUERDO AL NOMBRE DEL ARCHIVO
    
    Workbooks.Open Filename:= _
        "D:\Informacion\Informes Ofimatica\RNY\" + ArchivoZigma ' Cambia la dirección según la ubicación del archivo en el usuario
    
    Windows(ArchivoZigma).Activate
    'ELIMINA ENCABEZADO
    Rows("1:7").Select
    Selection.Delete Shift:=xlUp
    Range("A1").Select
    
    Range(Selection, Selection.End(xlDown)).Select
    
    'ELIMINA COSTOS
    Selection.Find(What:="Costo", After:=ActiveCell, LookIn:=xlFormulas2, _
        LookAt:=xlPart, SearchOrder:=xlByRows, SearchDirection:=xlNext, _
        MatchCase:=False, SearchFormat:=False).Activate
    Selection.FindNext(After:=ActiveCell).Activate
    ActiveCell.Replace What:="Costo", Replacement:="", LookAt:=xlPart, _
        SearchOrder:=xlByRows, MatchCase:=False, SearchFormat:=False, _
        ReplaceFormat:=False, FormulaVersion:=xlReplaceFormula2

    'PRODUCTO
    Windows(ArchivoZigma).Activate
    Range("A2").Select
    Range(Selection, Selection.End(xlDown)).Select
    Selection.Copy
    
    Windows(ArchivoInforme).Activate
    Range("B8").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
        
    'CANTIDAD VENDIDA
    Windows(ArchivoZigma).Activate
    Range("G2").Select
    Range(Selection, Selection.End(xlDown)).Select
    Selection.Copy
    
    Windows(ArchivoInforme).Activate
    Range("C8").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
        
    'VENTA TOTAL ITBIS
    Windows(ArchivoZigma).Activate
    Range("I2").Select
    Range(Selection, Selection.End(xlDown)).Select
    Selection.Copy
    
    Windows(ArchivoInforme).Activate
    Range("E8").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
        
    'DESCUENTO
    Windows(ArchivoZigma).Activate
    Range("K2").Select
    Range(Selection, Selection.End(xlDown)).Select
    Selection.Copy
    
    Windows(ArchivoInforme).Activate
    Range("F8").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
        
    'COMISION
    Windows(ArchivoZigma).Activate
    Range("M2").Select
    Range(Selection, Selection.End(xlDown)).Select
    Selection.Copy
    
    Windows(ArchivoInforme).Activate
    Range("G8").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
        
    'APLICADOS - ITBIS
    Windows(ArchivoZigma).Activate
    Range("O2").Select
    Range(Selection, Selection.End(xlDown)).Select
    Selection.Copy
    
    Windows(ArchivoInforme).Activate
    Range("H8").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
        
    'DE VENTA
    Windows(ArchivoZigma).Activate
    Range("Q2").Select
    Range(Selection, Selection.End(xlDown)).Select
    Selection.Copy
    
    Windows(ArchivoInforme).Activate
    Range("K8").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
        
    'DE VENTA
    Windows(ArchivoZigma).Activate
    Range("S2").Select
    Range(Selection, Selection.End(xlDown)).Select
    Selection.Copy
    
    Windows(ArchivoInforme).Activate
    Range("L8").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
        
    'CIERRA Y NO GUARDA ARCHIVO
    Application.CutCopyMode = False
    Workbooks(ArchivoZigma).Close saveChanges:=False
End Sub
