SELECT vCxP.NroDcto, vCxP.Dctoprv, vCxP.Tipodcto, vCxP.nit, vCxP.CliNombre, vCxP.FhExp, vCxP.Fhvencim, vCxP.Deuda,vCxP.Pagado, (deuda-pagado) AS 'saldo', vCxP.nota
FROM VERONASAS.dbo.vCxP vCxP
WHERE (vCxP.Origen='COM') 
ORDER BY vCxP.FhExp 