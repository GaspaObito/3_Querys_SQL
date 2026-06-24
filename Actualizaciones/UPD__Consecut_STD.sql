USE SUPERTODO
select * from Consecut where CODIGOCONS='CO012'
update consecut set CONSECUT='1737' where CODIGOCONS='CO012'
select NRODCTO from Trade where TIPODCTO='OR' order by CAST(NRODCTO AS int) DESC
