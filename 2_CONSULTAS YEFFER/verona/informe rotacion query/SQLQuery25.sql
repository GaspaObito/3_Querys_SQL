SELECT 
    CAST(Fecha AS DATE) AS Dia, 
    SUM(T.BRUTO) AS TotalPorDia,
	MONTH(T.Fecha) AS Mes,
	COUNT(T.nrodcto) AS Totalfacturasxdia
FROM 
    Trade as T
	WHERE T.TIPODCTO in ('NC') AND T.ORIGEN='FAC' AND T.TIPODCTO NOT IN ('PD','F3') and T.Fecha >'01-01-2026'
GROUP BY 
    CAST(Fecha AS DATE),T.Fecha
ORDER BY 
    Dia;