use BESTPRICE
select count(CODIGO) as TOTAL_BESTPRICE from MtMercia 

use SUPERTODO
select count(CODIGO) AS TOTAL_SUPERTODO from MtMercia 


use SUPERTODO
select codigo, descrip2, DESCRIPCIO from MtMercia where codigo like '%A-%'

use BESTPRICE
select codigo, descrip2, DESCRIPCIO from MtMercia where codigo like '%A-%'

use BESTPRICE
select codigo, descrip2, DESCRIPCIO from MtMercia where codigo IN ('A-01903')

use SUPERTODO
select codigo, descrip2, DESCRIPCIO from MtMercia where codigo IN ('A-01903')

-- Datos que están en COLNOTEX pero no en VERONA pt
SELECT *
FROM (SELECT  codigo as COD_NO_ESTA_vERONA, DESCRIPCIO
FROM COLNOTEXSA.dbo.MTMERCIA WHERE HABILITADO='1' AND  (CODTARIVA = 'TAR1')
EXCEPT
SELECT codigo, DESCRIPCIO
FROM VERONASAS.dbo.MTMERCIA WHERE  HABILITADO='1'AND  (CODTARIVA = 'TAR1')) AS Diferencias  

SELECT *
FROM (SELECT  codigo as COD_NO_ESTA_std, DESCRIPCIO
FROM BESTPRICE.dbo.MTMERCIA WHERE (CODIGO Like '%A-%') AND (CODTARIVA = 'TAR1')
EXCEPT
SELECT codigo, DESCRIPCIO
FROM SUPERTODO.dbo.MTMERCIA WHERE (CODIGO Like '%A-%')AND (CODTARIVA = 'TAR1')) AS Diferencias