update MVPRECIO
set MVPRECIO.PRECIO = (select PRECIO from AAActualizarprecio250624$
               where MVPRECIO.CODPRODUC = AAActualizarprecio250624$.CODPRODUC) where  MVPRECIO.CODPRECIO='01' and MVPRECIO.CODPRODUC in (select CODPRODUC from AAActualizarprecio250624$) 


select * from mvprecio where  MVPRECIO.CODPRECIO='01'


