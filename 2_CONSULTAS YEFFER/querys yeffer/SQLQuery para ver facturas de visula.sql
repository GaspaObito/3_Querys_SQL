select * from CABECERA2 where folio IN ('38')
select * from detalle2 where folio IN ('38')
select sum(parcial),sum(parcial)*19/100  from detalle2 where folio='38'