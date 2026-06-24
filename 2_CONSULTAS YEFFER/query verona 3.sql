SELECT     a.FECHA, b.NIT,B.TIPOVTA, a.NRODCTO, a.PRODUCTO, a.Vlrventa, a.cantorig, a.nombre
FROM         MVTRADE a INNER JOIN
                      TRADE B ON a.NRODCTO = B.NRODCTO AND a.TIPODCTO = B.TIPODCTO
WHERE     (a.TIPODCTO = 'pd') AND (a.FECHA >= GETDATE() -180)

