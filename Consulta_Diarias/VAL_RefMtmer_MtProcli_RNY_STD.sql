USE SUPERTODO
--MTMERCIA
select codigo,codbarras,descripcio from MtMercia
where 
DESCRIPCIO like'%BIZCOCHO%'
AND DESCRIPCIO like'%VAINILLA%'
--A ULTIMA
--select codigo,codbarras,descripcio from MtMercia WHERE CODIGO like'A-%' ORDER BY CODIGO DESC

--MTPROCLI
--select NOMBRE,NIT from MtProcli WHERE NOMBRE LIKE '%INVERSI%' and NOMBRE LIKE '%San%'