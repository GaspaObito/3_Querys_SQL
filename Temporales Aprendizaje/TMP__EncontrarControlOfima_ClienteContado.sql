USE CONTROL_OFIMAEnterprise
select * from MTMENU

select * from GlobalBase where Ayuda like'%PUNTO DE VENTA%' AND Descripcion like'%PUNTO VENTA. CLIENTE DE CONTADO%'
select * from GlobalBaseOpcionPrograma WHERE idVariableBase='174376B1-8A5C-45F1-8422-1ACC25699AA7'

select * from MVMAQUINAUSUARIO WHERE USUARIO='%SUPERVI%'

select * from MVFILTRO

USE BESTPRICE
select * from MTGLOBAL where CAMPO='CLIENTECONTADO'
--CLIENTE X DEFECTO
select CODUSUARIO,VALOR from MVGLOUSR where CAMPO='CLIENTECONTADO'