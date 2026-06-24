Select Trade.Nit as Nit,MvTrade.NroDcto as Dcto,MvTrade.TIPODCTO,MvTrade.Producto as Codigo,MvTrade.Tipomvto, MvTrade.Cantidad,MvTrade.Fecha,MvTrade.valunid As Valorunit, MvTrade.Costo,MvTrade.xValunid As xValorunit, MvTrade.xCosto,
MvTrade.hValunid As hValorunit, MvTrade.hCosto, TipoMvto.Entrada As EntSal,TipoMvto.Descripcio,Case TipoMvto.Entrada When 1 Then '0' When 0 Then '1' End As Entrada,TipoMvto.Entrada as Entradas
From MvTrade, Trade, TipoDcto, MtMercia, TipoMvto
Where Mvtrade.TipoDcto=TipoDcto.TipoDcto and Mvtrade.Origen = TipoDcto.Origen
and Trade.Origen=Mvtrade.Origen and Trade.Tipodcto=Mvtrade.Tipodcto
And MvTrade.TipoMvto = TipoMvto.TipoMvto And
Trade.Nrodcto=Mvtrade.NroDcto and MvTrade.Fecha >='01-02-2025' AND MvTrade.Fecha <='28-02-2025'
AND TipoDcto.AfectaInv = 1 And MvTrade.Producto = MtMercia.Codigo AND MvTrade.Tipomvto='01'