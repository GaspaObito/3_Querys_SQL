USE 
    SUPERTODO
select 
    PRODUCTO,NOMBRE,NRODCTO from Mvtrade
update 
    tmercia set habilitado='0' from mtmercia where CODIGO IN ('51251001')
select 
    CODIGO,CODBARRAS,DESCRIPCIO,HABILITADO AS HABILITADO,PRODTER AS COMERCIAL,MATPRIMA AS COMPRAS from MtMercia
