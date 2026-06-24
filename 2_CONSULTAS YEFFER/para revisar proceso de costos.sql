Select Trade.Nit as Nit,MvTrade.NroDcto as Dcto,
		 MvTrade.Producto as Codigo,MvTrade.Tipomvto, MvTrade.Cantidad, 
	MvTrade.Fecha,
		 MvTrade.valunid As Valorunit, MvTrade.Costo,
	MvTrade.xValunid As xValorunit, MvTrade.xCosto,
	MvTrade.hValunid As hValorunit, MvTrade.hCosto,
		MvTrade.nValUnid As nValorunit, MvTrade.nCosto, 
		 MvTrade.xnValUnid As xnValorunit, MvTrade.xnCosto,
		TipoMvto.Entrada As EntSal,TipoMvto.Descripcio,
	Case TipoMvto.Entrada When 1 Then '0' When 0 Then '1' End As Entrada,
		TipoMvto.Entrada as Entradas
		From MvTrade, Trade, TipoDcto, MtMercia, TipoMvto
Where Mvtrade.TipoDcto=TipoDcto.TipoDcto and Mvtrade.Origen = TipoDcto.Origen
and Trade.Origen=Mvtrade.Origen and Trade.Tipodcto=Mvtrade.Tipodcto 
And MvTrade.TipoMvto = TipoMvto.TipoMvto And
Trade.Nrodcto=Mvtrade.NroDcto and Month(MvTrade.Fecha) = 2 and year(MvTrade.Fecha) = 2025
AND TipoDcto.AfectaInv = 1 And MvTrade.Producto = MtMercia.Codigo And
MtMercia.Esproducto = 1 

 Select Isnull(Sum(ACosto),0) as mCosto From CostoInv
	Where Ano = 2025 And Periodo = 2
	And BodFiscal = 1
Select *From CostoInv
	Where Ano = 2025 And Periodo = 2
	And BodFiscal = 1  and HCOSTO='0'


select Codigo, Sum(Icantidad-Ocantidad) As TotalF,
Dbo.F_Costo_GenProd(2025,5,Codigo,'PCOSTO',1)  As mpCostoF,
Dbo.F_Costo_GenProd(2025,5,Codigo,'HCOSTO',1)  As mHCostoF,
Sum(Icantidad-Ocantidad)*Dbo.F_Costo_GenProd(2025,5,Codigo,'HCOSTO',1)
From SaldoInv 
Where ((Ano =2025 and Periodo <=5) OR (ANO <2025)) Group By Codigo

select Dbo.F_Costo_GenProd(2025,2,Codigo,'PCOSTO',1)  As mpCostoF from Dbo.F_Costo_GenProd()