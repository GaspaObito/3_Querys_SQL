use COLNOTEXSA
SELECT 
    t.name AS Tabla,
    SUM(p.rows) AS Total_Registros
FROM 
    sys.tables t
INNER JOIN 
    sys.partitions p ON t.object_id = p.object_id
WHERE 
    p.index_id IN (0, 1) AND t.name LIKE'%MT%' -- 0 = heap, 1 = clustered index
GROUP BY 
    t.name
ORDER BY 
    Total_Registros DESC;

use VERONASAS
SELECT 
    t.name AS Tabla,
    SUM(p.rows) AS Total_Registros
FROM 
    sys.tables t
INNER JOIN 
    sys.partitions p ON t.object_id = p.object_id
WHERE 
    p.index_id IN (0, 1) AND t.name LIKE'%MT%' -- 0 = heap, 1 = clustered index
GROUP BY 
    t.name
ORDER BY 
    Total_Registros DESC;

select sum(cantidad) from mvtrade where nrodcto='67' and tipodcto='pd'