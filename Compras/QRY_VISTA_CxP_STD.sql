USE SUPERTODO
SELECT vCxP.NroDcto,vCxP.Dctoprv, vCxP.Tipodcto, vCxP.nit, vCxP.CliNombre,vCxP.fecing, vCxP.FhExp, vCxP.Fhvencim, vCxP.Deuda, vCxP.Pagado, (deuda-pagado) AS 'saldo', vCxP.nota
FROM SUPERTODO.dbo.vCxP vCxP
WHERE (vCxP.Origen='COM')
ORDER BY vCxP.FhExp

select NRODCTO,TIPODCTO,NIT,BRUTO,* from Trade where NRODCTO='7477'
select NRODCTO,TIPODCTO,NIT,BRUTO,* from Trade where NRODCTO='587'