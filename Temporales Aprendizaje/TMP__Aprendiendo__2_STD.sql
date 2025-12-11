USE Supertodo;
select * from trade WHERE FECHA between '20250318' AND '20250320' AND NRODCTO='36374';
select * from Mvtrade WHERE FECHA between '20250318' AND '20250320' AND NRODCTO='36374';
select * from MvCuadre WHERE DCTO='36374';
select * from MtMercia;
select * from MVCUADRE INNER JOIN
	Trade ON Trade.TIPODCTO = Trade.TIPODCTO AND trade.ORIGEN = MvCuadre.ORIGEN INNER JOIN
	Mvtrade ON Mvtrade.NRODCTO=Trade.NRODCTO AND trade.ORIGEN = Mvtrade.ORIGEN
WHERE Trade.FECHA between '20250318' AND '20250320' AND MvCuadre.DCTO='36374' AND Trade.NRODCTO='36374' ORDER BY trade.FECHA ASC;


