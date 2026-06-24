USE [VERONASAS]
GO

/****** Object:  UserDefinedFunction [dbo].[fn_DetalleFE2]    Script Date: 22/04/2026 10:52:18 p. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO








ALTER FUNCTION [dbo].[fn_DetalleFE2]() 
        RETURNS @Tmp_Detalle TABLE 
        ( 
        Prefijo varchar(4), 
        Folio int, 
        Cantidad numeric(20,4), 
        Precio numeric(20,2), 
        Dscto numeric(10,4), 
        VlDscto numeric(20,4), 
        Parcial numeric(20,4), 
        Cuenta varchar(15), 
        Ccosto varchar(15), 
        CodPrd varchar(20), 
        Producto varchar(120), 
        Bodega varchar(20), 
        UndMed varchar(20), 
        Iva numeric(10,2), 
        VlImpconsu numeric(20,2), 
        Reffab varchar(20), 
        CodBarra varchar(20), 
        Lote varchar(20), 
        Fvencim datetime, 
        CantLote numeric(10,2), 
        Subccosto varchar(20), 
        codProCli varchar(20), 
        ordcompra varchar(20), 
        USDPrecio numeric(20,4), 
        USDPARCIAL numeric(20,4), 
        RETEFTE numeric(10,2), 
        ICA numeric(10,2), 
        AIU numeric(10,2), 
        ORIGEN CHAR(5), 
        ZVALORUNIT numeric(20,7), 
        IVAITEM numeric(20,2), 
        ZIVAITEM numeric(20,2),
		NOTASDETA varchar(500),
		Alto numeric(20,2),
		Ancho numeric(20,2),
		Cantidad1 numeric(20,2),
		Cantidad2 numeric(20,2),
		Uso varchar(10),
		MONEDA varchar(4),
		ZPARCIAL numeric(20,4)
		
        )
        -- WITH ENCRYPTION 
        AS 
        BEGIN 
            DECLARE @Prefijo varchar(4),@NumDcto int,@Cantidad numeric(20,4),@Precio numeric(20,4),@Dscto numeric(10,4),@VlDscto numeric(20,2),@Parcial numeric(20,4) 
            DECLARE @Cuenta varchar(15),@Ccosto varchar(15),@CodPrd varchar(20),@Producto varchar(120),@Bodega varchar(20),@UndMed varchar(20),@Iva numeric(10,2),@DCTO CHAR(10) 
            DECLARE @VlImpconsu numeric(20,2),@Reffab varchar(20),@CodBarra varchar(20),@Lote varchar(20),@Fvencim datetime,@CantLote numeric(10,2),@Subccosto varchar(20) 
            DECLARE @codProCli varchar(20),@ordcompra varchar(20),@USDPrecio numeric(20,4),@USDPARCIAL numeric(20,4),@RETEFTE numeric(10,2),@ICA numeric(10,2),@AIU numeric(10,2) 
            DECLARE @XVALORUN NUMERIC(17,4),@ZVALORUNIT numeric(20,7),@IVAITEM numeric(20,2),@ZIVAITEM numeric(20,2),@NOTASDETA varchar(500),@Alto numeric(20,2),@Ancho numeric(20,2)
			DECLARE @Cantidad1 numeric(20,2),@Cantidad2 numeric(20,2),@Uso varchar(10), @MONEDA varchar(4),@ZPARCIAL numeric(20,4), @CODMONEDA varchar(10),@tipven varchar(20),@VALUNID numeric(20,2),@descuento numeric(20,2),@bruto numeric(20,2)
			DECLARE @FECHAPROCESO DATETIME

			SET @FECHAPROCESO=GETDATE()-60

            DECLARE CURDET CURSOR FOR 
            SELECT tipodcto,nrodcto,CANTIDAD, VLRVENTA, DESCUENTO,CODCC,PRODUCTO,NOMBRE,BODEGA,UNDBASE,IVA,IPCONSUMO,'' as Reffab,ORDENNRO,CANVENTA,'' as Subccosto, 
                '' as codprocliente,'' as ordcompra,0 as USDPrecio,0 as USDPARCIAL,PORETE,PORICA,VALORAIU,XVALORUN,ZVALORUNIT,'',VALUNID
                FROM MVTRADE  
                WHERE ORIGEN='FAC'  AND TIPODCTO IN(/*'FA',*/'FE','NC','ND','01','02','03','04','05','07','08','09','10','11','12','13','14','15','16','17','18','19','20','21','22','24','25') 
				AND FECHA>@FECHAPROCESO -- AND YEAR(FECHA)=YEAR(GETDATE())  AND MONTH(FECHA)=MONTH(GETDATE())
				--and NRODCTO='105993'
			OPEN CURDET 
            FETCH CURDET INTO @Prefijo,@DCTO,@Cantidad,@Precio,@Dscto,@Ccosto,@CodPrd,@Producto,@Bodega,@UndMed,@Iva,@VlImpconsu,@Reffab,@Lote,@CantLote,@Subccosto, 
            @codProCli,@ordcompra,@USDPrecio,@USDPARCIAL,@RETEFTE,@ICA,@AIU,@XVALORUN,@ZVALORUNIT,@NOTASDETA,@VALUNID
            WHILE @@FETCH_STATUS = 0 
                BEGIN 

				/*****************************CODIGO POS****************************/


				 IF @Prefijo  IN ('01','02','03','04','05','06','07','08','09','10','11','12','13','14','15','16','17','18','19','20','21','22','24','25')--,'NC'
				 BEGIN 
					 --SET @VALUNID=@VALUNID/1.19
					 set @Precio=@VALUNID
					-- set @VlDscto=(@Precio*@DCTO)/100 
				 END
				
				 
				 /*****************************CODIGO POS****************************/
				 ---ROUND((@CANTIDAD*@Precio)-@VlDscto, 2) @VlDscto=((@CANTIDAD*@Precio)*@DSCTO)/100 
                	SET @VlDscto=((@CANTIDAD*@Precio)*@DSCTO)/100  
                	SET @Parcial=(@CANTIDAD*@Precio)
                	SELECT @Fvencim=FECHA1 FROM TRADE WHERE ORIGEN='FAC' AND TIPODCTO=@Prefijo AND NRODCTO=@DCTO 
                       	SELECT @Cuenta=CTAVTA,@CodBarra=CODBARRAS FROM MTMERCIA WHERE CODIGO=@CodPrd 
                        SET @IVAITEM=0
                        SET @ZIVAITEM=0

                    BEGIN 
                	    IF @XVALORUN<>0 
                		    BEGIN 
                			    SET @USDPRECIO=@XVALORUN 
                			    SET @USDPARCIAL=@XVALORUN*@CANTIDAD 
                		    END 
                    END 
                	BEGIN 
                		IF @PARCIAL < 0 
                			BEGIN 
                				SET @PARCIAL =ABS(@PARCIAL) 
                			END 
                	END 
				select @tipven=tipovta from TRADE where ORIGEN='FAC' AND TIPODCTO=@Prefijo AND NRODCTO=@DCTO
				if @tipven in ('0-027','0-046','0-059','0-063','0-088')
					begin
						set @Producto=rtrim(@Producto)+' - '+@Lote
					END
				IF @PREFIJO='FR'
				BEGIN
					SET @PREFIJO='FA'
				END
                	SET @NumDcto=CONVERT(INT,@DCTO) 
					--IF @PREFIJO='FE' BEGIN SET @PREFIJO='SETT' END
				
					SELECT @MONEDA=CODMONEDA FROM TRADE WHERE ORIGEN='FAC' AND TIPODCTO=@PREFIJO AND NRODCTO=@DCTO 
					SELECT @CODMONEDA=CODMONINT FROM MTMONEDA WHERE CODMONEDA=@MONEDA
					SET @ZPARCIAL=@ZVALORUNIT*@Cantidad
					set @CodBarra=''
						
                	INSERT INTO @Tmp_Detalle (Prefijo,Folio,Cantidad,Precio,Dscto,VlDscto,Parcial,Cuenta,Ccosto,CodPrd,Producto,Bodega,UndMed,Iva,VlImpconsu,Reffab, 
                		CodBarra,Lote,Fvencim,CantLote,Subccosto,codProCli,ordcompra,USDPrecio,USDPARCIAL,RETEFTE,ICA,AIU,ORIGEN,ZVALORUNIT,IVAITEM,ZIVAITEM,NOTASDETA
						,Alto,Ancho,Cantidad1,Cantidad2,Uso,MONEDA,ZPARCIAL) 
                	VALUES 
                		(@Prefijo,@NumDcto,@Cantidad,@Precio,@Dscto,@VlDscto,@Parcial,@Cuenta,@Ccosto,@CodPrd,@Producto,@Bodega,@UndMed,@Iva,@VlImpconsu,@Reffab, 
                		@CodBarra,@Lote,@Fvencim,@CantLote,@Subccosto,@codProCli,@ordcompra,@USDPrecio,@USDPARCIAL,@RETEFTE,@ICA,@AIU,'FAC',@ZVALORUNIT,@IVAITEM,@ZIVAITEM,'',
						0,0,0,0,'',@CODMONEDA,@ZPARCIAL) 
                	FETCH CURDET INTO @Prefijo,@DCTO,@Cantidad,@Precio,@Dscto,@Ccosto,@CodPrd,@Producto,@Bodega,@UndMed,@Iva,@VlImpconsu,@Reffab,@Lote,@CantLote,@Subccosto, 
						@codProCli,@ordcompra,@USDPrecio,@USDPARCIAL,@RETEFTE,@ICA,@AIU,@XVALORUN,@ZVALORUNIT,@NOTASDETA,@VALUNID
                END 
            CLOSE CURDET; 
            DEALLOCATE CURDET
      RETURN
END

GO


