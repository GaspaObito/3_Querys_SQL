USE SUPERTODO
--BUSCAR REFE
select codigo,codbarras,descripcio from MtMercia
where 
DESCRIPCIO like'%ALTAGRACIANO%'
AND DESCRIPCIO like'%BLANCO%'
--COGIO ULTIMO
select codigo,codbarras,descripcio from MtMercia ORDER BY CODIGO DESC