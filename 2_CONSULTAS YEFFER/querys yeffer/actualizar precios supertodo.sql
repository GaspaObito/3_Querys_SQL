update MvPrecio
set MvPrecio.PRECIO = (select PRECIO from AAActualizarprecio$
               where MvPrecio.CODPRODUC = AAActualizarprecio$.CODPRODUC) where  MvPrecio.CODPRECIO='1' and MvPrecio.CODPRODUC in (select CODPRODUC from AAActualizarprecio$) 
