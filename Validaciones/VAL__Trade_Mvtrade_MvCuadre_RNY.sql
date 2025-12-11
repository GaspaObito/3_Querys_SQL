--Facturas REPORTE 
USE ZIGMAFISCAL
--CONSULTA DE TICKETS DE CAJA RNY TRADE ===========================================
SELECT 
	TICKET,status,FECHA, CONVERT(time(0), fecha_hora) AS HORA,
	CAJA,NCF_Fijo,NCF_Secuencia,TOTAL AS MONTO,
	ITBIS,GRABADO,EXENTO,(GRABADO+EXENTO)AS BRUTO,
	DESCUENTO,RNC,nombre AS PROVEEDOR
FROM 
	Montos_Ticket  
WHERE 
	FECHA BETWEEN '01-06-2025' AND '30-6-2025' AND status IN ('FAC') AND CAJA='2'
ORDER BY TICKET DESC
select * from Montos_Ticket ORDER BY TICKET ASC

--CONSULTA DE TICKETS DE CAJA RNY MVTRADE ===========================================
SELECT 
	ticket AS TICKET,fecha AS FECHA,producto AS PRODUCTO,descripcion AS DESCRIPCION,
	cantidad AS CANTIDAD,precio AS PRECIO,itbis AS ITBIS,total_itbis AS TOTAL_ITBIS,costo AS COSTO,
	Descuento AS DESCUENTO,cantidad*precio AS TOTAL 
FROM ticket
WHERE 
	FECHA BETWEEN '01-06-2025' AND '30-6-2025'
ORDER BY TICKET DESC
select * from Ticket
--CONSULTA DE TICKETS DE CAJA RNY MVCUADRE ===========================================
SELECT 
	ticket AS TICKET,fecha AS FECHA,forma AS MTPAGO,pagado AS PAGADO,devuelta AS DEVUELTA,
	pagado-devuelta AS RECIBIDO 
FROM 
	Formas_Pago_Ticket 
WHERE 
	FECHA BETWEEN '01-06-2025' AND '30-6-2025'
ORDER BY ticket DESC
select * from Formas_Pago_Ticket
