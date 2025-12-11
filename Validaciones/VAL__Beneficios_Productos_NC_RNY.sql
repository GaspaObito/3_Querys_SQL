--CONSULTA PARA VER LOS BENEFICIOS ZIGMA ===========================================
USE ZigmaFiscal
select * from ticket WHERE FECHA='02-09-2025' AND descripcion='AGUA EVIAN 1.5L'
--BENEFICIO REPORTE DE ZIGMA x FECHA ============================
SELECT 
    producto,
    descripcion,
    SUM(cantidad) AS CANT_VENDIDA,
    SUM((precio * cantidad) * (1 - Descuento/100)) AS TOTAL_PRECIO,
    SUM((precio * cantidad)*(Descuento/100)) AS DESCUENTO,
    SUM((precio * cantidad) * (1 - Descuento/100)) * (itbis/100) AS IMPUESTOS,
    SUM(costo * cantidad) AS COSTO_VENTA,
    SUM(((precio * cantidad) * (1 - Descuento/100)) - (costo * cantidad) - ((precio * cantidad) * (1 - Descuento/100)) * (itbis/100)) AS BENEF_BRUTO
FROM ticket
WHERE 
    fecha = '03-09-2025' AND producto <>'9410'
GROUP BY producto, descripcion, itbis
ORDER BY DESCRIPCION ASC;
-- ============================
SELECT 
	TICKET,status,FECHA,CAJA,NCF_Fijo,NCF_Secuencia,
	TOTAL AS MONTO,ITBIS,GRABADO,EXENTO,(GRABADO+EXENTO)AS BRUTO,
	DESCUENTO,RNC,nombre AS PROVEEDOR 
FROM 
	Montos_Ticket  
WHERE 
	 STATUS ='FAC' AND NCF_Fijo='B02' AND NCF_Secuencia IS NOT NULL
ORDER BY TICKET DESC

select * from Ticket WHERE descripcion= ' LAYS LIMON 110GR' AND FECHA='13-09-2025'

--BENEFICIOS VENTA ==============================================
select fecha,descripcion,SUM(cantidad),SUM(cantidad*precio) AS TOTAL,SUM((cantidad*precio)*(Descuento/100)) AS DESCUENTO,
ROUND(SUM((cantidad*precio)-((cantidad*precio)*(Descuento/100))),2) AS DESCUENTO
from Ticket WHERE fecha='01-08-2025' GROUP BY fecha,descripcion ORDER BY descripcion ASC

--NOTAS CREDITOS NCF_fijo NCF_Secuencia =========================
select * from Montos_Ticket WHERE ticket='32963' ORDER BY TICKET ASC

--TODOS LOS PRODUCTOS ===========================================
select * from Productos
select * from RNC