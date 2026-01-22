Sub AutoRELLENAR()
    Dim ws As Worksheet
    Dim ultimaFila As Long
    
    'TRADE
    Sheets("AAATRADE").Select
    Set ws = ThisWorkbook.Sheets("AAATRADE")
    
    ' Encuentra la última fila con datos en la columna B
    ultimaFila = ws.Cells(ws.Rows.Count, "R").End(xlUp).Row
    ultimaFila = ultimaFila
    
    Range("A2:Q3").Select
    Selection.AutoFill Destination:=Range("A2:Q" & (ultimaFila))
    Range("S2:BM3").Select
    Selection.AutoFill Destination:=Range("S2:BM" & (ultimaFila))
    Range("BO2:BW3").Select
    Selection.AutoFill Destination:=Range("BO2:BW" & (ultimaFila))
    Range("BZ2:CP3").Select
    Selection.AutoFill Destination:=Range("BZ2:CP" & (ultimaFila))
    Range("CR2:CY3").Select
    Selection.AutoFill Destination:=Range("CR2:CY" & (ultimaFila))
    Range("DA2:DE3").Select
    Selection.AutoFill Destination:=Range("DA2:DE" & (ultimaFila))
    Range("DG2:DQ3").Select
    Selection.AutoFill Destination:=Range("DG2:DQ" & (ultimaFila))
    Range("DS2:DU3").Select
    Selection.AutoFill Destination:=Range("DS2:DU" & (ultimaFila))
    Range("DZ2:ED3").Select
    Selection.AutoFill Destination:=Range("DZ2:ED" & (ultimaFila))
    Range("EF2:IL3").Select
    Selection.AutoFill Destination:=Range("EF2:IL" & (ultimaFila))
    Range("EF2:IL3").Select
    Selection.AutoFill Destination:=Range("EF2:IL" & (ultimaFila))
    
    
     'MVTRADE
    Sheets("AAAMVTRADE").Select
    Set ws = ThisWorkbook.Sheets("AAAMVTRADE")

    ' Encuentra la última fila con datos en la columna B
    ultimaFila = ws.Cells(ws.Rows.Count, "K").End(xlUp).Row
    ultimaFila = ultimaFila

    Range("A2:J3").Select
    Selection.AutoFill Destination:=Range("A2:J" & (ultimaFila))
    Range("L2:M3").Select
    Selection.AutoFill Destination:=Range("L2:M" & (ultimaFila))
    Range("O2:Z3").Select
    Selection.AutoFill Destination:=Range("O2:Z" & (ultimaFila))
    Range("AB2:AI3").Select
    Selection.AutoFill Destination:=Range("AB2:AI" & (ultimaFila))
    Range("AL2:AN3").Select
    Selection.AutoFill Destination:=Range("AL2:AN" & (ultimaFila))
    Range("AQ2:BK3").Select
    Selection.AutoFill Destination:=Range("AQ2:BK" & (ultimaFila))
    Range("BM2:BO3").Select
    Selection.AutoFill Destination:=Range("BM2:BO" & (ultimaFila))
    Range("BQ2:BQ3").Select
    Selection.AutoFill Destination:=Range("BQ2:BQ" & (ultimaFila))
    Range("BS2:BX3").Select
    Selection.AutoFill Destination:=Range("BS2:BX" & (ultimaFila))
    Range("BZ2:CC3").Select
    Selection.AutoFill Destination:=Range("BZ2:CC" & (ultimaFila))
    Range("CE2:CW3").Select
    Selection.AutoFill Destination:=Range("CE2:CW" & (ultimaFila))
    Range("CY2:DB3").Select
    Selection.AutoFill Destination:=Range("CY2:DB" & (ultimaFila))
    Range("DE2:DR3").Select
    Selection.AutoFill Destination:=Range("DE2:DR" & (ultimaFila))
    Range("DU2:DU3").Select
    Selection.AutoFill Destination:=Range("DU2:DU" & (ultimaFila))
    Range("DZ2:DZ3").Select
    Selection.AutoFill Destination:=Range("DZ2:DZ" & (ultimaFila))
    
    
    'CUADRE
    Sheets("AAAMVCUADRE").Select
    Set ws = ThisWorkbook.Sheets("AAAMVCUADRE")

    ' Encuentra la última fila con datos en la columna B
    ultimaFila = ws.Cells(ws.Rows.Count, "N").End(xlUp).Row
    ultimaFila = ultimaFila

    Range("A2:M3").Select
    Selection.AutoFill Destination:=Range("A2:M" & (ultimaFila))
    Range("P2:P3").Select
    Selection.AutoFill Destination:=Range("P2:P" & (ultimaFila))
    Range("S2:W3").Select
    Selection.AutoFill Destination:=Range("S2:W" & (ultimaFila))
    Range("Y2:AF3").Select
    Selection.AutoFill Destination:=Range("Y2:AF" & (ultimaFila))
    
    'DEVUELTAS
    Sheets("AAAMVDEVUELTAS").Select
    Set ws = ThisWorkbook.Sheets("AAAMVDEVUELTAS")

    ' Encuentra la última fila con datos en la columna B
    ultimaFila = ws.Cells(ws.Rows.Count, "N").End(xlUp).Row
    ultimaFila = ultimaFila

    Range("A2:M3").Select
    Selection.AutoFill Destination:=Range("A2:M" & (ultimaFila))
    Range("P2:P3").Select
    Selection.AutoFill Destination:=Range("P2:P" & (ultimaFila))
    Range("S2:W3").Select
    Selection.AutoFill Destination:=Range("S2:W" & (ultimaFila))
    Range("Y2:AF3").Select
    Selection.AutoFill Destination:=Range("Y2:AF" & (ultimaFila))

End Sub
