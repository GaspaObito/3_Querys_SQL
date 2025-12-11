USE ZIGMAFISCAL

select * from recformapago

select * from recibos ORDER BY rec_fecha
select * from movimientos

select * from FormasPago
select * from Formas_Pago_Ticket


SELECT COLUMN_NAME, DATA_TYPE, ORDINAL_POSITION
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'recibos'

select f.forma, p.fpa_nombre from Formas_Pago_Ticket as f, FormasPago as p  where p.pos_nombre=f.forma COLLATE Modern_Spanish_CI_AS group by f.forma, p.fpa_nombre