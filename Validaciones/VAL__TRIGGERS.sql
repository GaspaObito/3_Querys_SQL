CREATE TRIGGER Tr_Traslada_Ref_STD_LPZ
ON Mtmercia
AFTER INSERT
AS
BEGIN
   SET NOCOUNT ON;
   -- Insert into TargetTable only if CreatedAt is within the last 24 hours
   INSERT INTO Bestprice_Backup.dbo.MtMercia
   SELECT *
   FROM Supertodo_Backup.dbo.MtMercia
   WHERE DATEDIFF(HOUR, CreatedAt, GETDATE()) <= 24;
END;

SELECT 
   SCHEMA_NAME(tbl.schema_id) + '.' + tbl.name AS TableName,
   trg.name AS TriggerName,
   CASE
       WHEN trg.is_instead_of_trigger = 1 THEN 'Instead Of'
       ELSE 'After'
   END AS TriggerType,
   OBJECT_DEFINITION(trg.object_id) AS TriggerDefinition
FROM
   sys.triggers trg
INNER JOIN
   sys.tables tbl ON trg.parent_id = tbl.object_id;

/*
CREATE TRIGGER dbo.Trg_Sync_Clientes_IUD
ON dbo.Clientes
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    -- INSERT
    INSERT INTO BD_Replica.dbo.Clientes (IdCliente, Nombre, Direccion, Telefono)
    SELECT i.IdCliente, i.Nombre, i.Direccion, i.Telefono
    FROM inserted i
    LEFT JOIN deleted d ON i.IdCliente = d.IdCliente
    WHERE d.IdCliente IS NULL;

    -- UPDATE
    UPDATE C2
    SET 
        C2.Nombre = i.Nombre,
        C2.Direccion = i.Direccion,
        C2.Telefono = i.Telefono
    FROM BD_Replica.dbo.Clientes C2
    INNER JOIN inserted i ON C2.IdCliente = i.IdCliente
    INNER JOIN deleted d ON i.IdCliente = d.IdCliente;

    -- DELETE
    DELETE C2
    FROM BD_Replica.dbo.Clientes C2
    INNER JOIN deleted d ON C2.IdCliente = d.IdCliente;
END;
*/