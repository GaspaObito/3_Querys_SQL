SELECT 
    t.Documento,
    MIN(t.Tipo_Dcto) AS Tipo_Dcto,
    MIN(t.Fecha_Dcto) AS Fecha_Dcto,
    MIN(t.Fecha_Inicial) AS Fecha_Inicial,
    MONTH(MIN(t.Fecha_Inicial)) AS MES,
    DAY(MIN(t.Fecha_Inicial)) AS DIA,
    MIN(t.Fecha_Final) AS Fecha_Final,
    MIN(t.Hora) AS Hora,
    MIN(t.Cliente) AS Cliente,
    MIN(t.Nombre_Cliente) AS Nombre_Cliente,
    MIN(t.Cod_PuntoVenta) AS Cod_PuntoVenta,
    MIN(t.Nombre_PuntoVenta) AS Nombre_PuntoVenta,
    MIN(t.Cod_Caja) AS Cod_Caja,
    MIN(t.Nombre_Caja) AS Nombre_Caja,
     MIN(t.Bruto) AS Bruto,
    SUM(t.Descuento) AS Descuento,
     MIN(t.Iva) AS Iva,
     MIN(t.Neto) AS Neto,
     MIN(t.Neto) AS Total_Pagado,
	 sum(t.Total_Pagado) AS Total_Pagado2,
	 min(t.Bruto+t.Iva-t.Descuento) AS comentario,
    MIN(t.Vendedor) AS Vendedor,
	MIN(t.Nombre_Vendedor) AS Nombre_Vendedor,
	

    -- Medios de pago en columnas
    MAX(CASE WHEN MedioPago = 'Efectivo' THEN Valor ELSE 0 END) AS Efectivo,
    MAX(CASE WHEN MedioPago = 'Cheque' THEN Valor ELSE 0 END) AS Cheque,
    MAX(CASE WHEN MedioPago = 'Tarjeta Débito' THEN Valor ELSE 0 END) AS Tarjeta_Debito,
    MAX(CASE WHEN MedioPago = 'Tarjeta Crédito' THEN Valor ELSE 0 END) AS Tarjeta_Credito,
    MAX(CASE WHEN MedioPago = 'Ventas a Crédito' THEN Valor ELSE 0 END) AS Ventas_A_Credito,
    MAX(CASE WHEN MedioPago = 'Bonos' THEN Valor ELSE 0 END) AS Bonos,
    MAX(CASE WHEN MedioPago = 'Vales' THEN Valor ELSE 0 END) AS Vales,
    MAX(CASE WHEN MedioPago = 'Otros' THEN Valor ELSE 0 END) AS Otros,
    MAX(CASE WHEN MedioPago = 'Saldo a Favor' THEN Valor ELSE 0 END) AS Saldo_A_Favor,
    MAX(CASE WHEN MedioPago = 'Transferencia' THEN Valor ELSE 0 END) AS Transferencia,
	MAX(CASE WHEN MedioPago = 'comentario' THEN Valor ELSE 0 END) AS comentario

FROM (
    SELECT 
        Documento,
        Tipo_Dcto,
        Fecha_Dcto,
        Fecha_Inicial,
        Fecha_Final,
        Hora,
        Cliente,
        Nombre_Cliente,
        Cod_PuntoVenta,
        Nombre_PuntoVenta,
        Cod_Caja,
        Nombre_Caja,
        Bruto,
        Descuento,
        Iva,
        Neto,
        Total_Pagado,
        Vendedor,
		Nombre_Vendedor,
        Comentario,
        MedioPago,
        Valor
    FROM [VERONASAS].[dbo].[Vconcepto_Valor_PuntoVenta_prueba]
    CROSS APPLY (
        VALUES
            ('Efectivo', Efectivo),
            ('Cheque', Cheque),
            ('Tarjeta Débito', Tarjeta_Debito),
            ('Tarjeta Crédito', Tarjeta_Credito),
            ('Ventas a Crédito', Ventas_A_Credito),
            ('Bonos', Bonos),
            ('Vales', Vales),
            ('Otros', Otros),
            ('Saldo a Favor', Saldo_A_Favor),
            ('Transferencia', Transferencia)
    ) AS mp(MedioPago, Valor)
    WHERE mp.Valor > 0
      AND Nombre_Caja LIKE '%multifabrics 77%'
) t
GROUP BY t.Documento
ORDER BY t.Documento ASC;