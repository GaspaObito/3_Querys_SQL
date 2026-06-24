use VERONASAS
update Mvtrade
set
BODEGA='115.BUGA'
WHERE        (BODEGA IN ('47.MARROQUI')) AND (CODCC = '0115')

use VERONASAS
update SALDOINV
SET
BODEGA = '119.MULTIF. CALLE 77',
CODCC='0119'
WHERE        (BODEGA IN ('02.TL.DECO')) AND (NIT = '800160705S29')
----query para ver codigo repertidos y hacer respectivo salto para la respectiva actualizacion de estos dejando los repetidos sin actualizar
SELECT S.*
FROM SALDOINV S
WHERE S.BODEGA = '105.SINCELE3'
  AND S.NIT = '0'
  AND EXISTS (
        SELECT 1
        FROM SALDOINV X
        WHERE X.ANO     = S.ANO
          AND X.PERIODO = S.PERIODO
          AND X.CODIGO  = S.CODIGO
          AND X.NIT     = S.NIT
          AND X.BODEGA  = '105.SINCELE3'
  );

USE VERONASAS;

UPDATE S
SET BODEGA = '099.ROMELIO'
FROM SALDOINV S
WHERE S.BODEGA = '47.MARROQUI'
  AND S.NIT = '800160705S23'

  -- Evitar duplicidad de llave primaria
  AND NOT EXISTS (
        SELECT 1
        FROM SALDOINV X
        WHERE X.ANO     = S.ANO
          AND X.PERIODO = S.PERIODO
          AND X.CODIGO  = S.CODIGO
          AND X.NIT     = S.NIT
          AND X.BODEGA  = '099.ROMELIO'
  );
use VERONASAS
update SALDOINV
SET
BODEGA = '107.SINCELE5',
codcc='0107'
WHERE        (BODEGA IN ('37.CONSDECO')) AND (NIT = '800160705S33')

'800160705S23'	099.ROMELIO	'099.ROMELIO'
USE VERONASAS;

UPDATE S
SET BODEGA = '114.CARTAGO',
codcc='0114'
FROM SALDOINV S
WHERE S.BODEGA = '47.MARROQUI'
  AND S.NIT = '800160705S23'

  -- Evitar duplicidad de llave primaria
  AND NOT EXISTS (
        SELECT 1
        FROM SALDOINV X
        WHERE X.ANO     = S.ANO
          AND X.PERIODO = S.PERIODO
          AND X.CODIGO  = S.CODIGO
          AND X.NIT     = S.NIT
          AND X.BODEGA  = '114.CARTAGO'
		  and X.CODCC='0114'
  );






