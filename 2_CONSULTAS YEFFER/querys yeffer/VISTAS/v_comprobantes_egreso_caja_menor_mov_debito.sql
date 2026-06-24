USE [SUPERTODO]
GO

/****** Object:  View [dbo].[v_comprobantes_egreso_caja_menor_mov_debito]    Script Date: 18/04/2024 7:54:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[v_comprobantes_egreso_caja_menor_mov_debito]
AS
SELECT     *, SUM(debito) AS total_deb
FROM         (SELECT     abo.dcto, mtc.codigocta AS cod_cta, cta.descripcio AS cuenta, SUM(abs(valor)) AS debito, (LTRIM(RTRIM(abo.nota)) 
                                              + ' - ' + + LTRIM(RTRIM(abo.tipodctocp)) + ' ' + LTRIM(RTRIM(tra.dctoprv))) AS notas
                       FROM          abocxp abo JOIN
                                              trade tra ON abo.factura = tra.nrodcto AND abo.tipodctocp = tra.tipodcto JOIN
                                              mtcajmen mtc ON abo.nitbenef = mtc.responsa JOIN
                                              cuentas cta ON mtc.codigocta = cta.codigocta
                       WHERE      abo.tipodcto = 'CE' AND abo.tipodctocp IN ('DP', 'F4')
                       GROUP BY abo.dcto, mtc.codigocta, cta.descripcio, abo.nota, abo.tipodctocp, tra.dctoprv) datos
GROUP BY dcto, cod_cta, cuenta, debito, notas
GO


