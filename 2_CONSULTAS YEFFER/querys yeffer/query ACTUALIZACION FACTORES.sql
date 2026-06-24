-----SCRIPT ACTUALIZACION FACTORES
use colnotexsa

update MTMERCIA
set MTMERCIA.COSTO_USDR = (select COSTO_USDR from  AFacMarzo24$
               where MTMERCIA.CODIGO =  AFacMarzo24$.CODIGO)
where MTMERCIA.CODIGO in (select CODIGO from  AFacMarzo24$)

use colnotexsa
update MTMERCIA
set MTMERCIA.FACTORR = (select FACTORR from  AFacMarzo24$
               where MTMERCIA.CODIGO =  AFacMarzo24$.CODIGO)
where MTMERCIA.CODIGO in (select CODIGO from  AFacMarzo24$)

use colnotexsa
update MTMERCIA
set MTMERCIA.COSTO_UFR = (select COSTO_UFR from  AFacMarzo24$
               where MTMERCIA.CODIGO =  AFacMarzo24$.CODIGO)
where MTMERCIA.CODIGO in (select CODIGO from  AFacMarzo24$)