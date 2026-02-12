Sub OcultarExceptoUna()
    Dim Hoja As Worksheet
    Dim i As Integer
    
    ' Verifica si hay más de una hoja
    If ThisWorkbook.Sheets.Count > 1 Then
        ' Oculta todas las hojas excepto la primera
        For i = 2 To ThisWorkbook.Sheets.Count
            ThisWorkbook.Sheets(i).Visible = xlSheetHidden
        Next i
    End If
End Sub

Sub AsignarLink()
    Dim btn As Shape
    Dim i As Integer
    
    ' Itera a través de todos los botones
    For i = 1 To 34
        Set btn = ActiveSheet.Shapes("Boton_" & i)
        btn.OnAction = "GestionarBotones"
    Next i
End Sub

Sub GestionarBotones()
    Dim btnName As String
    btnName = Application.Caller
    
    Select Case btnName
        Case "Boton_1"
            Sheets(2).Visible = xlSheetVisible
            Sheets(2).Select
        Case "Boton_2"
            Sheets(3).Visible = xlSheetVisible
            Sheets(3).Select
        Case "Boton_3"
            Sheets(4).Visible = xlSheetVisible
            Sheets(4).Select
        Case "Boton_4"
            Sheets(5).Visible = xlSheetVisible
            Sheets(5).Select
        Case "Boton_5"
            Sheets(6).Visible = xlSheetVisible
            Sheets(6).Select
        Case "Boton_6"
            Sheets(7).Visible = xlSheetVisible
            Sheets(7).Select
        Case "Boton_7"
            Sheets(8).Visible = xlSheetVisible
            Sheets(8).Select
        Case "Boton_8"
            Sheets(9).Visible = xlSheetVisible
            Sheets(9).Select
        Case "Boton_9"
            Sheets(10).Visible = xlSheetVisible
            Sheets(10).Select
        Case "Boton_10"
            Sheets(11).Visible = xlSheetVisible
            Sheets(11).Select
        Case "Boton_11"
            Sheets(12).Visible = xlSheetVisible
            Sheets(12).Select
        Case "Boton_12"
            Sheets(13).Visible = xlSheetVisible
            Sheets(13).Select
        Case "Boton_13"
            Sheets(14).Visible = xlSheetVisible
            Sheets(14).Select
        Case "Boton_14"
            Sheets(15).Visible = xlSheetVisible
            Sheets(15).Select
        Case "Boton_15"
            Sheets(16).Visible = xlSheetVisible
            Sheets(16).Select
        Case "Boton_16"
            Sheets(17).Visible = xlSheetVisible
            Sheets(17).Select
        Case "Boton_17"
            Sheets(18).Visible = xlSheetVisible
            Sheets(18).Select
        Case "Boton_18"
            Sheets(19).Visible = xlSheetVisible
            Sheets(19).Select
        Case "Boton_19"
            Sheets(20).Visible = xlSheetVisible
            Sheets(20).Select
        Case "Boton_20"
            Sheets(21).Visible = xlSheetVisible
            Sheets(21).Select
        Case "Boton_21"
            Sheets(22).Visible = xlSheetVisible
            Sheets(22).Select
        Case "Boton_22"
            Sheets(23).Visible = xlSheetVisible
            Sheets(23).Select
        Case "Boton_23"
            Sheets(24).Visible = xlSheetVisible
            Sheets(24).Select
        Case "Boton_24"
            Sheets(25).Visible = xlSheetVisible
            Sheets(25).Select
        Case "Boton_25"
            Sheets(26).Visible = xlSheetVisible
            Sheets(26).Select
        Case "Boton_26"
            Sheets(27).Visible = xlSheetVisible
            Sheets(27).Select
        Case "Boton_27"
            Sheets(28).Visible = xlSheetVisible
            Sheets(28).Select
        Case "Boton_28"
            Sheets(29).Visible = xlSheetVisible
            Sheets(29).Select
        Case "Boton_29"
            Sheets(30).Visible = xlSheetVisible
            Sheets(30).Select
        Case "Boton_30"
            Sheets(31).Visible = xlSheetVisible
            Sheets(31).Select
        Case "Boton_31"
            Sheets(32).Visible = xlSheetVisible
            Sheets(32).Select
        Case "Boton_32"
            Sheets(33).Visible = xlSheetVisible
            Sheets(33).Select
        Case "Boton_33"
            Sheets(34).Visible = xlSheetVisible
            Sheets(34).Select
        Case "Boton_34"
            Sheets(35).Visible = xlSheetVisible
            Sheets(35).Select
    End Select
End Sub
