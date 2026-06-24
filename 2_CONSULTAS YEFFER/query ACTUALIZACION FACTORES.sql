-----SCRIPT ACTUALIZACION FACTORES
use colnotexsa

update MTMERCIA
set MTMERCIA.COSTO_USDR = (select COSTO_USDR from  AFacEne24$
               where MTMERCIA.CODIGO =  AFacEne24$.CODIGO)
where MTMERCIA.CODIGO in (select CODIGO from  AFacEne24$)

use colnotexsa
update MTMERCIA
set MTMERCIA.FACTORR = (select FACTORR from  AFacEne24$
               where MTMERCIA.CODIGO =  AFacEne24$.CODIGO)
where MTMERCIA.CODIGO in (select CODIGO from  AFacEne24$)

use colnotexsa
update MTMERCIA
set MTMERCIA.COSTO_UFR = (select COSTO_UFR from  AFacEne24$
               where MTMERCIA.CODIGO =  AFacEne24$.CODIGO)
where MTMERCIA.CODIGO in (select CODIGO from  AFacEne24$)