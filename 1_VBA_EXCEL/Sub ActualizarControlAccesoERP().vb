Sub ActualizarControlAccesoERP()
    Dim tb As Variant
    Dim i As Long
    
    ' Mostrar hojas ============
    Sheets("CJ Clasifica").Visible = True
    Sheets("CJ ClientXCont").Visible = True
    Sheets("CJ Bodegas").Visible = True
    Sheets("Grupos Usuarios ").Visible = True
    Sheets("Grupos Empresas").Visible = True
    Sheets("Grupos Modulo").Visible = True
    Sheets("Grupos Existentes").Visible = True
        
    'Actualiza Hojas ============
    For i = 5 To 11
        ' Selecciona la hoja
        Sheets(i).Select
        ' Selecciona la celda A1
        Range("A1").Select
        Selection.ListObject.QueryTable.Refresh BackgroundQuery:=False
    Next
    Sheets("CJ ClientXCont").Select
    Range("E1").Select
    Selection.ListObject.QueryTable.Refresh BackgroundQuery:=False
    
    'Actualiza TB Dinamicas ============
    tb = Array("General_Usuario", "General_Modulo", "General_Empresa", "Cajas_STDLPZ")
    For i = 0 To UBound(tb)
        Sheets(i + 1).PivotTables(tb(i)).PivotCache.Refresh
    Next i

    'Ocultar Hojas ============
    Sheets(Array("CJ Clasifica", "CJ ClientXCont", "CJ Bodegas", "Grupos Usuarios ", _
        "Grupos Empresas", "Grupos Modulo", "Grupos Existentes")).Select
    ActiveWindow.SelectedSheets.Visible = False
    
    'Aplica Formato ============
    Call FormatoTablasDinamica
End Sub


