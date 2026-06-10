USE [SUPERTODO]
GO

/****** Object:  View [dbo].[V_Int_Mov_Pvta]    Script Date: 15/05/2026 16:19:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- Select Totalventa, TotalBruto,Bruto, ivabruto, * from V_Int_Mov_PVta where nrodcto = '7040'
--  Drop View V_Int_Mov_PVta
ALTER  View [dbo].[V_Int_Mov_Pvta] as
With CalculosBasicos (Idmvtrade,Bruto,xBruto,DstoProducto,xDstoProducto,DsctoComercial,xDsctoComercial,TotalBruto,xTotalBruto,TotalVenta,xTotalVenta)
As	
(
	Select 
	MVTRADE.IDMVTRADE,
	--TotalBruto
	CASE WHEN TRADE.Pais = 'CO' AND MvTrade.ValorUnit = 0 AND TIPODCTO.DCTOMAE in ('FA','FR','NC') 
	THEN  
		Round((Mvtrade.Cantidad * Cast((select dbo.F_CalcularPrecio(Trade.NIT,MvTrade.PRODUCTO,MvTrade.UndVenta))as Numeric(17,2))),Trade.Decimales)
	else 
		Round((Mvtrade.Cantidad * MvTrade.ValorUnit),Trade.Decimales)
	end  as Bruto,

	CASE WHEN TRADE.Pais = 'CO' AND MvTrade.xValorUn = 0 AND TIPODCTO.DCTOMAE in ('FA','FR','NC') 
	THEN
		Round((Mvtrade.Cantidad * Cast((select dbo.F_CalcularPrecio(Trade.NIT,MvTrade.PRODUCTO,MvTrade.UndVenta))as Numeric(17,2))),Trade.Decimales)
	else
		Round((Mvtrade.Cantidad * MvTrade.xValorUn),Trade.Decimales)
	end as xBruto,
	--Descuento Producto
	Round(Round((Mvtrade.CanVenta * MvTrade.VlrVenta),Trade.Decimales)*Mvtrade.Descuento/100,Trade.Decimales) as DstoProducto,
	Round(Round((Mvtrade.CanVenta * MvTrade.VlrVenta),Trade.Decimales)*Mvtrade.Descuento/100,Trade.Decimales) as xDstoProducto,
	--Descuento Comercial 
	Round((Round((Mvtrade.CanVenta * MvTrade.VlrVenta),Trade.Decimales) - Round(Round((Mvtrade.CanVenta * MvTrade.VlrVenta),Trade.Decimales)*Mvtrade.Descuento/100,Trade.Decimales))*Trade.DSCTOCOM/100,Trade.DECIMALES) as DsctoComercial,
    Round((Round((Mvtrade.CanVenta * MvTrade.VlrVenta),Trade.Decimales) - Round(Round((Mvtrade.CanVenta * MvTrade.VlrVenta),Trade.Decimales)*Mvtrade.Descuento/100,Trade.Decimales))*Trade.DSCTOCOM/100,Trade.DECIMALES) as xDsctoComercial,
	
	CASE WHEN TRADE.Pais = 'CO' AND MvTrade.ValorUnit = 0 AND TIPODCTO.DCTOMAE in ('FA','FR','NC') 
	THEN
		Round((Mvtrade.Cantidad * Cast((select dbo.F_CalcularPrecio(Trade.NIT,MvTrade.PRODUCTO,MvTrade.UndVenta)  ) as Numeric(17,2))),Trade.Decimales) 
		- Round(Round((Mvtrade.CanVenta * Cast((select dbo.F_CalcularPrecio(Trade.NIT,MvTrade.PRODUCTO,MvTrade.UndVenta))as Numeric(17,2))),Trade.Decimales)*Mvtrade.Descuento/100,Trade.Decimales) 
		- Round((Round((Mvtrade.CanVenta * Cast((select dbo.F_CalcularPrecio(Trade.NIT,MvTrade.PRODUCTO,MvTrade.UndVenta))as Numeric(17,2))),Trade.Decimales) - Round(Round((Mvtrade.CanVenta * Cast((select dbo.F_CalcularPrecio(Trade.NIT,MvTrade.PRODUCTO,MvTrade.UndVenta))as Numeric(17,2))),Trade.Decimales)*Mvtrade.Descuento/100,Trade.Decimales))*Trade.DSCTOCOM/100,Trade.DECIMALES)
	ELSE
		Round((Mvtrade.Cantidad * MvTrade.ValorUnit),Trade.Decimales) 
		- Round(Round((Mvtrade.CanVenta * MvTrade.VlrVenta),Trade.Decimales)*Mvtrade.Descuento/100,Trade.Decimales) 
		- Round((Round((Mvtrade.CanVenta * MvTrade.VlrVenta),Trade.Decimales) - Round(Round((Mvtrade.CanVenta * MvTrade.VlrVenta),Trade.Decimales)*Mvtrade.Descuento/100,Trade.Decimales))*Trade.DSCTOCOM/100,Trade.DECIMALES)		
	end as TotalBruto,

	CASE WHEN TRADE.Pais = 'CO' AND MvTrade.xValorUn = 0 AND TIPODCTO.DCTOMAE in ('FA','FR','NC') 
	THEN
		Round((Mvtrade.Cantidad * Cast((select dbo.F_CalcularPrecio(Trade.NIT,MvTrade.PRODUCTO,MvTrade.UndVenta))as Numeric(17,2))),Trade.Decimales) 
		- Round(Round((Mvtrade.CanVenta * Cast((select dbo.F_CalcularPrecio(Trade.NIT,MvTrade.PRODUCTO,MvTrade.UndVenta))as Numeric(17,2))),Trade.Decimales)*Mvtrade.Descuento/100,Trade.Decimales) 
		- Round((Round((Mvtrade.CanVenta * Cast((select dbo.F_CalcularPrecio(Trade.NIT,MvTrade.PRODUCTO,MvTrade.UndVenta))as Numeric(17,2))),Trade.Decimales) - Round(Round((Mvtrade.CanVenta * Cast((select dbo.F_CalcularPrecio(Trade.NIT,MvTrade.PRODUCTO,MvTrade.UndVenta))as Numeric(17,2))),Trade.Decimales)*Mvtrade.Descuento/100,Trade.Decimales))*Trade.DSCTOCOM/100,Trade.DECIMALES)
	else 
		Round((Mvtrade.Cantidad * MvTrade.xValorUn),Trade.Decimales) 
		- Round(Round((Mvtrade.CanVenta * MvTrade.VlrVenta),Trade.Decimales)*Mvtrade.Descuento/100,Trade.Decimales) 
		- Round((Round((Mvtrade.CanVenta * MvTrade.VlrVenta),Trade.Decimales) - Round(Round((Mvtrade.CanVenta * MvTrade.VlrVenta),Trade.Decimales)*Mvtrade.Descuento/100,Trade.Decimales))*Trade.DSCTOCOM/100,Trade.DECIMALES)		
	end as xTotalBruto,
	 
	
	--CASE WHEN TRADE.Pais = 'CO' AND MvTrade.VlrVenta = 0 And Mvtrade.CanVenta > 0 AND TIPODCTO.DCTOMAE in ('FA','FR','NC') 
	--THEN
	--	Round((Mvtrade.CanVenta * Cast((select dbo.F_CalcularPrecio(Trade.NIT,MvTrade.PRODUCTO,MvTrade.UndVenta) / (1+(MVTRADE.IVA/100))  )as Numeric(17,2))),Trade.Decimales) 
	--ELSE
	--	Round((Mvtrade.CANTIDAD * MvTrade.VALORUNIT),Trade.Decimales) 
	--	- Round(Round((Mvtrade.CanVenta * MvTrade.VlrVenta),Trade.Decimales)*Mvtrade.Descuento/100,Trade.Decimales) 
	--	- Round((Round((Mvtrade.CanVenta * MvTrade.VlrVenta),Trade.Decimales) - Round(Round((Mvtrade.CanVenta * MvTrade.VlrVenta),Trade.Decimales)*Mvtrade.Descuento/100,Trade.Decimales))*Trade.DSCTOCOM/100,Trade.DECIMALES)

	--end as TotalVenta,

	((((Round(Mvtrade.CanVenta*MVTRADE.VLRVENTA,TRADE.DEcimales) - Round((Round(Mvtrade.canventa * Mvtrade.vlrventa,TRADE.DECIMALES)*MVTRADE.Descuento/100),TRADE.DEcimales)) / (1+(MVTRADE.Iva/100)))))  as TotalVEnta,

	CASE WHEN TRADE.Pais = 'CO' AND MvTrade.xValorUn = 0 And Mvtrade.CanVenta > 0 AND TIPODCTO.DCTOMAE in ('FA','FR','NC') 
	THEN
		 Round((Mvtrade.CanVenta * Cast((select dbo.F_CalcularPrecio(Trade.NIT,MvTrade.PRODUCTO,MvTrade.UndVenta))as Numeric(17,2))),Trade.Decimales) 
	else 
		Round((Mvtrade.Cantidad * MvTrade.xValorUn),Trade.Decimales) 
		- Round(Round((Mvtrade.CanVenta * MvTrade.VlrVenta),Trade.Decimales)*Mvtrade.Descuento/100,Trade.Decimales) 
		- Round((Round((Mvtrade.CanVenta * MvTrade.VlrVenta),Trade.Decimales) - Round(Round((Mvtrade.CanVenta * MvTrade.VlrVenta),Trade.Decimales)*Mvtrade.Descuento/100,Trade.Decimales))*Trade.DSCTOCOM/100,Trade.DECIMALES)
	end as xTotalVenta
	
	 

	From MvTrade
		Inner Join Trade on Trade.Origen = MvTrade.Origen and Trade.TipoDcto = Mvtrade.TipoDcto and Trade.NroDcto = MvTrade.NroDcto
		Inner Join TipoDcto on TipoDcto.Origen = Trade.Origen and TipoDcto.TipoDcto = Trade.TipoDcto
	Where ISNULL(CAJAREG,'')<>'' and Trade.Origen = 'FAC' AND TipoDcto.DctoMae not in ('PD','CT') --and (Trade.INTEGRADO = 0 
	 -- or (ISNULL(CAJAREG,'')<>'' and Trade.Origen = 'FAC' AND TipoDcto.DctoMae not in ('PD','CT') and Trade.INTNIIF=0 ))
),
cuentasProducto (codigo,Ctaaii,CtaVta,CtaVtaDev,
		CtaVtaDIva,CtaVtaDRte,CtaVtaIva,CtaVtaRte,
		CtDRirCVta,CtRirCVta,
		NQCTAVenta5,NQCTAVenta,NQCTAVentaDev,
		NQCTAVenta2,NQCTAVenta4,NQCTAVenta1,NQCtaVenta3,
		NQCtaVtaDevReteIVA,NQCtaVtaReteIVA)
as
(
 select mtmercia.codigo,Ctaaii,CtaVta,CtaVtaDev,
		CtaVtaDIva,CtaVtaDRte,CtaVtaIva,CtaVtaRte,
		CtDRirCVta,CtRirCVta, 
		isnull(NQCTAVenta5.ctaNiif,'') as NQCTAVenta5,
		isnull(NQCTAVenta.ctaNiif,'') as NQCTAVenta,
		isnull(NQCTAVentaDev.ctaNiif,'') as NQCTAVentaDev,
		isnull(NQCTAVenta2.ctaNiif,'') as NQCTAVenta2,
		isnull(NQCTAVenta4.ctaNiif,'') as NQCTAVenta4,
		isnull(NQCTAVenta1.ctaNiif,'') as NQCTAVenta1,
		isnull(NQCtaVenta3.ctaNiif,'') as NQCtaVenta3,
		isnull(NQCtaVtaDevReteIVA.ctaNiif,'') as NQCtaVtaDevReteIVA,
		isnull(NQCtaVtaReteIVA.ctaNiif,'') as NQCtaVtaReteIVA 
	from mtmercia 
		left join cuentas NQCTAVenta5 on MtMercia.Ctaaii = NQCTAVenta5.CodigoCta 
		left join cuentas NQCTAVenta on MtMercia.CtaVta  = NQCTAVenta.CodigoCta 
		left join cuentas NQCTAVentaDev on MtMercia.CtaVtaDev  = NQCTAVentaDev.CodigoCta 
		left join cuentas NQCTAVenta2 on MtMercia.CtaVtaDIva  = NQCTAVenta2.CodigoCta 
		left join cuentas NQCTAVenta4 on MtMercia.CtaVtaDRte  = NQCTAVenta4.CodigoCta 
		left join cuentas NQCTAVenta1 on MtMercia.CtaVtaIva   = NQCTAVenta1.CodigoCta 
		left join cuentas NQCtaVenta3 on MtMercia.CtaVtaRte   = NQCtaVenta3.CodigoCta 
		left join cuentas NQCtaVtaDevReteIVA on MtMercia.CtDRirCVta    = NQCtaVtaDevReteIVA.CodigoCta 
		left join cuentas NQCtaVtaReteIVA on MtMercia.CtRirCVta     = NQCtaVtaReteIVA.CodigoCta 
)

Select 
	---------------------Información adicional Documento------------------------------------
	Trade.TIPODCTO,
	Trade.NRODCTO,
	Trade.Fecha,
	Trade.Remision,
	Trade.CODCC as Enc_Codcc,-- Centro Costo -Encabezado
	MvTrade.CODCC as Mv_Codcc,--Centro Costo -Movimiento
	Trade.NIT as Enc_Tercero,--Tercero- Encabezado
	Mvtrade.Nit as Mv_Tercero,--Tercero -Movimiento
    Trade.Nota as Enc_Nota,
	MvTrade.NOTA as Mv_Nota,
	MtProCli.CodAlterno, 
	MtProCli.Sucursal,
	MvTrade.Producto,
	--------------------Cuentas  disponibles para la  integración--------------------------
	MtTarIVA.CtaIVAAcre as CtaIVAFac,			-- Cta_IVA_Acreditar,
	MtTarIVA.CtaIVADeb as CtaIVACom,			-- Cta_IVA_Cobrar,
	MtTarIVA.DEVCOM as CTADevIVACom,						-- Cta Devolucion IVA Compras
	MtTarIVA.DEVVTA as CTADevIVAFac,						-- Cta Devolucion IVA Facturas
	MtTopRte.CtaRteFact as CtaReteFuente,		-- Cta_Retencion,
	MtTopRte.CuentaRte as CtaReteFteCom,		-- Cuenta retentencion en la fuente compras
	MtRetica.CtaFac as CtaReteICa,				-- Cta_Reten_ICA,
	MtRetica.CtaFac as CtaRecaudoIca,			-- Cueenta Recuado ICA regimen simplificado
	MtCiiu.CuentaCree as CtaReteCree,			-- Cuenta_CREE, 
	Trade.CodigoCta,							-- Cuenta por cobrar
	MtMercia.CTAAII	As	CtaVenta5,				-- Cuenta ajuste por inflaciòn
	--MtMercia.CTAVTA	As	CtaVenta,			    -- Cuenta Venta
	Case When MvTrade.CtaVta = '0' or MvTrade.CtaVta = '' Then MtMercia.CtaVta Else MvTrade.CtaVta End as CtaVenta,
	---MtMercia.CTAVTADEV	As	CtaVentaDev,		-- Cuenta Venta Devolucion
	Case When MvTrade.CtaVta = '0' or MvTrade.CtaVta = '' Then MtMercia.CtaVtaDev Else MvTrade.CtaVta End as CtaVentaDev,	-- Cuenta Venta Devolucion
	MtMercia.CTAVTADIVA	As	CtaVenta2,			-- Cuenta Venta Devolucion IVA
	MtMercia.CTAVTADRTE	As	CtaVenta4,			-- Cuenta Venta Devolucion Retencion
	MtMercia.CTAVTAIVA	As	CtaVenta1,			-- Cuenta Venta IVA
	MtMercia.CTAVTARTE	As	CtaVenta3,			-- Cuenta Venta Retencion
	MtMercia.CTRIRCVTA	As	CtaVtaReteIVA ,     -- Cuenta Venta Retencion IVA regimen comun
	MtMercia.CTDRIRCVTA	As	CtaVtaDevReteIVA,   -- Cuenta Venta Devolucion Retencion IVA Regimen comun

	------Cuentas  disponibles para la  integración Contabilidad NIIF Equivalencias--------------

	(Select Cuentas.CtaNIIF 
	From Cuentas
	Where MtTarIVA.CtaIvaACre = Cuentas.CodigoCta)	as NQCTAIVAFAC,			   -- Cta_IVA_Debitar
	(Select Cuentas.CtaNIIF 
	From Cuentas
	Where MtTarIVA.CtaIVaCob = Cuentas.CodigoCta)	as NQCTAIVACOM,			   -- Cta_IVA_Pagar
    cuentasProducto.NQCTAVenta5,			-- Cta_Ajuste_Inventario,
	cuentasProducto.NQCTAVenta,			   -- Cta_Ingresos,
	cuentasProducto.NQCTAVentaDev,		   -- Cta_Devol_Ingresos,
	cuentasProducto.NQCTAVenta2,		   -- Cta_Dev_IVA_Ingresos,
	cuentasProducto.NQCTAVenta4,		   -- Cta_Dev_Rete_Ingresos,
	cuentasProducto.NQCTAVenta1,		   -- Cta_IVA_Ingresos,
	cuentasProducto.NQCtaVenta3,		   -- Cta_Rete_Ingresos,
	cuentasProducto.NQCtaVtaDevReteIVA,    -- Cta_Dev_RetIVA_Comun_Ingresos,
	cuentasProducto.NQCtaVtaReteIVA,	   -- Cta_RetIVA_Comun_Ingresos,
	(Select Cuentas.CtaNIIF 
	From Cuentas
	Where MtTopRte.CtaRteFact = Cuentas.CodigoCta)	as NQCTARETEFUENTE,	   		-- Cta_Retencion,
	(Select Cuentas.CtaNIIF 
	From Cuentas
	Where MtTopRte.CuentaRte = Cuentas.CodigoCta)	as NQCTARETEFTECOM,	   		-- Cta_Retencion,
	(Select Cuentas.CtaNIIF 
	From Cuentas
	Where MtRetica.CtaFac = Cuentas.CodigoCta)		as	NQCTARETEICA, 			-- Cta_Reten_ICA,
    (Select Cuentas.CtaNIIF 
	From Cuentas
	Where MtCiiu.CuentaCree = Cuentas.CodigoCta)	as NQCTARETECREE,			-- Cuenta_CREE,
	(Select Cuentas.CtaNIIF 
	From Cuentas
	Where Trade.CodigoCta = Cuentas.CodigoCta)		as NQCODIGOCTA, 			--Cuenta por cobrar
	(Select Cuentas.CtaNIIF 
	From Cuentas
	Where MtRetica.CtaFac = Cuentas.CodigoCta)		as	NQCTARECAUDOICA,		--Cuenta recaudo ICA
	
	Trade.Fechanif,
	------Cuentas  disponibles para la  integración Contabilidad NIIF Inventario--------------
	
	MtTarIVA.CtaFacNIIF as	NIIFCtaIVAFac,							-- Cta_IVA_Acreditar,
	MtTarIVA.CtaComNIIF	as	NIIFCtaIVACom,							-- Cta_IVA_Cobrar,
	MtTarIVA.DEVCOMNIF  as  NIIFCTADevIVACom,					-- Cta Devolucion IVA compras
	MtTarIVA.DEVVTANIF  as  NIIFCTADevIVAFac,				    -- Cta Devolucion IVA facturas
	MtTopRte.CtaFacNiif as  NIIFCtaReteFuente,						-- Cuenta retención fuente para facturas,
	MtTopRte.CtaCOMNiif as  NIIFCtaReteFteCom,					    -- Cuenta retencion fuente para compras,	
	MtRetica.CtaFacNiif as  NIIFCtaReteICa,							-- Cta_Reten_ICA,
	MtRetica.CtaFacNIIF	as  NIIFCtaRecaudoIca, 						-- Cueenta Recuado ICA regimen simplificado
	MtProCli.CodCtaNIIF as	NIIFCodigoCta,							-- Cuenta por cobrar
	MtMercia.NCTAAII	As	NIIFCtaVenta5,							-- Cuenta Venta Ajuste
	--MtMercia.NCTAVTA	As	NIIFCtaVenta,							-- Cuenta Venta
	Case When MvTrade.CtaVtaNiif = '0' or MvTrade.CtaVtaNiif = '' Then MtMercia.nCtaVta Else MvTrade.CtaVtaNiif End as NIIFCtaVenta,
	--MtMercia.NCTAVTADEV	As	NIIFCtaVentaDev,						-- Cuenta Venta Devolucion
	Case When MvTrade.CtaVtaNiif = '0' or MvTrade.CtaVtaNiif = '' Then MtMercia.NCtaVtaDev Else MvTrade.CtaVtaNiif End as NIIFCtaVentaDev,
	MtMercia.NCTAVTADIV	As	NIIFCtaVenta2,							-- Cuenta Venta Devolucion IVA
	MtMercia.NCTAVTADRT	As	NIIFCtaVenta4,							-- Cuenta Venta Devolucion Retencion
	MtMercia.NCTAVTAIVA	As	NIIFCtaVenta1,							-- Cuenta Venta IVA
	MtMercia.NCTAVTARTE	As	NIIFCtaVenta3,							-- Cuenta Venta Retencion
	MtMercia.NCTRIRCVTA	As	NIIFCtaVtaReteIVA,						-- Cuenta Venta Retencion IVA Regimen Comun
	MtMercia.NCTDRIRCVT	As	NIIFCtaVtaDevReteIVA,					-- Cuenta Venta Devolucion Retencion IVA Regimen Comun
	MtCiiu.CtaCreeNIF as NIIFCtaReteCree,

	----------------------Calculos  para  la  integración -------------------------------

	CalculosBasicos.Bruto,
	CalculosBasicos.TotalBruto,
	CalculosBasicos.DsctoComercial,
	CalculosBasicos.DstoProducto,
	CalculosBasicos.xBruto,
	CalculosBasicos.xTotalBruto,
	CalculosBasicos.xDsctoComercial,
	CalculosBasicos.xDstoProducto,
	CalculosBasicos.TotalVenta,
	CalculosBasicos.xTotalVenta,

--Cálculo de el IVA
	--round(CalculosBasicos.TotalVenta - CalculosBasicos.TotalBruto,trade.DECIMALES) as IvaBruto,
	round(CalculosBasicos.TotalVenta*mvtrade.IVA/100,trade.DECIMALES) as IvaBruto,



	( --verifica si se calcula IVA en Otra moneda 
	Case When Trade.TipoMoneda in ('O','M')
	       Then round(CalculosBasicos.xTotalVenta - CalculosBasicos.xTotalBruto,Trade.DECIMALES)
 	       Else 0
	     End 
	) as xIvaBruto,

--Cálculo de la retención de la Fuente
	( --verifica si se calcula retención en la fuente moneda local 
		Case when MVTRADE.ITEMRETE=1 AND TRADE.AUTRETFAC = 0 --Manejo de Control de Topes Item (PORETE % de retención de la fuente)
			   Then round(CalculosBasicos.TotalBruto*(MVTRADE.PORETE/100),trade.DECIMALES)
			   Else 0
		   End
	)as ReteFuente,
	( --verifica si se calcula retención en la fuente OtraMonea 
		Case when MVTRADE.ITEMRETE=1 and Trade.TipoMoneda in ('O','M') and TRADE.AUTRETFAC = 0 --Manejo de Control de Topes Item (PORETE % de retención de la fuente)
			   Then round(CalculosBasicos.xTotalBruto*(MVTRADE.PORETE/100),trade.DECIMALES)
			   Else 0
		   end
	)as xReteFuente,

--Cálculo de la retención de la Fuente
	( --verifica si se calcula retención en la fuente moneda local 
		Case when MVTRADE.ITEMRETE=1  and TRADE.AUTRETFAC = 1 --Manejo de Control de Topes Item (PORETE % de retención de la fuente)
			   Then round(CalculosBasicos.TotalBruto*(MVTRADE.PORETE/100),trade.DECIMALES)
			   Else 0
		   End
	)as AutoReteFuente,
	( --verifica si se calcula retención en la fuente OtraMonea 
		Case when MVTRADE.ITEMRETE=1 and Trade.TipoMoneda in ('O','M') and TRADE.AUTRETFAC = 1 --Manejo de Control de Topes Item (PORETE % de retención de la fuente)
			   Then round(CalculosBasicos.xTotalBruto*(MVTRADE.PORETE/100),trade.DECIMALES)
			   Else 0
		   end
	)as xAutoReteFuente,

--Cálculo de la retención en IVA
	
	Case when Trade.Pais = 'MX'
		Then(--verifica si se calcula retención en IVA moneda loca
			Case when MVTRADE.ITEMIVA=1 --Manejo de Control de Topes Item (Pretiva % de retención de Iva en Facturas)
				   Then round(Round((CalculosBasicos.TotalBruto*mvtrade.IVA/100),trade.DECIMALES)*(Mvtrade.PRETENIVA/100),trade.DECIMALES)
				   Else 0
			End)
		Else(Case when MVTRADE.ITEMIVA=1 --Manejo de Control de Topes Item (Pretiva % de retención de Iva en Facturas)
				   Then round(Round((CalculosBasicos.TotalBruto*mvtrade.IVA/100),trade.DECIMALES)*(Trade.Pretiva/100),trade.DECIMALES)
				   Else 0
			End)
	End as ReteIVa,
    Case when  Trade.Pais = 'MX'
		Then(--verifica si se calcula retención en IVA Otra moneda
			Case when MVTRADE.ITEMIVA=1 and Trade.TipoMoneda in ('O','M') --Manejo de Control de Topes Item (Pretiva % de retención de Iva en Facturas)
				   Then round(Round((CalculosBasicos.xTotalBruto*MvTrade.IVA/100),trade.DECIMALES)*(MvTrade.PRETENIVA/100),Trade.DECIMALES)
				   Else 0
			End)
		Else(Case when MVTRADE.ITEMIVA=1 and Trade.TipoMoneda in ('O','M') --Manejo de Control de Topes Item (Pretiva % de retención de Iva en Facturas)
				   Then round(Round((CalculosBasicos.xTotalBruto*MvTrade.IVA/100),trade.DECIMALES)*(Trade.PRETIVA/100),Trade.DECIMALES)
				   Else 0
			End)
	End as xReteIVA,

--Cálculo de la retención en ICA
	( --verifica si se calcula retención en ICA moneda local
		Case when MVTRADE.ITEMICA=1 and Trade.RegSimp = 0 and Trade.AutRetica = 0   --Manejo de Control de Topes Item
			   Then round(CalculosBasicos.TotalBruto*(mvtrade.PORICA/1000),trade.DECIMALES)
			   Else 0
		End
	)as ReteIca,
	( --verifica si se calcula retención en IVA Otra moneda
		Case when MVTRADE.ITEMICA=1 and Trade.TipoMoneda in ('O','M') and Trade.RegSimp = 0 and Trade.AutRetica = 0  --Manejo de Control de Topes Item
			   Then round(CalculosBasicos.xTotalBruto*(mvtrade.PORICA/1000),trade.DECIMALES)
			   Else 0
		End
	)as xReteIca, 

	
	( --verifica si se calcula retención recaudo en ICA para regimien simplificado moneda local
		Case when MVTRADE.ITEMICA=1 and Trade.RegSimp = 1 and Trade.AutRetica = 0 --Manejo de Control de Topes Item
			   Then round(CalculosBasicos.TotalBruto*(mvtrade.PORICA/1000),trade.DECIMALES)
			   Else 0
		End
	)as RecaudoICA, 

--Cálculo de la Autoretención en ICA
	( --verifica si se calcula retención en ICA moneda local
		Case when MVTRADE.ITEMICA=1 and Trade.RegSimp = 0 and Trade.AutRetica = 1   --Manejo de Control de Topes Item
			   Then round(CalculosBasicos.TotalBruto*(mvtrade.PORICA/1000),trade.DECIMALES)
			   Else 0
		End
	)as AutoReteICA,
	( --verifica si se calcula retención en IVA Otra moneda
		Case when MVTRADE.ITEMICA=1 and Trade.TipoMoneda in ('O','M') and Trade.RegSimp = 0 and Trade.AutRetica = 1  --Manejo de Control de Topes Item
			   Then round(CalculosBasicos.xTotalBruto*(mvtrade.PORICA/1000),trade.DECIMALES)
			   Else 0
		End
	)as xAutoReteICA, 
		
	--Impuesto al Consumo
	round(mvtrade.CANTIDAD*MVTRADE.IPCONSUMO,trade.DECIMALES)
	as Imp_Consumo,
	--AutoRetención del cree
	Case When MtMercia.EXCBASIMP = 0 and MtProCli.EsRetCree = 1
		 Then round(CalculosBasicos.TotalBruto*trade.PRETECREE/100,trade.DECIMALES)
		 Else 0
	End
	AS ReteCree,
	--AutoRetención del cree Otra moneda.
	Case When MtMercia.EXCBASIMP = 0 and MtProCli.EsRetCree = 1 and Trade.TipoMoneda in ('O','M')
		 Then round(CalculosBasicos.xTotalBruto*trade.PRETECREE/100,trade.DECIMALES)
		 Else 0
	End
	AS xReteCree,

	--Impuesto al Consumo para restaurantes, telefonia y vehículos.
	Round(CalculosBasicos.TotalBruto*(Mvtrade.IPCONSUMO/100),trade.DECIMALES)
	as ImpConsumo,

	--Impuesto al Consumo para licores 
	Round(Mvtrade.CANTIDAD*MVTRADE.IPCONSUBEB,trade.DECIMALES)
	as ImpLicores,

	--Impuesto al Consumo para Cigarrillos. Proceso de integración
	Round(MtMercia.Valipcmcig * MvTrade.Cantidad,Trade.Decimales) as ImpCigarrillos,

	Mvtrade.Idmvtrade as ID,
	Trade.codmoneda,
	Mvtrade.CodigoUEN
From Mvtrade
	Inner Join Trade  on Trade.Origen = MvTrade.Origen and Trade.TipoDcto = MvTrade.TipoDcto and Trade.NroDcto = MvTrade.NroDcto
	inner join CalculosBasicos   on (CalculosBasicos.Idmvtrade=MVTRADE.IDMVTRADE)
	Inner Join MtMercia  on MtMercia.Codigo = MvTrade.Producto
	Inner Join cuentasProducto on mtmercia.codigo=cuentasProducto.codigo
	Inner Join MtTarIVA On MtTarIVA.CODTARIVA = MvTrade.TARIVA	
	Inner Join MtTopRte on MtTopRte.CodRete = MvTrade.CodRete
	Inner Join MtRetica on MtRetica.codretica = MvTrade.CodRetica
	Inner Join MtCiiu on MtCiiu.Codigo = convert(char(5),dbo.F_Extraer_Variable('ACTECONOMICA','','CO'))
	Inner Join MtProCli on MtProCli.Nit = Trade.Nit
	Inner Join TipoDcto On Trade.Origen=TipoDcto.Origen and Trade.TipoDcto=TipoDcto.TipoDcto
Where ISNULL(CAJAREG,'')<>'' and Trade.Origen ='FAC'  and TipoDcto.DctoMae not in ('PD','CT') --and Trade.INTEGRADO = 0 
 --or  (ISNULL(CAJAREG,'')<>'' and Trade.Origen ='FAC'  and TipoDcto.DctoMae not in ('PD','CT') and Trade.INTNIIF=0 )
GO


