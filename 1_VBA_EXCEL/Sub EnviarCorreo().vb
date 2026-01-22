Sub EnviarCorreo()
    
    Range("C5").Select
    Sheets(1).Select
    'Guarda libro con los cambios hechos
    ThisWorkbook.Save
    
    'Declara variables
    Dim OutlookApp As Object
    Dim Correo As Object
    Dim archivo As String
    Dim rango As String
    Dim asunto As String
    Dim fechaHora As String
    Dim contenido As String
    Dim celda As Range
    
    ' Define el archivo
    archivo = ThisWorkbook.FullName
    
    ' Genera el asunto del correo
    fechaHora = Format(Now, "yyyy-mm-dd HH:mm:ss")
    asunto = ThisWorkbook.Name & " - " & fechaHora
    
    ' Crea la instancia de Outlook
    Set OutlookApp = CreateObject("Outlook.Application")
    Set Correo = OutlookApp.CreateItem(0)
    
    Dim valor As Double
    
    valor = Sheets("Gerencial x UEN").Range("D38").Value
    
    ' Inicializa la variable de contenido
    contenido = "Buen Dia," & vbCrLf & "Este es un correo enviado automáticamente. Adjunto encuentra el archivo detallado. " & vbCrLf & "Venta a la fecha: $" & Format(valor, "#,##0")
    
    ' Configura el correo
    With Correo
        .To = "pohlgiss@colnotex.com;anaranjo@colnotex.com" ' Cambia esto al correo del destinatario
        .BCC = "jalvarez@colnotex.com;srodriguez@colnotex.com"
        '.CC = "jalvarez@colnotex.com"
        .Subject = asunto
        .Body = contenido ' Asigna el contenido acumulado al cuerpo
        .Attachments.Add archivo
        .Send ' Envía el correo
    End With
    
    ' Limpiar
    Set Correo = Nothing
    Set OutlookApp = Nothing
    
    Application.OnTime Now + TimeValue("00:02:00"), Procedure:="CerrarLibro"
End Sub

Sub CerrarLibro()
    ThisWorkbook.Save
    Application.Quit
End Sub

