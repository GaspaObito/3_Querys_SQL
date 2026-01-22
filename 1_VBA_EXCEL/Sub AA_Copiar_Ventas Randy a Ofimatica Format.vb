Public ArchivoInforme As String
Public ArchivoReferencias As String

Sub AA_COPIAR_RANDY_SHEET_OFIMATICA()
    ArchivoInforme = "Data BD ZigmaFiscal RNY 2026-01-15 OFIMATICA CJ2.xlsm"
    ArchivoReferencias = "Data BD ZigmaFiscal RNY 2026-01-15 RANDY CJ2.xlsx"
    
    Call COPIAR_INFORMACION_TRADE
    Call COPIAR_INFORMACION_MVTRADE
    Call COPIAR_INFORMACION_MVCUADRE
    Call COPIAR_INFORMACION_MVCUADRE_DEVUELTAS
End Sub
Sub COPIAR_INFORMACION_TRADE()

    ' CREA VARIABLES POR LIBRO
    Set wbInforme = Workbooks(ArchivoInforme)
    Set wbReferencias = Workbooks(ArchivoReferencias)
    ' Seleccionar la hoja del primer libro
    wbInforme.Sheets("AAATRADE").Activate
    ' Seleccionar la hoja del segundo libro
    wbReferencias.Sheets("TRADE").Activate
    
    'NIT EN NIT
    Windows(ArchivoReferencias).Activate
    Range("S2").Select
    Range(Selection, Selection.End(xlDown)).Select
    Selection.Copy
    
    Windows(ArchivoInforme).Activate
    Range("DR2").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
        
    'TICKET EN NOTAS
    Windows(ArchivoReferencias).Activate
    Range("P2").Select
    Range(Selection, Selection.End(xlDown)).Select
    Selection.Copy
    
    Windows(ArchivoInforme).Activate
    Range("DV2").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    
    'STATUS A ORIGEN
    Windows(ArchivoReferencias).Activate
    Range("B2").Select
    Range(Selection, Selection.End(xlDown)).Select
    Selection.Copy
    
    Windows(ArchivoInforme).Activate
    Range("EE2").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    
    'DESCUENTO A DESCUENTO
    Windows(ArchivoReferencias).Activate
    Range("L2").Select
    Range(Selection, Selection.End(xlDown)).Select
    Selection.Copy
    
    Windows(ArchivoInforme).Activate
    Range("BN2").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
        
    'FECHACREACION A FECHA
    Windows(ArchivoReferencias).Activate
    Range("C2").Select
    Range(Selection, Selection.End(xlDown)).Select
    Selection.Copy
    
    Windows(ArchivoInforme).Activate
    Range("BX2").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
        
     Range("BY2").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    'ITBIS A IVA
    Windows(ArchivoReferencias).Activate
    Range("H2").Select
    Range(Selection, Selection.End(xlDown)).Select
    Selection.Copy
    
    Windows(ArchivoInforme).Activate
    Range("CZ2").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    
    'MEDPAG A MEDIOPAG
    Windows(ArchivoReferencias).Activate
    Range("R2").Select
    Range(Selection, Selection.End(xlDown)).Select
    Selection.Copy
    
    Windows(ArchivoInforme).Activate
    Range("DF2").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
        
    'NCF_SECUENCIA A NRODCTO
    Windows(ArchivoReferencias).Activate
    Range("F2").Select
    Range(Selection, Selection.End(xlDown)).Select
    Selection.Copy
    
    Windows(ArchivoInforme).Activate
    Range("DY2").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
        
    'BRUTO A BRUTO
    Windows(ArchivoReferencias).Activate
    Range("K2").Select
    Range(Selection, Selection.End(xlDown)).Select
     Selection.Copy
    
    Windows(ArchivoInforme).Activate
    Range("R2").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
          
    'TIPODCTO A TIPODCTO
    Windows(ArchivoReferencias).Activate
    Range("Q2").Select
    Range(Selection, Selection.End(xlDown)).Select
     Selection.Copy
    
    Windows(ArchivoInforme).Activate
    Range("FS2").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
        
    'SoloHora A HORA
    Windows(ArchivoReferencias).Activate
    Range("O2").Select
    Range(Selection, Selection.End(xlDown)).Select
    Selection.Copy
    
    Windows(ArchivoInforme).Activate
    Range("CQ2").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
                
End Sub


