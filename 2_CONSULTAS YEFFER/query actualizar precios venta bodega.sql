update MVPRECIO
set MVPRECIO.PRECIO = (select PRECIO from AAActualizarpre$
               where MVPRECIO.CODPRODUC = AAActualizarpre$.CODPRODUC) where  MVPRECIO.CODPRECIO='01' and MVPRECIO.CODPRODUC in (select CODPRODUC from AAActualizarpre$) 


select * from mvprecio
