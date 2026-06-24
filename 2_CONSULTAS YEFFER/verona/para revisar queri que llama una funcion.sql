Select S.Codigo,Sum(S.Icantidad-S.Ocantidad) As TotalF, "+;
	" Dbo.F_Costo_GenProd(?mAno,?mPeriodo,S.Codigo,'PCOSTO',?mBodFiscal)  As mpCostoF, "+;
	" Dbo.F_Costo_GenProd(?mAno,?mPeriodo,S.Codigo,'HCOSTO',?mBodFiscal)  As mHCostoF, "+;
	" Dbo.F_Costo_GenProd(?mAno,?mPeriodo,S.Codigo,'XCOSTO',?mBodFiscal)  As mXCostoF, "+;
	" Dbo.F_Costo_GenProd(?mAno,?mPeriodo,S.Codigo,'NCOSTO',?mBodFiscal)  As mNCostoF, "+;
	" Dbo.F_Costo_GenProd(?mAno,?mPeriodo,S.Codigo,'XNCOSTO',?mBodFiscal)  As mXNCostoF "+;
	" From SaldoInv S "+;
	" Where ((S.Ano =?mAno and S.Periodo <=?mPeriodo) OR "+;
	" (S.ANO <?mAno)) " + mCond
	
