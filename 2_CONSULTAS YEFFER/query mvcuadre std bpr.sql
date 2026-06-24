SELECT MvCuadre.BANCO, MvCuadre.BANCODEST, MvCuadre.BANCOORI, MvCuadre.BENEF, MvCuadre.CODBANCO, MvCuadre.CODCHQDEV, MvCuadre.CODESTADO, MvCuadre.CODPLAZA, MvCuadre.CODTARJETA, MvCuadre.COMENTARIO, MvCuadre.CTACHEQUE, MvCuadre.CTADEST, MvCuadre.CTAORI, MvCuadre.DCTO, MvCuadre.FACTURA, MvCuadre.FECHACHQ, MvCuadre.FECHAMVTO, MvCuadre.FECING, MvCuadre.FECMOD, MvCuadre.IDINTEGRA, MvCuadre.IDMVCUADRE, MvCuadre.IdTeletransporte, MvCuadre.INTBANCO, MvCuadre.MEDIOPAG, MvCuadre.NIT, MvCuadre.NROAPROBA, MvCuadre.NROCHEQUE, MvCuadre.ORIGEN, MvCuadre.PAGODATAF, MvCuadre.PASSWORDIN, MvCuadre.PASSWORDMO, MvCuadre.STADSINCRO, MvCuadre.TIPODCTO, MvCuadre.TIPODCTOFA, MvCuadre.VALOR
FROM SUPERTODO.dbo.MvCuadre MvCuadre
WHERE (MvCuadre.FECING >='01/07/2024') and  MvCuadre.dcto='30146'

ORDER BY MvCuadre.TIPODCTO

select* from MvCuadre WHERE FECHAMVTO >='01/07/2024' and valor='1947'

SELECT MvCuadre.BANCO, MvCuadre.BANCODEST, MvCuadre.BANCOORI, MvCuadre.BENEF, MvCuadre.CODBANCO, MvCuadre.CODCHQDEV, MvCuadre.CODESTADO, MvCuadre.CODPLAZA, MvCuadre.CODTARJETA, MvCuadre.COMENTARIO, MvCuadre.CTACHEQUE, MvCuadre.CTADEST, MvCuadre.CTAORI, MvCuadre.DCTO, MvCuadre.FACTURA, MvCuadre.FECHACHQ, MvCuadre.FECHAMVTO, MvCuadre.FECING, MvCuadre.FECMOD, MvCuadre.IDINTEGRA, MvCuadre.IDMVCUADRE, MvCuadre.IdTeletransporte, MvCuadre.INTBANCO, MvCuadre.MEDIOPAG, MvCuadre.NIT, MvCuadre.NROAPROBA, MvCuadre.NROCHEQUE, MvCuadre.ORIGEN, MvCuadre.PAGODATAF, MvCuadre.PASSWORDIN, MvCuadre.PASSWORDMO, MvCuadre.STADSINCRO, MvCuadre.TIPODCTO, MvCuadre.TIPODCTOFA, MvCuadre.VALOR
FROM SUPERTODO.dbo.MvCuadre MvCuadre
WHERE (MvCuadre.FECHAMVTO >='01/07/2024') and  MvCuadre.dcto='30018'