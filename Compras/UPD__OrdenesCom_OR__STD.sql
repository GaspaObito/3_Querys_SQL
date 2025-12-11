/* 
Modulo Compras:
Funciona en Ordenes de Compra al momento de generar una factura de orden
esta se consulta en "Facturas" y las que aparecen no se deseen usar se hace
una depuracion 0 que basicamente es igualar los campos CANTIDAD y CANVENTA
a 0, CANTORIG sirve a manera de Original o Dato Inicial para saber el valor que
tenia al comienzo, si se desea restaurar deben ser igual CANT..CANV a CANTORIG
*/
USE SUPERTODO
select * from Mvtrade where TIPODCTO='OR' AND ORIGEN='COM'

--PARA ORDENES DE COMPRA DEPURACION 0
update Mvtrade 
SET 
	CANTIDAD='0', CANVENTA='0' 
FROM 
	Mvtrade 
WHERE 
	TIPODCTO='OR' AND ORIGEN='COM'