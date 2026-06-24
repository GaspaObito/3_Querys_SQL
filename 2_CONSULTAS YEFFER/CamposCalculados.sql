use toscanazl

ALTER TABLE dbo.mtgruinv ADD PESOMLINEA AS (PESROL/MTROL); 

ALTER TABLE dbo.mtgruinv ADD CUBIMLINEA AS (((ALROL*ANROL)*LAROL)/MTROL); 



select top (10) * from mtgruinv