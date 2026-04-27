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
	FECHA BETWEEN '01-06-2025' AND '30-12-2026' AND status IN ('FAC') AND TICKET='95044'
ORDER BY TICKET DESC
select * from Montos_Ticket ORDER BY TICKET ASC

--CONSULTA DE TICKETS DE CAJA RNY MVTRADE ===========================================
SELECT 
	ticket AS TICKET,caja,fecha AS FECHA,producto AS PRODUCTO,descripcion AS DESCRIPCION,
	cantidad AS CANTIDAD,precio AS PRECIO,itbis AS ITBIS,total_itbis AS TOTAL_ITBIS,costo AS COSTO,
	Descuento AS DESCUENTO,cantidad*precio AS TOTAL 
FROM ticket
WHERE 
	FECHA BETWEEN '01-06-2025' AND '30-6-2026' AND TICKET='95044'
ORDER BY TICKET DESC
select * from Ticket
--CONSULTA DE TICKETS DE CAJA RNY MVCUADRE ===========================================
SELECT 
	ticket AS TICKET,CAJA,fecha AS FECHA,forma AS MTPAGO,pagado AS PAGADO,devuelta AS DEVUELTA,
	pagado-devuelta AS RECIBIDO 
FROM 
	Formas_Pago_Ticket 
WHERE 
	FECHA BETWEEN '01-06-2025' AND '30-6-2026' AND TICKET='95044'
ORDER BY ticket DESC
select * from Formas_Pago_Ticket

--CONSULTA DE NOTAS CREDITO RNY TRADE ===========================================
select dev_numero AS TICKET,dev_fecha AS FECHA,ticket_caja AS CAJA,NCF_Fijo,NCF_Secuencia,dev_total*-1 AS MONTO,dev_itbis*-1 AS ITBIS,(dev_total-dev_itbis)*-1 AS BRUTO,
dev_descuento AS DESCUENTO,dev_nombre AS PROVEEDOR,dev_hora AS HORA,ticket_cajero AS CAJERO#,u.usu_nombre AS USUARIO,NCF AS NCF_AFECTADO from Devolucion d
INNER JOIN Usuarios u ON u.usu_codigo=d.ticket_cajero

--CONSULTA DE NOTAS CREDITO RNY MVTRADE ===========================================
select dev_numero AS TICKET,pro_codigo AS PRODUCTO,pro_nombre AS DESCRIPCION,dev_cantidad AS CANTIDAD,
dev_precio AS PRECIO,dev_itbis AS ITBIS,dev_costo AS COSTO,
dev_descuento AS DESCUENTO,(dev_precio*dev_cantidad) AS TOTAL from Det_Devolucion

--CONSULTA DE CLIENTES RNY ===========================================
select cli_nombre,cli_rnc from Clientes WHERE cli_nombre like '%DOLCE VITA DE L A G%'
UNION ALL
select sup_nombre,sup_rnc from Proveedores

select * from Usuarios