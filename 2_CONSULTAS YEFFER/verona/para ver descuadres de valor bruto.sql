SELECT        NRODCTO, BRUTO, IVABRUTO, BRUTO + IVABRUTO AS total from TRADE where nrodcto IN ('320') and tipodcto='Fe' 
USE VERONASAS
select * from MVTRADE where nrodcto IN ('386') and tipodcto='Fe' 


--select * from MVTRADE where tipodcto='F1' and fecha >'01-04-2025' and fecha <'01-05-2025'

use VERONASAS
SELECT* FROM DETALLE2 WHERE FOLIO=356 
SELECT        NRODCTO, BRUTO- DESCUENTO, IVABRUTO, BRUTO + IVABRUTO - DESCUENTO AS total from TRADE where nrodcto IN ('176') and ORIGEN='FAC' and tipodcto='25'
select sum(VALUNID*CANVENTA)as bruto,sum(VALUNID*CANVENTA)*19/100 as iva,sum(VALUNID*CANVENTA)+sum(VALUNID*CANVENTA)*19/100 from MVTRADE where nrodcto IN ('176') and ORIGEN='FAC' and tipodcto='25'
SELECT VALORBRUTO,VALORIVA,TOTALFACTURA FROM CABECERA2 WHERE FOLIO=176 and prefijo='25'
--SELECT        NRODCTO, BRUTO, IVABRUTO, BRUTO + IVABRUTO AS total from TRADE where nrodcto IN ('386') and tipodcto='Fe' 
select sum(parcial)as BRUTO, sum(parcial)*19/100 AS IVA, sum(parcial)+sum(parcial)*19/100 AS total_factura from DETALLE2 where Folio=176 and prefijo='25'

select BODEGA, CANTIDAD, CANTORIG, CANVENTA as Cantidad_Real, FECHA,nit, NOMBRE, NPEDIDO,NRODCTO,PRODUCTO, VALORUNIT, VALUNID, VLRVENTA as Valor_Real,XVALUNID, IVA from mvtrade where NRODCTO='333' and tipodcto='25' --AND PRODUCTO='M-00009'

--sum(parcial)*19/100 AS IVA, sum(parcial)+sum(parcial)*19/100 AS total_factura  IVA ANTERIOR 3582309.89

select * from mtmercia where codigo in ('M-00370')

select * from MVPRECIO where CODPRODUC in ('41301007')

use VERONASAS

update MVTRADE
set 
VALORUNIT=VLRVENTA,
VALUNID=VLRVENTA
where nrodcto IN ('759') and tipodcto='F3' and origen='com'

select * from mvtrade where tipodcto='FE' AND NPEDIDO='283'

select * from MTMERCIA

select * FROM CABECERA2

SELECT        NRODCTO, BRUTO, IVABRUTO, BRUTO + IVABRUTO AS total,DESCUENTO from TRADE where nrodcto IN ('489') and ORIGEN='FAC' and tipodcto='25'
select sum(VLRVENTA*CANVENTA)as bruto,sum(VLRVENTA*CANVENTA)*19/100 as iva,sum(VLRVENTA*CANVENTA)+sum(VLRVENTA*CANVENTA)*19/100 from MVTRADE where nrodcto IN ('489') and ORIGEN='FAC' and tipodcto='25'
select sum(VALORUNIT*CANVENTA)as bruto,sum(VALORUNIT*CANVENTA)*19/100 as iva,sum(VALORUNIT*CANVENTA)+sum(VALORUNIT*CANVENTA)*19/100 from MVTRADE where nrodcto IN ('489') and ORIGEN='FAC' and tipodcto='25'
select sum(VALUNID*CANTIDAD)as bruto,sum(VALUNID*CANTIDAD)*19/100 as iva,sum(VALUNID*CANTIDAD)+sum(VALUNID*CANTIDAD)*19/100 from MVTRADE where nrodcto IN ('489') and ORIGEN='FAC' and tipodcto='25'

select *from TRADE where nrodcto IN ('399') and ORIGEN='FAC' and tipodcto='FE' 