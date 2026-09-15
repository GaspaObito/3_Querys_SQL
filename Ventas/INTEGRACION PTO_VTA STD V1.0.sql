--INTEGRACION PTO_VTA SUPERTODO
USE SUPERTODO
DECLARE @Fecha date
DECLARE @Fechad date
DECLARE @NroPrueba int
SET @Fecha='01-07-2026'
SET @Fechad='01-07-2026'
--SET @NroPrueba='82002'
SELECT
    t.NRODCTO,t.tipodcto,
    '41352001' AS Cuenta,
    'VENTA EN ALMACEN' AS Nombre_Cuenta,
    t.Fecha,t.NIT,t.codcc,
    t.BRUTO - t.DESCUENTO AS Credito,
    CAST(0 AS NUMERIC(18, 2)) AS Debito
FROM
    mvtrade AS m, trade AS t
WHERE
	--m.NRODCTO=@NroPrueba AND
    m.tipodcto IN ('b1','b2')
    AND m.NRODCTO = t.NRODCTO AND t.ORIGEN = 'FAC' AND t.CODINT = '428'
    AND m.fecha >= @Fecha AND m.FECHA <= @Fechad
    AND t.tipodcto NOT IN ('R1', 'R2', 'R4', 'F2')
GROUP BY
    t.codcc,t.Fecha,t.NRODCTO,t.NIT,t.DESCUENTO,t.tipodcto,t.BRUTO,t.DESCUENTO,t.VLRETFTE
union --SEPARACION

SELECT
    t.NRODCTO,t.tipodcto,'41352001',
    'VENTA EN ALMACEN',t.Fecha,t.NIT,t.codcc,
    (t.BRUTO - t.DESCUENTO) * -1,
    CAST(0 AS NUMERIC(18, 2))
FROM
    mvtrade AS m, trade AS t
WHERE 
	--m.NRODCTO=@NroPrueba AND 
    m.tipodcto IN ('b4') AND m.NRODCTO = t.NRODCTO
    AND t.ORIGEN = 'FAC' AND t.CODINT = '429'
    AND m.fecha >= @Fecha AND m.FECHA <= @Fechad
    AND t.tipodcto NOT IN ('R1', 'R2', 'R4', 'F2')
GROUP BY
    t.codcc,t.Fecha,t.NRODCTO,t.NIT,t.DESCUENTO,t.tipodcto,t.BRUTO,t.DESCUENTO,t.VLRETFTE
UNION --SEPARACION

SELECT
    NRODCTO,tipodcto,'11050501',
    'CAJA MONEDA NACIONAL',FECHA,Enc_Tercero,Enc_Codcc,
    CAST(0 AS NUMERIC(18, 2)),
    SUM(TotalBruto) AS TotalBruto
FROM
    V_Int_Mov_Pvta
WHERE
	--NRODCTO=@NroPrueba AND
    fecha >= @Fecha AND Fecha <= @Fechad AND tipodcto IN ('b4')
GROUP BY
    NRODCTO,tipodcto,CTAVENTA1,Fecha,Enc_Tercero,Enc_Codcc
union --SEPARACION

SELECT
    NRODCTO,tipodcto,CTAVENTA1,
    'ITBIS GENERADO 18% ',FECHA,Enc_Tercero,Enc_Codcc,
    SUM(IvaBruto) AS IVA,
    CAST(0 AS NUMERIC(18, 2))
FROM
    V_Int_Mov_Pvta
WHERE
	--NRODCTO=@NroPrueba AND
    fecha >= @Fecha AND Fecha <= @Fechad AND tipodcto IN ('b1', 'b4', 'b2') 
    AND CTAVENTA1 = '24080102' AND IvaBruto NOT IN ('0')
GROUP BY
    NRODCTO,tipodcto,CTAVENTA1,Fecha,Enc_Tercero,Enc_Codcc
UNION --SEPARACION

SELECT
    NRODCTO,tipodcto,CTAVENTA1,'ITBIS GENERADO 16% ',FECHA,Enc_Tercero,Enc_Codcc,
    SUM(IvaBruto) AS IVA,
    CAST(0 AS NUMERIC(18, 2))
FROM
    V_Int_Mov_Pvta
WHERE
	--NRODCTO=@NroPrueba AND
    fecha >= @Fecha AND Fecha <= @Fechad AND tipodcto IN ('b4', 'b1', 'b2')
    AND CTAVENTA1 = '24080101' AND IvaBruto NOT IN ('0')
GROUP BY
    NRODCTO,tipodcto,CTAVENTA1,Fecha,Enc_Tercero,Enc_Codcc
union --SEPARACION

SELECT
    NRODCTO,TIPODCTO,CTAMEDIOS,DESCRIPCIO,Fecha,Enc_Tercero,
    CAST(0 AS NUMERIC(18, 2)),
    CAST(0 AS NUMERIC(18, 2)),
    TotalDebito + totalcredito
FROM
    V_Int_MedPag
    INNER JOIN CUENTAS ON CTAMEDIOS = CODIGOCTA
WHERE
	--NRODCTO=@NroPrueba AND
    Fecha >= @Fecha
    AND Fecha <= @Fechad
    AND tipodcto IN ('b1', 'b2')