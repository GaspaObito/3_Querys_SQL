--CONSULTA TABLAS
USE SUPERTODO;
select * from Nit;
select * from MvPrecio;
select * from MtMercia;
select * from MtSblin;
select * from MtLinea;
select * from MtMercia;
select PRODUCTO,DESCUENTO,FECHA from Mvtrade WHERE DESCUENTO='10' AND FECHA between '20241215' AND '20250130';
--IMPORTANTE explicacion Funcionamiento
Select * from Mvtrade WHERE NRODCTO='19160' AND TIPODCTO='F2' AND PRODUCTO='A-00118';
Select * from Mvtrade WHERE DESCUENTO='10' AND FECHA between '20241215' AND '20250126' 
AND TIPODCTO IN ('F2','B1','B2') AND NRODCTO='32623';
select * from MvPrecio WHERE CODPRODUC='A-01924';
select * from MvCuadre WHERE FACTURA='19160';
--XX
select * from MtProcli WHERE NOMBRE='CLIENTE CONTADO';
select * from Mvtrade WHERE DESCUENTO='10';
select * from Mvtrade WHERE NRODCTO='32623' AND DESCUENTO='10';
--VALORUNIT este dato es el valor Unitario que se encuentra en las facturas pero
--ya tiene el *1.18, si deseamos lo contrario se divid /1.18

--DEFINITIVO PUNTO DE VENTA ES se encuentra en Informes %10
USE SUPERTODO;
SELECT 
    MtMercia.CODIGO as Producto,MtMercia.DESCRIPCIO as Nombre_Producto_Mvto,Mvtrade.NRODCTO as Documento,
    Mvtrade.TIPODCTO,
	(SELECT TOP 1 Nombre FROM MtProcli WHERE NIT = (SELECT TOP 1 NIT FROM MvCuadre WHERE DCTO = Mvtrade.NRODCTO)) as Nombre_Cliente,
	Mvtrade.FECHA as Fecha_Dcto,Mvtrade.CANTIDAD as Cantidad,
	ROUND(Mvtrade.VALORUNIT,2) as Vlr_Unitario,
	Mvtrade.DESCUENTO,
	ROUND(((Mvtrade.VALORUNIT * Mvtrade.CANTIDAD) - (Mvtrade.VALORUNIT * Mvtrade.CANTIDAD * 0.1)), 2) as Total_Product,
	(SELECT TOP 1 CODPRECIO FROM MvPrecio WHERE CODPRODUC = MtMercia.CODIGO) as Lista_Precios,
    MtMercia.IVA,
	ROUND((Mvtrade.VALORUNIT/((MtMercia.IVA/100)+1)),2) as Vlr_Unitario_sin_ITBIS,
	ROUND(Mvtrade.VALORUNIT / ((MtMercia.IVA / 100) + 1), 0) as Vlr_total_sin_ITBIS,
	ROUND(((Mvtrade.VALORUNIT / ((MtMercia.IVA / 100) + 1)*10)/100), 0) as Total_Dscto,
	MtSblin.NOMBRE
FROM 
    Mvtrade
INNER JOIN
    MtMercia ON Mvtrade.PRODUCTO = MtMercia.CODIGO
INNER JOIN
	MtSblin ON MtSblin.CODSBLIN=MtMercia.CODSBLIN
WHERE 
    Mvtrade.FECHA BETWEEN '20241215' AND '20250128' AND Mvtrade.DESCUENTO = '10' 
	AND Mvtrade.TIPODCTO IN ('B1','B2','B4','F2') ORDER BY Mvtrade.PRODUCTO ASC;
