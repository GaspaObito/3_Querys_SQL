update m
set 
	m.DESCRIPCIO = a.DESCRIPCIO,
	m.CODLINEA = a.CODLINEA,
	m.CODSBLIN = a.CODSBLIN
From MtMercia m
Inner Join AAAMtmercia$ a ON a.CODIGO=m.CODIGO