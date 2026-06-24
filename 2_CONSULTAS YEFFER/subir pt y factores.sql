USE COLNOTEXSA
update MTMERCIA
set MTMERCIA.COSTO_ING = (select COSTO from AAAACostos_Sept3924$
               where MTMERCIA.CODIGO = AAAACostos_Sept3924$.producto)
where MTMERCIA.CODIGO in (select PRODUCTO from   AAAACostos_Sept3924$)

AFacFeb24$

use colnotexsa

update MTMERCIA
set MTMERCIA.COSTO_USDR = (select COSTO_USDR from  AFacFeb24$
               where MTMERCIA.CODIGO =  AFacFeb24$.CODIGO)
where MTMERCIA.CODIGO in (select CODIGO from  AFacFeb24$)

use colnotexsa
update MTMERCIA
set MTMERCIA.FACTORR = (select FACTORR from  AFacFeb24$
               where MTMERCIA.CODIGO =  AFacFeb24$.CODIGO)
where MTMERCIA.CODIGO in (select CODIGO from  AFacFeb24$)

use colnotexsa
update MTMERCIA
set MTMERCIA.COSTO_UFR = (select COSTO_UFR from  AFacFeb24$
               where MTMERCIA.CODIGO =  AFacFeb24$.CODIGO)
where MTMERCIA.CODIGO in (select CODIGO from  AFacFeb24$)
