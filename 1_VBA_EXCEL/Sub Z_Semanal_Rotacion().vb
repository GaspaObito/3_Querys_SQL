Sub ActualizaSemanalColumna()

Dim SemanaInicial As Integer
Dim ColInicio As Long
Dim ColActual As Long

SemanaInicial = 32

Sheets("Rotacion").Select
Columns("BM:EB").Hidden = True
'MsgBox DatePart("ww", Date)

ColInicio = Range("EB1").Column
ColActual = ColInicio - (DatePart("ww", Date) - SemanaInicial)

If ColActual >= Range("BM1").Column Then
    Range(Cells(1, ColActual), Cells(1, ColInicio)).EntireColumn.Hidden = False
End If
End Sub
