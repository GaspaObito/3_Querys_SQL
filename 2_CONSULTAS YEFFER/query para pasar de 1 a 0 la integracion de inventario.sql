use VERONASAS
update MVTRADE
SET
INTEGRADO='0'
WHERE        (TIPODCTO IN ('fe')) AND (NRODCTO IN ('54', '55', '56', '57', '58', '59', '60', '61', '62', '63', '64', '65', '66', '67', '68', '69', '70', '71')) AND (ORIGEN = 'fac')