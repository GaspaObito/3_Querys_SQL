SELECT        NRODCTO, BRUTO- DESCUENTO, IVABRUTO, BRUTO + IVABRUTO - DESCUENTO AS total, 'trade' from TRADE where nrodcto IN ('469') and ORIGEN='FAC' and tipodcto='25'
select sum(VALUNID*CANVENTA)as bruto,sum(VALUNID*CANVENTA)*19/100 as iva,sum(VALUNID*CANVENTA)+sum(VALUNID*CANVENTA)*19/100,'mvtrade' from MVTRADE where nrodcto IN ('469') and ORIGEN='FAC' and tipodcto='25'
SELECT VALORBRUTO,VALORIVA,TOTALFACTURA,'CABECERA2' FROM CABECERA2 WHERE FOLIO=469 and prefijo='25'
--SELECT        NRODCTO, BRUTO, IVABRUTO, BRUTO + IVABRUTO AS total from TRADE where nrodcto IN ('386') and tipodcto='Fe' 
select sum(parcial)as BRUTO, sum(parcial)*19/100 AS IVA, sum(parcial)+sum(parcial)*19/100 AS total_factura,'DETALLE2' from DETALLE2 where Folio=469 and prefijo='25'

SELECT        NRODCTO, BRUTO- DESCUENTO, IVABRUTO, BRUTO + IVABRUTO - DESCUENTO AS total, 'trade' from TRADE where ORIGEN='FAC' and tipodcto='25'

use VERONASAS
update MVTRADE
set
PORETE='2.50',
CODRETE='49'
WHERE        (NRODCTO IN ('385', '382','386')) AND (TIPODCTO = 'PD') AND (ORIGEN = 'FAC')*/

select * from MVTRADE where nrodcto IN ('469') and ORIGEN='FAC' and tipodcto='25'
select * from DETALLE2 where Folio=469 and prefijo='25'

SELECT NRODCTO, BRUTO, IVABRUTO, BRUTO + IVABRUTO  AS total, 'trade' from TRADE where nrodcto IN ('469') and ORIGEN='FAC' and tipodcto='25'
select sum(VALORUNIT*CANVENTA)as bruto,sum(VALORUNIT*CANVENTA)*19/100 as iva,sum(VALORUNIT*CANVENTA)+sum(VALORUNIT*CANVENTA)*19/100,'mvtrade' from MVTRADE where nrodcto IN ('469') and ORIGEN='FAC' and tipodcto='25'