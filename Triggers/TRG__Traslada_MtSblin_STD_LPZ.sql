/*Inserta las categorias crearas automaticamente a la Otra BD*/
CREATE TRIGGER Tr_Traslada_MtSblin_STD_LPZ
ON SUPERTODO.dbo.MtSblin
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO BESTPRICE.dbo.MtSblin(
  CODSBLIN, NOMBRE, STADSINCRO
    )
    SELECT 
  i.CODSBLIN,i.NOMBRE,i.STADSINCRO
    
FROM inserted i;
END;