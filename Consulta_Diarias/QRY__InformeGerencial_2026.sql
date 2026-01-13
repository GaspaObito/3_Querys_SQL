/*VERIFICACION INFORME GERENCIAL 2025*/
SELECT  'GENERAL' as MES,format (sum ((A.BRUTO-a.descuento)/1000), '#,###,###') AS VENTA
FROM COLNOTEXSA.dbo.trade a 
WHERE (a.ORIGEN='FAC') 
AND (a.TIPODCTO Not In ('P1','P2','P3','RE','AN','CD','06','13','PD','03','04','05','07','08','09',
'10','11','12','14','15','16','17','18','19','20','21','AJ','EP','CT','OP','OR','OF','OT','OM','CP','EM')) 
AND (a.FECHA>='01/01/2026' And a.FECHA<='31/12/2026')
and a.nrodcto not in ('118910')

union all

SELECT  'DICIEMBRE' as MES,format (sum ((A.BRUTO-a.descuento)/1000), '#,###,###') AS VENTA
FROM COLNOTEXSA.dbo.trade a 
WHERE (a.ORIGEN='FAC') 
AND (a.TIPODCTO Not In ('P1','P2','P3','RE','AN','CD','06','13','PD','03','04','05','07','08','09',
'10','11','12','14','15','16','17','18','19','20','21','AJ','EP','CT','OP','OR','OF','OT','OM','CP','EM')) 
AND (a.FECHA>='01/12/2026' And a.FECHA<='31/12/2026')
and a.nrodcto not in ('118910')

union all

SELECT  'NOVIEMBRE' as MES,format (sum ((A.BRUTO-a.descuento)/1000), '#,###,###') AS VENTA
FROM COLNOTEXSA.dbo.trade a 
WHERE (a.ORIGEN='FAC') 
AND (a.TIPODCTO Not In ('P1','P2','P3','RE','AN','CD','06','13','PD','03','04','05','07','08','09',
'10','11','12','14','15','16','17','18','19','20','21','AJ','EP','CT','OP','OR','OF','OT','OM','CP','EM')) 
AND (a.FECHA>='01/11/2026' And a.FECHA<='30/11/2026')
and a.nrodcto not in ('118910')

union all

SELECT   'OCTUBRE' as MES,format (sum ((A.BRUTO-a.descuento)/1000), '#,###,###') AS VENTA
FROM COLNOTEXSA.dbo.trade a 
WHERE (a.ORIGEN='FAC') 
AND (a.TIPODCTO Not In ('P1','P2','P3','RE','AN','CD','06','13','PD','03','04','05','07','08','09',
'10','11','12','14','15','16','17','18','19','20','21','AJ','EP','CT','OP','OR','OF','OT','OM','CP','EM')) 
AND (a.FECHA>='01/10/2026' And a.FECHA<='31/10/2026')
and a.nrodcto not in ('118910')

union all

SELECT   'SEPTIEMBRE' as MES,format (sum ((A.BRUTO-a.descuento)/1000), '#,###,###') AS VENTA
FROM COLNOTEXSA.dbo.trade a 
WHERE (a.ORIGEN='FAC') 
AND (a.TIPODCTO Not In ('P1','P2','P3','RE','AN','CD','06','13','PD','03','04','05','07','08','09',
'10','11','12','14','15','16','17','18','19','20','21','AJ','EP','CT','OP','OR','OF','OT','OM','CP','EM')) 
AND (a.FECHA>='01/09/2026' And a.FECHA<='30/09/2026')
and a.nrodcto not in ('118910')


union all

SELECT   'AGOSTO'as MES,format (sum ((A.BRUTO-a.descuento)/1000), '#,###,###') AS VENTA
FROM COLNOTEXSA.dbo.trade a 
WHERE (a.ORIGEN='FAC') 
AND (a.TIPODCTO Not In ('P1','P2','P3','RE','AN','CD','06','13','PD','03','04','05','07','08','09',
'10','11','12','14','15','16','17','18','19','20','21','AJ','EP','CT','OP','OR','OF','OT','OM','CP','EM')) 
AND (a.FECHA>='01/08/2026' And a.FECHA<='31/08/2026')
and a.nrodcto not in ('118910')


union all

SELECT   'JULIO'as MES,format (sum ((A.BRUTO-a.descuento)/1000), '#,###,###') AS VENTA
FROM COLNOTEXSA.dbo.trade a 
WHERE (a.ORIGEN='FAC') 
AND (a.TIPODCTO Not In ('P1','P2','P3','RE','AN','CD','06','13','PD','03','04','05','07','08','09',
'10','11','12','14','15','16','17','18','19','20','21','AJ','EP','CT','OP','OR','OF','OT','OM','CP','EM')) 
AND (a.FECHA>='01/07/2026' And a.FECHA<='31/07/2026')
and a.nrodcto not in ('118910')


union all

SELECT   'JUNIO'as MES,format (sum ((A.BRUTO-a.descuento)/1000), '#,###,###') AS VENTA
FROM COLNOTEXSA.dbo.trade a 
WHERE (a.ORIGEN='FAC') 
AND (a.TIPODCTO Not In ('P1','P2','P3','RE','AN','CD','06','13','PD','03','04','05','07','08','09',
'10','11','12','14','15','16','17','18','19','20','21','AJ','EP','CT','OP','OR','OF','OT','OM','CP','EM')) 
AND (a.FECHA>='01/06/2026' And a.FECHA<='30/06/2026')
and a.nrodcto not in ('118910')


union all

SELECT   'MAYO'as MES,format (sum ((A.BRUTO-a.descuento)/1000), '#,###,###') AS VENTA
FROM COLNOTEXSA.dbo.trade a 
WHERE (a.ORIGEN='FAC') 
AND (a.TIPODCTO Not In ('P1','P2','P3','RE','AN','CD','06','13','PD','03','04','05','07','08','09',
'10','11','12','14','15','16','17','18','19','20','21','AJ','EP','CT','OP','OR','OF','OT','OM','CP','EM')) 
AND (a.FECHA>='01/05/2026' And a.FECHA<='31/05/2026')
and a.nrodcto not in ('118910')


union all

SELECT   'ABRIL'as MES,format (sum ((A.BRUTO-a.descuento)/1000), '#,###,###') AS VENTA
FROM COLNOTEXSA.dbo.trade a 
WHERE (a.ORIGEN='FAC') 
AND (a.TIPODCTO Not In ('P1','P2','P3','RE','AN','CD','06','13','PD','03','04','05','07','08','09',
'10','11','12','14','15','16','17','18','19','20','21','AJ','EP','CT','OP','OR','OF','OT','OM','CP','EM')) 
AND (a.FECHA>='01/04/2026' And a.FECHA<='30/04/2026')
and a.nrodcto not in ('118910')


union all

SELECT   'MARZO'as MES,format (sum ((A.BRUTO-a.descuento)/1000), '#,###,###') AS VENTA
FROM COLNOTEXSA.dbo.trade a 
WHERE (a.ORIGEN='FAC') 
AND (a.TIPODCTO Not In ('P1','P2','P3','RE','AN','CD','06','13','PD','03','04','05','07','08','09',
'10','11','12','14','15','16','17','18','19','20','21','AJ','EP','CT','OP','OR','OF','OT','OM','CP','EM')) 
AND (a.FECHA>='01/03/2026' And a.FECHA<='31/03/2026')
and a.nrodcto not in ('118910')

union all

SELECT   'FEBRERO'as MES,format (sum ((A.BRUTO-a.descuento)/1000), '#,###,###') AS VENTA
FROM COLNOTEXSA.dbo.trade a 
WHERE (a.ORIGEN='FAC') 
AND (a.TIPODCTO Not In ('P1','P2','P3','RE','AN','CD','06','13','PD','03','04','05','07','08','09',
'10','11','12','14','15','16','17','18','19','20','21','AJ','EP','CT','OP','OR','OF','OT','OM','CP','EM')) 
AND (a.FECHA>='01/02/2026' And a.FECHA<='28/02/2026')
and a.nrodcto not in ('118910')


union all

SELECT   'ENERO' as MES,format (sum ((A.BRUTO-a.descuento)/1000), '#,###,###') AS VENTA
FROM COLNOTEXSA.dbo.trade a 
WHERE (a.ORIGEN='FAC') 
AND (a.TIPODCTO Not In ('P1','P2','P3','RE','AN','CD','06','13','PD','03','04','05','07','08','09',
'10','11','12','14','15','16','17','18','19','20','21','AJ','EP','CT','OP','OR','OF','OT','OM','CP','EM')) 
AND (a.FECHA>='01/01/2026' And a.FECHA<='31/01/2026')
and a.nrodcto not in ('118910')