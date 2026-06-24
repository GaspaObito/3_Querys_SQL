use CONTROL_OFIMAEnterprise
update mtusuario
set PASSWORD ='VR1201181*'
where codusuario = 'MULTCACJ1'

---INACTIVO y *INACTIVO*
use CONTROL_OFIMAEnterprise
update mtusuario
set TELEFONO ='ACTIVO'
where codusuario = 'PAOLAM'

use CONTROL_OFIMAEnterprise
select *  from mtusuario where nombre like '%jose%'

--CODUSUARIO like '%carolina%'  nombre like '%Juan%'

SELECT 
    CAST(M.FECHAMVTO AS DATE) AS Dia, 
	SUM(M.VALOR) AS CAMBIOS_O_DEVOLUCIONES,
MONTH(M.FECHAMVTO) AS Mes
FROM 
	MvCuadre AS M
	WHERE M.MEDIOPAG='97' AND M.TIPODCTO in('F2','B2') and M.FECHAMVTO >'01-01-2024'
GROUP BY 
    CAST(M.FECHAMVTO AS DATE), M.FECHAMVTO 
ORDER BY 
    Dia;

SELECT 
    CAST(T.Fecha AS DATE) AS Dia, 
    SUM(T.BRUTO) AS TotalPorDia,
	MONTH(T.Fecha) AS Mes,
	COUNT(T.nrodcto) AS Totalfacturasxdia
FROM 
    Trade as T
	WHERE T.TIPODCTO in ('B2') AND T.TIPODCTO NOT IN ('PD','F3') and T.Fecha >'01-01-2024'
GROUP BY 
    CAST(T.Fecha AS DATE),T.Fecha
ORDER BY 
    Dia;