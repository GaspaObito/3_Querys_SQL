USE [SUPERTODO]
GO

/****** Object:  View [dbo].[v_comprobantes_egreso_mov_debito]    Script Date: 18/04/2024 7:57:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[v_comprobantes_egreso_mov_debito]
AS
SELECT        DCTO, TIPODCTOCP, cod_cta, cuenta, debito, notas, SUM(debito) AS total_deb
FROM            (SELECT        abo.DCTO, abo.TIPODCTOCP, mtp.CODIGOCTAP AS cod_cta, cta.DESCRIPCIO AS cuenta, SUM(abo.VALOR) AS debito, LTRIM(RTRIM(abo.NOTA)) + ' - ' + + LTRIM(RTRIM(abo.TIPODCTOCP)) 
                                                    + ' ' + LTRIM(RTRIM(tra.DCTOPRV)) AS notas
                          FROM            dbo.ABOCXP AS abo INNER JOIN
                                                    dbo.TRADE AS tra ON abo.FACTURA = tra.NRODCTO AND abo.TIPODCTOCP = tra.TIPODCTO INNER JOIN
                                                    dbo.MTPROCLI AS mtp ON abo.NIT = mtp.NIT INNER JOIN
                                                    dbo.CUENTAS AS cta ON mtp.CODIGOCTAP = cta.CODIGOCTA
                          WHERE        (abo.TIPODCTO IN ('CE', 'CF')) AND (abo.TIPODCTOCP <> 'F4')
                          GROUP BY abo.DCTO, mtp.CODIGOCTAP, cta.DESCRIPCIO, abo.NOTA, abo.TIPODCTOCP, tra.DCTOPRV) AS datos
GROUP BY DCTO, TIPODCTOCP, cod_cta, cuenta, debito, notas
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "datos"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 263
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_comprobantes_egreso_mov_debito'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_comprobantes_egreso_mov_debito'
GO


