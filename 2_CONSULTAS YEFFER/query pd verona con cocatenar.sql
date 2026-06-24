SELECT  a.NRODCTO,a.FECHA, a.PRODUCTO, a.NOMBRE,CONCAT(TRIM(a.NRODCTO),A.PRODUCTO) AS CODIGO, a.CANTORIG, a.COSTO 
FROM mvtrade a INNER JOIN
     trade b ON a.nrodcto = b.nrodcto and b.tipodcto IN ('PD') inner join
	 mtprocli c on c.nit = b.nit inner join
	 MTMERCIA d on a.producto = d.codigo
WHERE (a.TIPODCTO IN('PD')) AND (a.FECHA>=getdate()-120) 
ORDER BY a.FECHA, a.NRODCTO

SELECT a.TIPODCTO, b.nit,c.nombre,a.NRODCTO,a.FECHA, d.codbarras,a.PRODUCTO, a.NOMBRE, CONCAT(TRIM(a.NRODCTO),A.PRODUCTO) AS CODIGO, a.CANTORIG
FROM mvtrade a INNER JOIN
     trade b ON a.nrodcto = b.nrodcto and b.tipodcto ='PD' inner join
	 mtprocli c on c.nit = b.nit inner join
	 MTMERCIA d on a.producto = d.codigo
WHERE (a.TIPODCTO='PD') AND (a.FECHA>=getdate()-120)
ORDER BY a.FECHA, a.NRODCTO

--- QUERY ORIGINAL
SELECT a.TIPODCTO, b.nit,c.nombre,a.NRODCTO,a.FECHA, d.codbarras,a.PRODUCTO, a.NOMBRE, a.CANTORIG
FROM mvtrade a INNER JOIN
     trade b ON a.nrodcto = b.nrodcto and b.tipodcto ='PD' inner join
	 mtprocli c on c.nit = b.nit inner join
	 MTMERCIA d on a.producto = d.codigo
WHERE (a.TIPODCTO='PD') AND (a.FECHA>=getdate()-30)
ORDER BY a.FECHA, a.NRODCTO