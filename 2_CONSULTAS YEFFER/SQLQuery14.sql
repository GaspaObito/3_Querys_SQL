SELECT 
    CAST(Fecha AS DATE) AS Dia, 
    SUM(T.BRUTO) AS TotalPorDia,
	MONTH(T.Fecha) AS Mes,
	COUNT(T.nrodcto) AS Totalfacturasxdia
FROM 
    Trade as T
	WHERE T.TIPODCTO in ('F2','B2') AND T.TIPODCTO NOT IN ('PD','F3') and T.Fecha >'01-01-2024'
GROUP BY 
    CAST(Fecha AS DATE),T.Fecha
ORDER BY 
    Dia;

select * from Trade where fecha='03-01-2024' and TIPODCTO in ('F2','B2')

SELECT        FECHA, MONTH(FECHA) AS Mes, VALOR, DIA, TASAVEN
FROM            MTCAMBIO
WHERE        (FECHA > '01-01-2024')

SELECT * FROM Trade WHERE TIPODCTO in ('F2','B2') AND TIPODCTO NOT IN ('PD','F3') and Fecha >'01-01-2024'
SELECT * FROM MvCuadre