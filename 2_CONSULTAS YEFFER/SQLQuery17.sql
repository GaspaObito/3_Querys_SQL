select NRODCTO, FECHA, TIPODCTO from trade where fecha >'21-11-2024' and tipodcto='B2'


SELECT 
    CAST(T.Fecha AS DATE) AS Dia, 
    SUM(T.BRUTO) AS TotalPorDia,
     T.TIPODCTO,
	MONTH(T.Fecha) AS Mes,
	COUNT(T.nrodcto) AS Totalfacturasxdia
FROM 
    Trade as T
	WHERE T.TIPODCTO in ('F2') AND T.TIPODCTO NOT IN ('PD','F3') and T.Fecha >'01-01-2024'
GROUP BY 
    CAST(T.Fecha AS DATE),T.Fecha, T.TIPODCTO
ORDER BY 
    Dia;
USE BESTPRICE
select * from trade where nrodcto='1001' and tipodcto='B2'
select * from MvCuadre where dcto='2865' 
