-- Datos que están en COLNOTEX pero no en VERONA pt
SELECT *
FROM (SELECT  nrodcto as COD_NO_ESTA_VERONA
FROM COLNOTEXSA.dbo.TRADE 
EXCEPT
SELECT nrodcto
FROM VERONASAS.dbo.TRADE ) AS Diferencias



SELECT *
FROM (SELECT  nrodcto as COD_NO_ESTA_VERONA
FROM VERONASAS.dbo.TRADE
EXCEPT
SELECT nrodcto
FROM COLNOTEXSA.dbo.TRADE ) AS Diferencias

use VERONASAS
select count(nrodcto)as totalverona from TRADEMAS
use COLNOTEXSA
select count(nrodcto) as totalcolnotex from TRADEMAS

use VERONASAS
select count(*)as totalverona from AHCOSTOS
use COLNOTEXSA
select count(*) as totalcolnotex from AHCOSTOS