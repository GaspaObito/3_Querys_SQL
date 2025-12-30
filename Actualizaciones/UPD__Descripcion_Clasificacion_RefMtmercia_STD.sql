USE SUPERTODO
select m.codigo,m.DESCRIPCIO,a.DESCRIPCIO,m.CODLINEA,a.CODLINEA,m.CODSBLIN,a.CODSBLIN,
CASE 
        WHEN m.DESCRIPCIO = a.DESCRIPCIO THEN 1
        ELSE 0
    END AS SonIguales
From MtMercia m
Inner Join aaamtmercia$ a ON a.CODIGO=m.CODIGO

/*update m
set 
	m.DESCRIPCIO = a.DESCRIPCIO,
	m.CODLINEA = a.CODLINEA,
	m.CODSBLIN = a.CODSBLIN
From MtMercia m
Inner Join AAAMtmercia$ a ON a.CODIGO=m.CODIGO*/