/*CALCULOS INICIALES*/
USE SUPERTODO
select (BRUTO+IVABRUTO),FECHA,NOTA,* from Trade where NRODCTO='48149' AND TIPODCTO='R2'
select (CANTIDAD*VALORUNIT)-((CANTIDAD*VALORUNIT)*(DESCUENTO/100))AS VENTA,DESCUENTO,CANTIDAD,VALORUNIT,FECHA from Mvtrade where NRODCTO='48149' AND TIPODCTO='R2'

select VALOR,FECING,* from MvCuadre where DCTO='48149' AND TIPODCTO='R2'
/*INTEGRACION CREDITO PTVA*/
SELECT
    SUM(
        ROUND((Cantidad * ValorUnit), Trade.Decimales)
        - ROUND(ROUND((CanVenta * VlrVenta), Trade.Decimales) * Mvtrade.Descuento / 100, Trade.Decimales)
        - ROUND(
            (
                ROUND((CanVenta * VlrVenta), Trade.Decimales) 
                - ROUND(ROUND((CanVenta * VlrVenta), Trade.Decimales) * Mvtrade.Descuento / 100, Trade.Decimales)
            ) * Trade.DSCTOCOM / 100,
            Trade.Decimales
        )
    ) AS TOTAL_VENTA_FINAL
FROM MvTrade
INNER JOIN Trade 
    ON Trade.NRODCTO = Mvtrade.NRODCTO 
   AND Trade.TIPODCTO = Mvtrade.TIPODCTO
WHERE Trade.NroDcto = '48149' 
  AND Trade.TipoDcto = 'R2';

/*CALCULOS INTEGRACION INDIVIDUALES*/
SELECT
    ROUND((Cantidad * ValorUnit), Trade.Decimales)
    - ROUND(ROUND((CanVenta * VlrVenta), Trade.Decimales) * Mvtrade.Descuento / 100, Trade.Decimales)
    - ROUND(
        (
            ROUND((CanVenta * VlrVenta), Trade.Decimales) 
            - ROUND(ROUND((CanVenta * VlrVenta), Trade.Decimales) * Mvtrade.Descuento / 100, Trade.Decimales)
        ) * Trade.DSCTOCOM / 100,
        Trade.Decimales
      ) AS VENTA_FINAL,
      
    Mvtrade.Descuento,
    Cantidad,
    ValorUnit,
    trade.Fecha
FROM MvTrade
inner join Trade ON trade.NRODCTO = Mvtrade.NRODCTO AND trade.TIPODCTO = Mvtrade.TIPODCTO
WHERE trade.NroDcto = '48149' 
  AND trade.TipoDcto = 'R2';
