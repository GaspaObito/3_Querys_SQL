select * from cabecerads where folio IN ('1985','1984')
select * from detalleds where folio IN ('1985')
select sum(parcial) from detalleds where folio='10055'