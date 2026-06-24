USE [VERONASAS]
GO

/****** Object:  View [dbo].[Vconcepto_Valor_PuntoVenta]    Script Date: 12/03/2025 5:13:53 p. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--==========================================================================================
--Descripcion: Vista Para Informe Tipo Planilla Donde Se Va A Mostrar Los Conceptos De Pago 
--             Con Su Respectivo Valor Por Factura Y Tipodcto, Este Query Es Una Pivot
--Fecha		 : Marzo 12 De 2025  Punto Vneta yeffer lopez
--==========================================================================================
--SELECT * FROM Vconcepto_Valor_PuntoVenta

create View [dbo].[Vconcepto_Valor_PuntoVenta_prueba]
As 
(
	Select
	Tipodcto As Tipo_Dcto
	,Dcto As Documento
	,Fecha as Fecha_Dcto
	,Fecha As Fecha_Inicial
	,Fecha As Fecha_Final
	,Hora 
	,Nit As Cliente 
	,(Rtrim(Nit)+'   '+Nombre) As Nombre_Cliente
	,Cod_PuntoVenta
	,Nombre_PuntoVenta
	,Cod_Caja
	,Nombre_Caja
	,Bruto
	,Descuento
	,Iva
	,neto
	,COMENTARIO
	,Isnull([01],0) As Efectivo
	,Isnull([02],0) As Cheque
	,Isnull([03],0) As Tarjeta_Debito
	,Isnull([04],0) As Tarjeta_Credito
	,Isnull([05],0) As Ventas_A_Credito
	,Isnull([06],0) As Bonos
	,Isnull([07],0) As Vales
	,Isnull([08],0) As Otros
	,Isnull([09],0) As Saldo_A_Favor
	,Isnull([10],0) As Transferencia
	,Isnull([11],0) As Vueltas
	,(Isnull([01],0)+Isnull([02],0)+Isnull([03],0)+Isnull([04],0)+Isnull([05],0)+Isnull([06],0)+Isnull([07],0)+Isnull([08],0)+Isnull([09],0)+Isnull([10],0)) As Total_Pagado
	,Vendedor
	,Tipo_Venta
	,Zona
	,Canal
	,Ciudad
	,Tipo_Cliente
	,Tipo_Cartera
	,Centro_Costos
	,Nombre_Vendedor
	,Nombre_Tipo_Venta
	,Nombre_Zona 
	,Nombre_Canal
	,Nombre_Ciudad
	,Nombre_Tipo_Cliente
	,Nombre_Tipo_Cartera
	,Nombre_Centro_Costos
	From(
	
	Select Mtmedpag.CONCEPTO Concepto
		  ,Mvcuadre.mediopag1 as Concepto1
		  ,Mvcuadre.Valor
		  ,Mvcuadre.Tipodcto
		  ,Mvcuadre.Dcto
		  ,Mvcuadre.COMENTARIO
		  ,Trade.Fecha
		  ,Trade.Nit
		  ,Trade.Hora
		  ,Mtprocli.Nombre
		  ,MtCajaReg.PuntoVenta as Cod_PuntoVenta
		  ,MtPVenta.Nombre as Nombre_PuntoVenta
		  ,Trade.Cajareg as Cod_Caja
		  ,MtCajaReg.Nombre as Nombre_Caja
		  ,Trade.Bruto
		  ,Trade.Descuento
		  ,Trade.IvaBruto as IVa
		  ,(trade.bruto-trade.descuento+trade.ivabruto-trade.vlretfte-trade.vretica-trade.vretiva) as Neto
		  ,Trade.codven as Vendedor
		  ,Trade.tipovta	as	Tipo_Venta
		  ,MtProCli.zona as	Zona
		  ,MtProCli.canal	as	Canal
		  ,MtProCli.ciudad as	Ciudad
		  ,Mtprocli.tipocli as	Tipo_Cliente
		  ,Trade.tipocar	as	Tipo_Cartera
		  ,Trade.CodCc as	Centro_Costos   
		  ,Venden.nombre	as	Nombre_Vendedor
		  ,Tipovta.descripcio 	as	Nombre_Tipo_Venta
		  ,Zona.Nombre as Nombre_Zona
		  ,Canal.Nombre	as	Nombre_Canal
		  ,Ciudad.nombre as	Nombre_Ciudad
		  ,TipoCl.Nombre as Nombre_Tipo_Cliente
		  ,TipoCar.Nombre as Nombre_Tipo_Cartera
		  ,Centcos.nombre	as	Nombre_Centro_Costos
			From (select case when  valor <= 0 then '11' else mediopag  end as mediopag1 , * from mvcuadre) Mvcuadre 
				Inner Join Mtmedpag On Mvcuadre.Mediopag = Mtmedpag.Mediopag 
				Inner Join Mttipmovba On Mtmedpag.Tipomtvo = Mttipmovba.Tipomtvo 
				Inner Join Trade On  Mvcuadre.Tipodcto = Trade.Tipodcto And Trade.Origen = 'Fac' And Mvcuadre.Dcto = Trade.Nrodcto
				Inner Join Mtprocli On Trade.Nit = Mtprocli.Nit 
				Inner Join Venden On Trade.Codven = Venden.CodVen 
				Inner Join TipoVta  On  Trade.TipoVta = TipoVta.TipoVta
				Inner Join Zona On MtProCli.Zona = Zona.CodZona
				Inner Join Canal On MtProCli.Canal = Canal.CodCanal
				Inner Join Ciudad On Mtprocli.Ciudad=Ciudad.CodCiudad
				Inner Join TipoCl On MtProCli.TipoCli = TipoCl.CodTipoCl
				Inner Join TipoCar On MtProCli.TipoCar = TipoCar.CodTc 
				Inner Join MtCajaReg on MtCajaReg.codigo = Trade.cajareg
				Inner Join MtPVenta On MtCajaREg.PuntoVenta = MtPVenta.Codigo
				Inner Join CentCos On Trade.CodCc=CentCos.CodCc) As Tabla1
				
	Pivot
		(Sum(Valor)
		For Tabla1.Concepto In ([01], [02], [03],[04],[05],[06],[07],[08],[09],[10],[11])
	) As Pivottabla
)


--select * from Vconcepto_Valor_PuntoVenta where Documento = '46' and Tipo_Dcto = '04'
GO


