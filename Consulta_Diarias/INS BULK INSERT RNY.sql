/*
SUBIR POR METODO BULK INSERT
de donde va a tomar la informacion
FROM 'D:\Informacion\Informes Ofimatica\RANDY\Ventas Subidas de Randy a Ofimatica\2026-01 Enero\2026-01-16\AAAMVTRADE.csv'
FROM 'D:\bulk insert\\AAAMVTRADE.csv'
cuando se vaya a usar texto en español se debe de especificar el formato, y FIELDQUOTE, para salto de linea LF 
*/
USE SUPERTODO
BULK INSERT trade
FROM 'D:\bulk insert\AAATRADE.csv'
WITH (
   FIELDTERMINATOR = ',', -- Delimitador de campos
   ROWTERMINATOR = '\n', -- Delimitador de filas
   FIRSTROW = 2 -- Opcional: Saltar encabezados
);
BULK INSERT mvtrade
FROM 'D:\bulk insert\AAAMVTRADE.csv'
WITH (
   FORMAT = 'CSV',
   FIELDTERMINATOR = ',', -- Delimitador de campos
   ROWTERMINATOR = '0x0a', -- Delimitador de filas
   FIELDQUOTE = '"', -- Texto Cuando alla comas en Nombre tiene en cuenta ""
   FIRSTROW = 2, -- Saltar encabezados
   CODEPAGE = '65001' -- UTF-8
);
BULK INSERT mvcuadre
FROM 'D:\bulk insert\AAAMVCUADRE.csv'
WITH (
   FIELDTERMINATOR = ',', -- Delimitador de campos
   ROWTERMINATOR = '\n', -- Delimitador de filas
   KEEPNULLS,
   FIRSTROW = 2 -- Opcional: Saltar encabezados
);
BULK INSERT mvcuadre
FROM 'D:\bulk insert\AAAMVDEVUELTAS.csv'
WITH (
   FIELDTERMINATOR = ',', -- Delimitador de campos
   ROWTERMINATOR = '\n', -- Delimitador de filas
   KEEPNULLS,
   FIRSTROW = 2 -- Opcional: Saltar encabezados
);
/*
select * from trade where FECHA BETWEEN '24-04-2026' AND '27-04-2026' 
select * from Mvtrade where FECHA='15-01-2026'
select * from MvCuadre where FECING='15-01-2026'

USE SUPERTODO
delete MvCuadre where FECING BETWEEN '01-07-2025' AND '31-07-2025' AND TIPODCTO IN ('R2','R1','R4')
update Mvtrade set BODEGA='0',PRODUCTO='A-00001' where FECHA BETWEEN '01-07-2025' AND '31-07-2025' AND TIPODCTO IN ('R2','R1','R4')
delete Mvtrade where FECHA BETWEEN '01-07-2025' AND '31-07-2025' AND TIPODCTO IN ('R2','R1','R4')
delete Trade where FECHA BETWEEN '01-07-2025' AND '31-07-2025' AND TIPODCTO IN ('R2','R1','R4')

--ACT CODINT
update Trade set CODINT='0' where TIPODCTO='F2' and NOTA like '%RNY%' and CODINT='428'
select * from Trade where TIPODCTO='F2' and NOTA like '%RNY%' and CODINT='428'
*/