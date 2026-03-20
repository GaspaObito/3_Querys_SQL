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
select * from trade where FECHA='15-01-2026'
select * from Mvtrade where FECHA='15-01-2026'
select * from MvCuadre where FECING='15-01-2026'
delete from Trade where FECHA='15-01-2026'
delete from Mvtrade where FECING='19-01-2026'
delete from MvCuadre where FECING='15-01-2026'
*/