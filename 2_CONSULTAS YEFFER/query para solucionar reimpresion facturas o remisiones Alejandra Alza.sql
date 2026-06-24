----query para solucionar reimpresion facturas o remisiones Alejandra Alza
---1 se ejecuta el update 
use COLNOTEXSA
UPDATE        TRADEMAS
SET COPIAS = '0'
WHERE      (NRODCTO IN ('136208'))
and tipodcto='FA'
---2 se revisa que quede en 0 FR - fa
select nrodcto,copias from TRADEMAS
WHERE      (NRODCTO IN ('136208'))
and tipodcto='FA'