use BESTPRICE
select * from trade where tipodcto='F1' AND ORIGEN='COM'
ORDER BY FECHA ASC
select nrodcto, codint, dctoprv, FECHA, idintegra, INTEGRADO, ORIGEN, PASSWORDMO AS USUARIO_QUE_INTEGRO from Trade where tipodcto='F1' AND ORIGEN='COM' and FECHA >='01-07-2024' AND FECHA <='31-07-2024'
ORDER BY FECHA ASC