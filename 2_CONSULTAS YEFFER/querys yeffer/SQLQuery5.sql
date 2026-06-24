select m.codprecio,m.codproduc,m.unidad,c.codigo, c.UNIDADMED from AAAPRECIO15082025$ as m, MTMERCIA as c where m.CODPRODUC=c.CODIGO

SELECT 
    m.codprecio,
    m.codproduc,
    m.unidad,
    c.codigo,
    c.UNIDADMED
FROM 
    AAAPRECIO15082025$ AS m
JOIN 
    MTMERCIA AS c
    ON m.CODPRODUC = c.CODIGO
WHERE 
    m.UNIDAD <> c.UNIDADMED;