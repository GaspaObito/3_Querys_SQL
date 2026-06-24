USE [SUPERTODO]
GO

/****** Object:  View [dbo].[V_CatalogoBanco]    Script Date: 17/07/2025 3:13:31 p. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--Drop view V_CatalogoBanco
create view [dbo].[V_Curmvtrade] as
Select * , codbarras From MVTrade 
inner join MTMERCIA  on CODIGO=PRODUCTO

--select * from V_CatalogoBanco
GO


