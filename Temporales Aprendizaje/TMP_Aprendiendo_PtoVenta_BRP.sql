USE BESTPRICE;
Select * From Trade  WHERE NRODCTO='28508' AND NIT='132048148' ORDER BY FECHA DESC;
Select * From Mvtrade WHERE NRODCTO='28508' ORDER BY FECHA DESC;
Select * from MvCuadre WHERE DCTO='28508';
Select * from MtMedPag;
Select * from MtProcli WHERE NIT='132048148';
Select * from MtMercia;
UPDATE Trade SET MEDIOPAG='97' WHERE NRODCTO='28508';

USE veronasas;
SELECT name,max_column_id_used
FROM sys.tables ORDER BY name ASC;

Select COUNT(*) from sys.tables;
Select * from sys.tables;
SELECT 
	tp.NOMBRE,tr.NRODCTO,tr.NIT,tr.FECHA,tr.PASSWORDIN,
	mc.DCTO,mc.COMENTARIO,mc.MEDIOPAG,mc.ORIGEN
FROM 
	trade AS tr
INNER JOIN
	MvCuadre AS mc ON mc.DCTO=tr.NRODCTO AND tr.ORIGEN=mc.ORIGEN 
INNER JOIN
	MtProcli AS tp ON tp.NIT=tr.NIT 
WHERE
	tr.NRODCTO='35212';


