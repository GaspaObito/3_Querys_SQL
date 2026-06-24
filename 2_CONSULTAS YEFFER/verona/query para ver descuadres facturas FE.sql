select * from DETALLE2 where Folio=416 and prefijo='FE' 
SELECT        NRODCTO, BRUTO, IVABRUTO, BRUTO + IVABRUTO AS total,DESCUENTO from TRADE where nrodcto IN ('416') and ORIGEN='FAC' and tipodcto='FE'
select sum(VLRVENTA*CANVENTA)as bruto,sum(VLRVENTA*CANVENTA)*19/100 as iva,sum(VLRVENTA*CANVENTA)+sum(VLRVENTA*CANVENTA)*19/100 from MVTRADE where nrodcto IN ('416') and ORIGEN='FAC' and tipodcto='FE'
select sum(VLRVENTA*CANTORIG)as bruto,sum(VLRVENTA*CANTORIG)*19/100 as iva,sum(VLRVENTA*CANTORIG)+sum(VLRVENTA*CANTORIG)*19/100 from MVTRADE where nrodcto IN ('416') and ORIGEN='FAC' and tipodcto='FE'
select sum(VALORUNIT*CANVENTA)as bruto,sum(VALORUNIT*CANVENTA)*19/100 as iva,sum(VALORUNIT*CANVENTA)+sum(VALORUNIT*CANVENTA)*19/100 from MVTRADE where nrodcto IN ('416') and ORIGEN='FAC' and tipodcto='FE'
select sum(VALUNID*CANTIDAD)as bruto,sum(VALUNID*CANTIDAD)*19/100 as iva,sum(VALUNID*CANTIDAD)+sum(VALUNID*CANTIDAD)*19/100 from MVTRADE where nrodcto IN ('416') and ORIGEN='FAC' and tipodcto='FE'

------query visualdte
SELECT VALORBRUTO,VALORIVA,TOTALFACTURA FROM CABECERA2 WHERE FOLIO=417 and prefijo='FE'
--SELECT        NRODCTO, BRUTO, IVABRUTO, BRUTO + IVABRUTO AS total from TRADE where nrodcto IN ('386') and tipodcto='Fe' 
select sum(parcial)as BRUTO, sum(parcial)*19/100 AS IVA, sum(parcial)+sum(parcial)*19/100 AS total_factura from DETALLE2 where Folio=417 and prefijo='FE'
