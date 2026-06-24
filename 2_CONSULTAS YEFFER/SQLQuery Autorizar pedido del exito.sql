/*
Autorizar pedido del exito 
*/


use COLNOTEXSA
update trade 
set AUTORIZA='1'
WHERE        (NRODCTO = '0022049040') AND (TIPODCTO = 'PD')
