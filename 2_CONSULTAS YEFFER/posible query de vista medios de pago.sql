USE [VERONASAS]
GO

/****** Object:  View [dbo].[V_Int_MedPag_corregido_vr]    Script Date: 9/04/2026 10:46:41 a. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO











--Drop view V_Int_MedPag_correcta
ALTER View [dbo].[V_Int_MedPag] as
SELECT 
    MvCuadre.FechaMvto AS Fecha,
    MtMedPag.CODIGOCTA AS CTAMEDIOS,
    MtMedPag.CODIGOCTA AS CTANIIF,
    (SELECT Cuentas.CtaNIIF 
     FROM Cuentas
     WHERE MvCuadre.Banco = Cuentas.CodigoCta) AS NIIFCTAMEDIOS,
	 		(SELECT trade.CODCC
     FROM trade
     WHERE MvCuadre.DCTO = trade.NRODCTO and MvCuadre.TIPODCTO=trade.TIPODCTO) AS codcc, 
    MvCuadre.TIPODCTO,
    MvCuadre.DCTO AS NRODCTO,
    MvCuadre.NIT AS Enc_Tercero,
    MvCuadre.NroCheque AS Cheque,

    -- TotalDebito ajustado solo si CTAMEDIOS = '11050501'
    ISNULL(CASE 
    WHEN MtMedPag.CODIGOCTA like '%110505%' 
      OR MtMedPag.CODIGOCTA like '%111005%' 
      OR MtMedPag.CODIGOCTA like '%13809501%' 
    THEN 
        ISNULL(CASE WHEN MvCuadre.Valor > 0 THEN MvCuadre.Valor ELSE 0 END, 0)
        + 
        ISNULL((
            SELECT SUM(Valor)
            FROM MvCuadre AS sub
            WHERE sub.DCTO = MvCuadre.DCTO 
              AND sub.MEDIOPAG = '97'
              AND sub.FechaMvto = MvCuadre.FechaMvto
              AND sub.Valor < 0

              AND (
                    -- 🔥 CASO 1: existen ambos → SOLO aplica a 110505
                    (
                        EXISTS (
                            SELECT 1
                            FROM MvCuadre x
                            INNER JOIN MtMedPag mp ON mp.CODIGOCTA = x.BANCO
                            WHERE x.DCTO = MvCuadre.DCTO
                              AND mp.CODIGOCTA LIKE '%110505%'
                        )
                        AND EXISTS (
                            SELECT 1
                            FROM MvCuadre x
                            INNER JOIN MtMedPag mp ON mp.CODIGOCTA = x.BANCO
                            WHERE x.DCTO = MvCuadre.DCTO
                              AND mp.CODIGOCTA LIKE '%111005%'
                        )
                        AND MtMedPag.CODIGOCTA LIKE '%110505%'
                    )

                    -- 🔥 CASO 2: NO existen ambos → aplica normal a cualquiera
                    OR NOT (
                        EXISTS (
                            SELECT 1
                            FROM MvCuadre x
                            INNER JOIN MtMedPag mp ON mp.CODIGOCTA = x.BANCO
                            WHERE x.DCTO = MvCuadre.DCTO
                              AND mp.CODIGOCTA LIKE '%110505%'
                        )
                        AND EXISTS (
                            SELECT 1
                            FROM MvCuadre x
                            INNER JOIN MtMedPag mp ON mp.CODIGOCTA = x.BANCO
                            WHERE x.DCTO = MvCuadre.DCTO
                              AND mp.CODIGOCTA LIKE '%111005%'
                        )
                    )
              )

        ), 0)

    ELSE ISNULL(CASE WHEN MvCuadre.Valor > 0 THEN MvCuadre.Valor ELSE 0 END, 0)
END, 0) AS TotalDebito,

    -- TotalCredito normal
    ISNULL(CASE WHEN MvCuadre.Valor < 0 THEN MvCuadre.Valor ELSE 0 END, 0) AS TotalCredito,

    MvCuadre.comentario AS ENC_NOTA,
    MvCuadre.Origen,

    ISNULL((
        SELECT ISNULL(MtProCli.sucursal, '') 
        FROM Trade 
        INNER JOIN MtProCli ON Trade.Nit = MtProCli.Nit 
        WHERE tipodcto = MvCuadre.TIPODCTO 
          AND NRODCTO = MvCuadre.DCTO 
          AND origen = MvCuadre.ORIGEN
    ), '') AS Sucursal,

    MvCuadre.Idmvcuadre AS ID

FROM MvCuadre
INNER JOIN MtMedPag ON MtMedPag.CODIGOCTA = MvCuadre.BANCO
WHERE MtMedPag.CODIGOCTA <>'0' group by MtMedPag.CODIGOCTA, MvCuadre.FechaMvto, MvCuadre.BANCO, MvCuadre.TIPODCTO, MvCuadre.DCTO,MvCuadre.NIT, MvCuadre.NROCHEQUE, MvCuadre.VALOR, MvCuadre.COMENTARIO, MvCuadre.ORIGEN, MvCuadre.IDMVCUADRE
GO


