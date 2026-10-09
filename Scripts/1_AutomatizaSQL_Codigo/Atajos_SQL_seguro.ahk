; Atajos SQL seguros para AutoHotkey v1.
; Escriben texto en el editor activo. No abren conexiones ni guardan credenciales.
; Use estos atajos en SSMS, Azure Data Studio o cualquier editor SQL.
; Regla de formato: todos los atajos insertan la consulta organizada por líneas.

; Buscar líneas de una factura. Escriba el número entre las comillas antes de ejecutar.
::ahk_trade::
    SendRaw, USE SUPERTODO
    Send, {Enter}
    SendRaw, SELECT * FROM TRADE WHERE 
return
::ahk_cast::
    SendRaw, select * from MVTO where CODCOMPROB = 'NOM' order by CAST(DCTO AS INT) DESC
return
; Ejemplo de uso:
; Escriba sqlfactura seguido de espacio, tabulación, punto o Enter.
; Después escriba el valor real dentro de las comillas antes de ejecutar la consulta.
