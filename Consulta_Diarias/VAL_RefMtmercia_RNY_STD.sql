USE SUPERTODO
--BUSCAR REFE
select codigo,codbarras,descripcio from MtMercia
where 
DESCRIPCIO like'%FORELLI%'
AND DESCRIPCIO like'%SALTINES%'
--COGIO ULTIMO
--select codigo,codbarras,descripcio from MtMercia WHERE CODIGO like'A-%' ORDER BY CODIGO DESC