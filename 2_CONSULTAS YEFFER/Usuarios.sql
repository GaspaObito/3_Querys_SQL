use CONTROL_OFIMAEnterprise
select *  from mtusuario where nombre like '%ibarra%'

use CONTROL_OFIMAEnterprise
update mtusuario
set PASSWORD ='*INACTIVO*'
where codusuario = 'MONICAY             '


use CONTROL_OFIMAEnterprise
update mtusuario
set TELEFONO ='INACTIVO'
where codusuario = 'MARIAB'


