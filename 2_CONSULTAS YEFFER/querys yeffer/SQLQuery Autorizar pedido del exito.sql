/*
Autorizar pedido del exito 
*/


use VERONASAS
update trade 
set AUTORIZA='1'
WHERE        (NRODCTO in ('9216151')) AND (TIPODCTO = 'PD')

use COLNOTEXSA
update trade 
set AUTORIZA='1'
WHERE        (NRODCTO = '03022026') AND (TIPODCTO = 'PD')
use VERONASAS
select * from trade where NRODCTO='91741517' and TIPODCTO = 'PD'