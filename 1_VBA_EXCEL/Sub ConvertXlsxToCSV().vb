Sub ConvertXlsxToCSV()
    
    Dim ws As Worksheet
    Dim rootpath As String
    Dim wbPath As String
    Dim i As Long
    
    wbPath = ActiveWorkbook.Path
    Application.DisplayAlerts = False
    'Pasa por cada Hoja Trade MvTrade MvCuadre MvCuadreDevueltas
    For i = 1 To 4
        Sheets(i).Select
        Set ws = ActiveSheet
        SheetName = ws.Name
        'Exportamos las Hojas a CSV
        rootpath = wbPath & "\" & SheetName & ".csv"
        ThisWorkbook.Sheets(i).Copy
        ActiveWorkbook.SaveAs Filename:=rootpath, FileFormat:=xlCSVUTF8
        ActiveWorkbook.Close
    Next
        Application.DisplayAlerts = True
        
End Sub
