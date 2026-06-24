--costos pt SI envian cierre de cotos pt se procede hacer proceso de factores
USE COLNOTEXSA
update MTMERCIA
set MTMERCIA.COSTO_ING = (select COSTO from AAAACostos_Nov2524$
               where MTMERCIA.CODIGO = AAAACostos_Nov2524$.producto)
where MTMERCIA.CODIGO in (select PRODUCTO from   AAAACostos_Nov2524$)

AFacFeb24$
----factores subir documento echo y procesar
use colnotexsa

update MTMERCIA
set MTMERCIA.COSTO_USDR = (select COSTO_USDR from  AAAFacOct24$
               where MTMERCIA.CODIGO =  AAAFacOct24$.CODIGO)
where MTMERCIA.CODIGO in (select CODIGO from  AAAFacOct24$)

use colnotexsa
update MTMERCIA
set MTMERCIA.FACTORR = (select FACTORR from  AAAFacOct24$
               where MTMERCIA.CODIGO =  AAAFacOct24$.CODIGO)
where MTMERCIA.CODIGO in (select CODIGO from  AAAFacOct24$)

use colnotexsa
update MTMERCIA
set MTMERCIA.COSTO_UFR = (select COSTO_UFR from  AAAFacOct24$
               where MTMERCIA.CODIGO =  AAAFacOct24$.CODIGO)
where MTMERCIA.CODIGO in (select CODIGO from  AAAFacOct24$)

