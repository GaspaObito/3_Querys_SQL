--Revision Nit de Supertodo a Bestprice, Iguala cantidad
use SUPERTODO
SELECT b.*
FROM BESTPRICE.dbo.Nit AS a
RIGHT JOIN SUPERTODO.dbo.Nit AS b
    ON a.NRONIT = b.NRONIT
WHERE a.NRONIT IS NULL;


use SUPERTODO
select COUNT(*) from Nit 
use BESTPRICE
select COUNT(*) from Nit
