----query para solucionar reimpresion facturas o remisiones Alejandra Alza
---1 se ejecuta el update 
use COLNOTEXSA
UPDATE        TRADEMAS
SET COPIAS = '0'
WHERE      (NRODCTO IN ('131293'))
and tipodcto='fa'
---2 se revisa que quede en 0 
select nrodcto,copias from TRADEMAS
WHERE      (NRODCTO IN ('131292'))
and tipodcto='FA'