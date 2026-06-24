SELECT *
FROM fn_dblog(NULL, NULL) -- Registro del log de transacciones
WHERE Operation LIKE '%Update%' OR Operation LIKE '%Insert%';