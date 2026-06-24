USE [SUPERTODO]
GO

/****** Object:  View [dbo].[v_comprobantes_egreso]    Script Date: 2/09/2024 5:25:52 p. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[v_comprobantes_egreso]
AS
SELECT        aboc_1.DCTO, aboc_1.FECHA, aboc_1.anio, aboc_1.mes, aboc_1.dia, aboc_1.NIT, aboc_1.proveedor, banco.nom_banco, ctas.cod_cta, ctas.cuenta, CASE WHEN debito IS NULL THEN 0 ELSE debito END AS debito, 
                         CASE WHEN credito IS NULL THEN 0 ELSE credito END AS credito, CASE WHEN total_deb IS NULL THEN 0 ELSE total_deb END AS total_deb, CASE WHEN total_cre IS NULL THEN 0 ELSE total_cre END AS total_cre, 
                         LTRIM(RTRIM(aboc_1.FORMAPAGO)) + '-' + LTRIM(RTRIM(pag.NOMBRE)) AS pago, CASE WHEN notas IS NULL THEN '' ELSE notas END AS notas, '' AS vlr_letras
FROM            (SELECT        DCTO, TIPODCTOCP, FORMAPAGO, FECHA, YEAR(FECHA) AS anio, MONTH(FECHA) AS mes, DAY(FECHA) AS dia, NIT, BENEFICIA AS proveedor
                          FROM            dbo.ABOCXP AS aboc
                          WHERE        (TIPODCTO IN ('CF', 'CE','CG')) AND (TIPODCTOCP <> 'F4')
                          GROUP BY DCTO, TIPODCTOCP, FORMAPAGO, FECHA, NIT, BENEFICIA) AS aboc_1 INNER JOIN
                         dbo.v_comprobantes_egreso_bancos AS banco ON aboc_1.DCTO = banco.DCTO LEFT OUTER JOIN
                         dbo.v_comprobantes_egreso_ctas AS ctas ON aboc_1.DCTO = ctas.DCTO AND aboc_1.TIPODCTOCP = ctas.TIPODCTOCP LEFT OUTER JOIN
                         dbo.v_comprobantes_egreso_mov_debito AS mov_debito ON aboc_1.DCTO = mov_debito.DCTO AND aboc_1.TIPODCTOCP = mov_debito.TIPODCTOCP AND ctas.cod_cta = mov_debito.cod_cta LEFT OUTER JOIN
                         dbo.v_comprobantes_egreso_mov_credito AS mov_credito ON aboc_1.DCTO = mov_credito.DCTO AND ctas.cod_cta = mov_credito.cod_cta LEFT OUTER JOIN
                         dbo.MTFORPAG AS pag ON aboc_1.FORMAPAGO = pag.CODIGO
GROUP BY aboc_1.DCTO, aboc_1.FECHA, aboc_1.anio, aboc_1.mes, aboc_1.dia, aboc_1.NIT, aboc_1.proveedor, banco.nom_banco, ctas.cod_cta, ctas.cuenta, mov_debito.debito, mov_credito.credito, mov_debito.total_deb, 
                         mov_credito.total_cre, aboc_1.FORMAPAGO, pag.NOMBRE, mov_debito.notas
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[14] 2[27] 3) )"
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
         Begin Table = "pag"
            Begin Extent = 
               Top = 648
               Left = 38
               Bottom = 778
               Right = 263
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "mov_debito"
            Begin Extent = 
               Top = 384
               Left = 38
               Bottom = 514
               Right = 263
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "mov_credito"
            Begin Extent = 
               Top = 516
               Left = 38
               Bottom = 646
               Right = 263
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ctas"
            Begin Extent = 
               Top = 252
               Left = 38
               Bottom = 382
               Right = 263
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "banco"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 251
               Right = 263
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "aboc_1"
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
      Begin ColumnWidths = 18
         Width = 284
         Width = 1500
         Width = 1500
         ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_comprobantes_egreso'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_comprobantes_egreso'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_comprobantes_egreso'
GO


