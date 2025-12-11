USE SUPERTODO;
select TOP 1000 * from MtMercia WHERE CODIGO='A-00019';
USE BESTPRICE;
select TOP 1000 * from MtMercia WHERE CODIGO='A-00019';
select * FROM MtSblin;

USE BESTPRICE;
select * FROM SALDOINV WHERE ANO='2025' AND PERIODO='3';
USE SUPERTODO;
select * FROM SALDOINV WHERE ANO='2025'  AND PERIODO='3';

select (ICANTIDAD-OCANTEMPAQ ) AS SALDO,*  FROM SALDOINV WHERE CODIGO='A-00022';

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

