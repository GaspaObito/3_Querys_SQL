select * from vFacElectronicaEnc where Porcentaje_IVA like '%16%'
select * from vFacElectronicaEnc where NroDcto='60415'
select*from vFacElectronicaDet where NroDcto='61199'
select * from vFacElectronicaEnc
select * from vConcepto_Valor_PuntoVenta_Aux where Documento='14901'
select * from Vconcepto_Valor_PuntoVenta where Documento='14901'
CREATE  View [dbo].[V_Itibis_Pvta] as
select  distinct MvTrade.IVA, trade.NRODCTO, SUM((ROUND((ROUND(MvTrade.Cantidad*MvTrade.ValorUnit,2) - ROUND(ROUND(MvTrade.Cantidad*MvTrade.ValorUnit,2)*MvTrade.Descuento/100,2) 
			- ROUND((ROUND(MvTrade.Cantidad*MvTrade.ValorUnit,2) - ROUND(ROUND(MvTrade.Cantidad*MvTrade.ValorUnit,2)*MvTrade.Descuento/100,2))*Trade.DsctoCom/100,2))*MvTrade.IVA/100,1) ))  AS TOTAL_ITBIS 
from 
MvTrade,
Trade
Where MvTrade.NroDcto = Trade.NroDcto and MvTrade.TipoDcto = Trade.TipoDcto 
					GROUP BY MvTrade.IVA, Trade.NRODCTO order by trade.NRODCTO; 
go
SELECT distinct vFacElectronicaDet.IVA FROM vFacElectronicaDet WHERE NRODCTO='61199'

SELECT  SUM(vFacElectronicaDet.Valor_IVA) FROM vFacElectronicaDet WHERE NRODCTO='61199'

SELECT  *FROM V_Itibis_Pvta WHERE NRODCTO='60025'

select * from v_Int_PVta WHERE NRODCTO='60025' 

select * from V_Int_Mov_Pvta WHERE NRODCTO='60025' 

