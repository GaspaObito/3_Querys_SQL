SELECT SaldoInv.CODIGO, Sum(Icantidad-Ocantidad) AS 'TotalF', 
Dbo.F_Costo_GenProd(2025,12,Codigo,'PCOSTO',1) AS 'mpCostoF', 
Dbo.F_Costo_GenProd(2025,12,Codigo,'HCOSTO',1) AS 'mHCostoF', 
Sum(Icantidad-Ocantidad)*Dbo.F_Costo_GenProd(2025,12,Codigo,'HCOSTO',1)
FROM VERONASAS.dbo.SaldoInv SaldoInv
WHERE (SaldoInv.ANO=2025) AND (SaldoInv.PERIODO<=12) OR (SaldoInv.ANO<2025) 
GROUP BY SaldoInv.CODIGO