USE [SUPERTODO]
GO

/****** Object:  View [dbo].[V_Int_MedPag]    Script Date: 5/09/2025 11:13:11 a. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--Drop view V_Int_MedPag
ALTER View [dbo].[V_Int_MedPag] as
Select 
MvCuadre.FechaMvto as Fecha,
MtBancos.Cuenta as CTAMEDIOS,
MtBancos.CtaNIIF as CTANIIF,
(Select Cuentas.CtaNIIF 
	From Cuentas
	Where MvCuadre.Banco = Cuentas.CodigoCta) as NIIFCTAMEDIOS, 	
MvCuadre.TIPODCTO,
MvCuadre.DCTO as NRODCTO,
MvCuadre.NIT as Enc_Tercero,
Isnull((select MTPROCLI.CODALTERNO from MTPROCLI where MTPROCLI.NIT = MVCUADRE.NIT),'') as CODALTERNO,
MvCuadre.NroCheque as Cheque,
Isnull(Case When MvCuadre.Valor > 0 Then valor End,0) AS TotalDebito,
Isnull(Case When MvCuadre.Valor < 0 Then valor End,0) AS TotalCredito,
MvCuadre.comentario as ENC_NOTA,
MvCuadre.Origen,
isnull((select isnull(MtProCli.sucursal,'') from trade Inner Join MtProCli On Trade.Nit = MtProCli.Nit 
  where tipodcto=MvCuadre.TIPODCTO and NRODCTO=MVCUADRE.dcto and origen=MVCUADRE.ORIGEN),'') as Sucursal,
Mvcuadre.Idmvcuadre as ID
From MvCuadre
   Inner Join MtBancos on (MtBancos.CodigoCta = MvCuadre.BANCO)
GO


