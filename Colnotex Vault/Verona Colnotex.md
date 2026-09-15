___
## Consecutivos:
estos son los identificadores que se les dan
![[Pasted image 20260915083945.png|697]]
para cuando no suban las facturas buscar ***visual fox pro***

````
USE v:\dtecolomb2\datos\vds01\aavv01.dbf
BROWSE
SET FILTER TO Ve_prefijo='VR01'
SET FILTER TO Ve_docto='000005158'

````

___
## Subir Facturas DIAN X Dias

para poderlas subir despues de haber pasado del dia se puede atravez de una FUNCION, 
[fn_DetalleFE2] y [fn_CabeceraFE2]
![[Pasted image 20260915100643.png]]
se encuentran y la idea es que dentro de ese archivo lo que diga 
- **SET FECHAPROCESO=GETDATE()-3**
