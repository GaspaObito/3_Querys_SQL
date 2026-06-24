SELECT* FROM CABECERA2 WHERE FOLIO=19
SELECT* FROM CABECERA2 WHERE FOLIO=100005
SELECT* FROM DETALLE2 WHERE FOLIO=19
SELECT* FROM DETALLE2 WHERE FOLIO=100005
--select sum(parcial)AS VALORBRUTODETALLE, (sum(parcial)*19/100) AS VALORIVADETALLE, (select sum(parcial)+(sum(parcial)*19/100))  from Detalle2 where Folio=224
select sum(parcial) from Detalle2 where Folio=19
select sum(parcial) from Detalle2 where Folio=100005

