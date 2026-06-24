USE [SUPERTODO]
GO

/****** Object:  View [dbo].[V_Int_MedPag]    Script Date: 12/06/2025 4:10:31 p. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--Drop view V_Int_MedPag
SELECT 
    MvCuadre.FechaMvto AS Fecha,
    MtBancos.Cuenta AS CTAMEDIOS,
    MtBancos.CtaNIIF AS CTANIIF,
    (SELECT Cuentas.CtaNIIF 
     FROM Cuentas
     WHERE MvCuadre.Banco = Cuentas.CodigoCta) AS NIIFCTAMEDIOS, 	
    MvCuadre.TIPODCTO,
    MvCuadre.DCTO AS NRODCTO,
    MvCuadre.NIT AS Enc_Tercero,
    MvCuadre.NroCheque AS Cheque,

    -- TotalDebito ajustado solo si CTAMEDIOS = '11050501'
    ISNULL(CASE 
        WHEN MtBancos.Cuenta = '11050501' THEN 
            ISNULL(CASE WHEN MvCuadre.Valor > 0 THEN MvCuadre.Valor ELSE 0 END, 0)
            + 
            ISNULL((
                SELECT SUM(Valor)
                FROM MvCuadre AS sub
                WHERE sub.DCTO = MvCuadre.DCTO 
                  AND sub.Banco = 0
                  AND sub.Valor < 0
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
INNER JOIN MtBancos ON MtBancos.CodigoCta = MvCuadre.BANCO
WHERE MtBancos.Cuenta <>'0';
GO


