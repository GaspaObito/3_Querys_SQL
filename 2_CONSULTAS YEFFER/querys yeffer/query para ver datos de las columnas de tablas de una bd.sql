USE CONTROL_OFIMAEnterprise
SELECT* FROM MTGRUINV
----queryy para ver datos de las columnas de tablas de una bd
select COLUMN_NAME, TABLE_NAME
  from INFORMATION_SCHEMA.COLUMNS
 where TABLE_SCHEMA = 'dbo'
   and COLUMN_NAME='debito'
 order by ORDINAL_POSITION

select COLUMN_NAME
  from INFORMATION_SCHEMA.COLUMNS
 where TABLE_SCHEMA = 'dbo'
   and TABLE_NAME = 'Prueba'
 order by ORDINAL_POSITION