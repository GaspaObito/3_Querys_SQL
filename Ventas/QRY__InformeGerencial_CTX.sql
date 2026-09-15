use COLNOTEXSA
--QUERY COMPLETA INFORME GERENCIAL
select dctomae,factura,fecha,tipovta,NomTipoVta,nit,CliNombre,Bruto/1000 AS BRUTO,Neto,codven,VenNombre,MONTH(fecha) AS MES,YEAR(fecha) AS ANO,Descuento,nota,NomTipoVta,VTIPOUEN.NOMBRE
from vComerFac INNER JOIN
VTIPOUEN ON VTIPOUEN.CODIGO=vComerFac.TIPOVTA
WHERE DCTOMAE IN('FA','FR','NC','ND') AND fecha >='01/01/2026' AND fecha <='31/12/2026' AND origen='FAC' AND Factura not in ('137581','137582')
ORDER BY Factura DESC
--select Dctomae from vComerFac WHERE DCTOMAE IN('FA','FR','NC','ND') group by Dctomae

use COLNOTEXSA

select * from MTUEN
select * from vComerFac WHERE Factura='140393'
--Bruto,Descuento,Ivabruto,Factura,Neto,dctoprv,Dctomae,fecha,fecmod,hora,nota,tipovta,CliNombre,CuentaCli


select TOP(1)TIPOVTA,* from TRADE WHERE TIPOVTA IN ('0-060')

select TOP(1)TIPOVTA,* from TRADE WHERE TIPOVTA IN ('0-035')

select * from TIPOVTA