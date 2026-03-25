/*Inserta las categorias crearas automaticamente a la Otra BD
ENABLE TRIGGER Tr_Traslada_MtSblin_LPZ_STD ON mtmercia*/
CREATE TRIGGER Tr_Traslada_MtSblin_LPZ_STD
ON BESTPRICE.dbo.MtSblin
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO SUPERTODO.dbo.MtSblin(
  CODSBLIN, NOMBRE, STADSINCRO
    )
    SELECT 
  i.CODSBLIN,i.NOMBRE,i.STADSINCRO
    
FROM inserted i;
END;