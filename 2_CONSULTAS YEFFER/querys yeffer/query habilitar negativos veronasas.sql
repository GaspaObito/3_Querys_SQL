use VERONASAS
update mtglobal
set Valor ='N'
WHERE        (DESCRIPCIO LIKE '%cero%') AND (CAMPO = 'FACCANT ')
/*Si los controle*/
use VERONASAS
update mtglobal
set Valor ='S'
WHERE        (DESCRIPCIO LIKE '%cero%') AND (CAMPO = 'FACCANT ')

/*Verificar*/
use VERONASAS
select descripcio, memo, validacion, valor from mtglobal
WHERE        (DESCRIPCIO LIKE '%cero%') AND (CAMPO = 'FACCANT ')