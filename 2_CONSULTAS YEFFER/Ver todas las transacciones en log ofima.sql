SELECT 
    [Current LSN], 
    [Operation], 
    [Transaction ID], 
    [Begin Time], 
    [End Time], 
    [AllocUnitName], 
    [Description]
FROM 
    fn_dblog(NULL, NULL) -- Ver todas las transacciones
WHERE 
    [Operation] IN ('LOP_INSERT_ROWS', 'LOP_DELETE_ROWS', 'LOP_MODIFY_ROW')
ORDER BY [Begin Time] DESC;