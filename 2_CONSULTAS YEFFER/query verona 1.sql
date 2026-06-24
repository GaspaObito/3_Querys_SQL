SELECT a.NRODCTO,a.FECHA, a.PRODUCTO, a.NOMBRE,a.CANTORIG, a.COSTO ,a.TIPODCTO, b.nit,c.nombre, d.codbarras
FROM mvtrade a INNER JOIN
     trade b ON a.nrodcto = b.nrodcto and b.tipodcto ='F1' inner join
	 mtprocli c on c.nit = b.nit inner join
	 MTMERCIA d on a.producto = d.codigo
WHERE (a.TIPODCTO='F1') AND (a.FECHA>=getdate()-120)
ORDER BY a.FECHA, a.NRODCTO
--query para sacar data de colnotex a verona
use COLNOTEXSA
SELECT  a.NRODCTO,a.npedido, b.NIT, a.FECHA, a.PRODUCTO, a.NOMBRE,CONCAT(TRIM(a.NRODCTO),A.PRODUCTO) AS CODIGO, B.NOTA, a.CANTORIG, a.VALORUNIT
FROM mvtrade a INNER JOIN
     trade b ON a.nrodcto = b.nrodcto and b.tipodcto ='FA' inner join
	 mtprocli c on c.nit = b.nit inner join
	 MTMERCIA d on a.producto = d.codigo
WHERE (a.TIPODCTO='FA') AND (a.FECHA>=getdate()-120) AND B.NIT LIKE '%901391810%'
ORDER BY a.FECHA, a.NRODCTO

SELECT * FROM MVTRADE where TIPODCTO='F1'
USE VERONASAS
SELECT  a.NRODCTO,b.NIT, a.FECHA, a.PRODUCTO, a.NOMBRE,CONCAT(TRIM(a.NRODCTO),A.PRODUCTO) AS CODIGO, B.NOTA, a.CANTORIG, a.VALORUNIT 
FROM mvtrade a INNER JOIN
     trade b ON a.nrodcto = b.nrodcto and b.tipodcto ='PD' inner join
	 mtprocli c on c.nit = b.nit inner join
	 MTMERCIA d on a.producto = d.codigo
WHERE (a.TIPODCTO='PD') AND (a.FECHA>=getdate()-120) 
ORDER BY a.FECHA, a.NRODCTO

select * from MVTRADE where TIPODCTO='PD' and FECHA>=getdate()-120 AND NRODCTO='6000002'

select * from TRADE where TIPODCTO='PD' and FECHA>=getdate()-120