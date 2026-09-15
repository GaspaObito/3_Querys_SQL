-- INTEGRACION PTO_VTA STD
USE SUPERTODO;

DECLARE @NroPrueba INT;
DECLARE @Nro INT;
SET @NroPrueba = 1242;
SET @Nro = 180;

SELECT
    p.NRODCTO,
    p.TIPODCTO,
    '41352001' AS Cuenta,
    'VENTA EN ALMACEN' AS Nombre_Cuenta,
    p.Fecha,
    p.Enc_Tercero,
    p.Enc_Codcc,
    SUM(ROUND(p.TotalVenta, 2)) AS Credito,
    CAST(0 AS NUMERIC(18,2)) AS Debito,
	'0' AS Base,
	p.Enc_Nota As Detalle
FROM V_Int_Mov_Pvta p
WHERE
    p.NRODCTO = @NroPrueba AND
    p.TIPODCTO IN ('B1', 'B2')
    AND p.Fecha BETWEEN DATEADD(DAY, -@Nro, CAST(GETDATE() AS DATE))
                    AND CAST(GETDATE() AS DATE)
    AND p.TIPODCTO NOT IN ('R1', 'R2', 'R4', 'F2')
GROUP BY
    p.NRODCTO,
    p.TIPODCTO,
    p.Fecha,
    p.Enc_Tercero,
    p.Enc_Codcc,
	p.Enc_Nota

UNION

-- NOTAS CRÉDITO

SELECT
    t.NRODCTO,
    t.TIPODCTO,
    '41352001',
    'VENTA EN ALMACEN',
    t.Fecha,
    t.NIT,
    t.CODCC,
    (t.BRUTO - t.DESCUENTO) * -1,
    CAST(0 AS NUMERIC(18,2)),
	'0' AS Base,
	'' As Detalle
FROM MVTRADE m,
     TRADE t
WHERE
    m.NRODCTO = @NroPrueba AND
    m.TIPODCTO IN ('B4')
    AND m.NRODCTO = t.NRODCTO
    AND t.ORIGEN = 'FAC'
    AND t.CODINT = '429'
    AND m.Fecha BETWEEN DATEADD(DAY, -@Nro, CAST(GETDATE() AS DATE))
                    AND CAST(GETDATE() AS DATE)
    AND t.TIPODCTO NOT IN ('R1', 'R2', 'R4', 'F2')
GROUP BY
    t.CODCC,
    t.Fecha,
    t.NRODCTO,
    t.NIT,
    t.DESCUENTO,
    t.TIPODCTO,
    t.BRUTO,
    t.VLRETFTE

UNION

SELECT
    NRODCTO,
    TIPODCTO,
    '11050501',
    'CAJA MONEDA NACIONAL',
    FECHA,
    Enc_Tercero,
    Enc_Codcc,
    CAST(0 AS NUMERIC(18,2)),
    SUM(TotalBruto) AS TotalBruto,
	'0' AS Base,
	Enc_Nota As Detalle
FROM V_Int_Mov_Pvta
WHERE
    NRODCTO = @NroPrueba AND
    Fecha BETWEEN DATEADD(DAY, -@Nro, CAST(GETDATE() AS DATE))
              AND CAST(GETDATE() AS DATE)
    AND TIPODCTO IN ('B4')
GROUP BY
    NRODCTO,
    TIPODCTO,
    CTAVENTA1,
    Fecha,
    Enc_Tercero,
    Enc_Codcc,
	Enc_Nota

UNION

SELECT
    NRODCTO,
    TIPODCTO,
    CTAVENTA1,
    'ITBIS GENERADO 18%',
    FECHA,
    Enc_Tercero,
    Enc_Codcc,
    SUM(IvaBruto) AS IVA,
    CAST(0 AS NUMERIC(18,2)),
	SUM(ROUND(TotalBruto-IvaBruto,2)) AS Base,
	Enc_Nota As Detalle
FROM V_Int_Mov_Pvta
WHERE
    NRODCTO = @NroPrueba AND
    Fecha BETWEEN DATEADD(DAY, -@Nro, CAST(GETDATE() AS DATE))
              AND CAST(GETDATE() AS DATE)
    AND TIPODCTO IN ('B1', 'B2', 'B4')
    AND CTAVENTA1 = '24080102'
    AND IvaBruto <> 0
GROUP BY
    NRODCTO,
    TIPODCTO,
    CTAVENTA1,
    Fecha,
    Enc_Tercero,
    Enc_Codcc,
	Enc_Nota

UNION

SELECT
    NRODCTO,
    TIPODCTO,
    CTAVENTA1,
    'ITBIS GENERADO 16%',
    FECHA,
    Enc_Tercero,
    Enc_Codcc,
    SUM(IvaBruto) AS IVA,
    CAST(0 AS NUMERIC(18,2)),
	SUM(ROUND(TotalBruto-IvaBruto,2)) AS Base,
	Enc_Nota As Detalle
FROM V_Int_Mov_Pvta
WHERE
    NRODCTO = @NroPrueba AND
    Fecha BETWEEN DATEADD(DAY, -@Nro, CAST(GETDATE() AS DATE))
              AND CAST(GETDATE() AS DATE)
    AND TIPODCTO IN ('B1', 'B2', 'B4')
    AND CTAVENTA1 = '24080101'
    AND IvaBruto <> 0
GROUP BY
    NRODCTO,
    TIPODCTO,
    CTAVENTA1,
    Fecha,
    Enc_Tercero,
    Enc_Codcc,
	Enc_Nota

UNION

SELECT
    NRODCTO,
    TIPODCTO,
    CTAMEDIOS,
    DESCRIPCIO,
    Fecha,
    Enc_Tercero,
    CAST(0 AS NUMERIC(18,2)),
    CAST(0 AS NUMERIC(18,2)),
    TotalDebito + TotalCredito,
	'0' AS Base,
	Enc_Nota As Detalle
FROM V_Int_MedPag
INNER JOIN CUENTAS
    ON CTAMEDIOS = CODIGOCTA
WHERE
    NRODCTO = @NroPrueba AND
    Fecha BETWEEN DATEADD(DAY, -@Nro, CAST(GETDATE() AS DATE))
              AND CAST(GETDATE() AS DATE)
    AND TIPODCTO IN ('B1', 'B2')

UNION

SELECT
    NRODCTO,
    TIPODCTO,
    '0' AS Cuenta,
    'VARIOS' AS Nombre_Cuenta,
    FECHA,
    Enc_Tercero,
    Enc_Codcc,
    SUM(IvaBruto) AS IVA,
    CAST(0 AS NUMERIC(18,2)),
	'0' AS Base,
	Enc_Nota As Detalle
FROM V_Int_Mov_Pvta
WHERE
    NRODCTO = @NroPrueba AND
    Fecha BETWEEN DATEADD(DAY, -@Nro, CAST(GETDATE() AS DATE))
              AND CAST(GETDATE() AS DATE)
    AND TIPODCTO IN ('B1', 'B2', 'B4')
    AND ISNULL(CTAVENTA1, '0') NOT IN ('24080101', '24080102')
    AND IvaBruto <> 0
GROUP BY
    NRODCTO,
    TIPODCTO,
    FECHA,
    Enc_Tercero,
    Enc_Codcc,
	Enc_Nota