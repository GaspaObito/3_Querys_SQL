SELECT 
    CAST(Fecha AS DATE) AS Dia, 
    SUM(T.BRUTO) AS TotalPorDia,
	MONTH(T.Fecha) AS Mes
FROM 
    Trade as T
	WHERE T.TIPODCTO in ('F2','B2') AND T.TIPODCTO NOT IN ('PD','F3') and T.Fecha >'01-06-2024'
GROUP BY 
    CAST(Fecha AS DATE),T.Fecha
ORDER BY 
    Dia;
----POR EL MOMENTO ESTA OK
SELECT 
    CAST(Fecha AS DATE) AS Dia, 
    SUM(ROUND(T.NVALUNID,2)) AS TotalPorDia,
	MONTH(T.Fecha) AS Mes,
	SUM(ROUND(T.COSTO,2)) AS Totalcostos 
FROM 
    Mvtrade as T
	WHERE T.TIPODCTO in ('F2','B2') AND T.TIPODCTO NOT IN ('PD','F3') and T.Fecha >'01-06-2024'
GROUP BY 
    CAST(Fecha AS DATE),T.Fecha
ORDER BY 
    Dia;

SELECT TOP(200)* FROM Trade 
--- PRUEBAS
SELECT 
    CAST(Fecha AS DATE) AS Dia, 
    SUM(ROUND(T.NVALUNID,2))*SUM(T.CANVENTA) AS TotalPorDia,
	MONTH(T.Fecha) AS Mes,
	SUM(ROUND(T.COSTO,2))*SUM(T.CANVENTA) AS Totalcostos,
	((SUM(ROUND(T.NVALUNID,2))*SUM(T.CANVENTA)-SUM(ROUND(T.COSTO,2))*SUM(T.CANVENTA))/SUM(ROUND(T.NVALUNID,2))*SUM(T.CANVENTA))*100 AS MargenBruto
	
FROM 
    Mvtrade as T
	WHERE T.TIPODCTO in ('F2','B2') AND T.TIPODCTO NOT IN ('PD','F3') and T.Fecha >'01-07-2024'
GROUP BY 
    CAST(Fecha AS DATE),T.Fecha
ORDER BY 
    Dia;
--formula para sacar la mb en sql server
((net_sales - cost_of_sales) / net_sales) * 100 AS MargenBruto