select * from trade where TIPODCTO='F4' and nit in ('1033684795-2','901161429-4') and DCTORCM='12205'
select * from mvtrade where nrodcto='122051' and fecha>'01-01-2024'
select * from ABOCXP where dcto='40292'
select * from ABONOS where dcto='40292'
select * from MVBANCOS where dcto='40292'
select * from MVTO where dcto='40292'
select * from Vpopup_TipoDcto_CxP
 40292     
40352     
SELECT * FROM TRADE WHERE NRODCTO='40352' AND TIPODCTO='F4'

select * from trade where TIPODCTO='F4' AND fecha>'01-03-2024' AND IVABRUTO >'0' and DCTORCM in('12205','12201','12203')

select * from ABOCXP where nit like '%901161429%'