USE [DM_PP]
GO

/****** Object:  View [dbo].[ALBARANES_POLVO_VIEW]    Script Date: 02/09/2023 1:09:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




ALTER VIEW [dbo].[ALBARANES_POLVO_VIEW]
AS

SELECT      dbo.ALBARANES.N_CLIENTE, 
            dbo.ALBARANES.CLIENTE, 
            dbo.ALBARANES.VBELN AS ENTREGA, 
            dbo.ALBARANES.Fecha AS [Fecha albaran], 
            dbo.ALBARANES.POSNR AS Posicion, 
            dbo.ALBARANES.N_MATERIAL, 
            dbo.ALBARANES.MATERIAL, 
            dbo.ALBARANES.PRECIO,
            dbo.ALBARANES.CANTIDAD, 
            dbo.ALBARANES.IMPORTE AS IMPORTE,

            CASE 
                WHEN dbo.ALBARANES.PRECIO = dbo.precios_especiales.Importe THEN 'Especial' ELSE 

                    CASE
                        WHEN dbo.ALBARANES.Tarifa < 60 THEN

                            CASE
                                WHEN dbo.ALBARANES.Tarifa = '09' THEN 'Especial' ELSE 'SinTarifa'
                            END

                        ELSE 'Tarifa'
                    END
                                    
            END  AS [Cat. tarifa], 
			
			dbo.albaranes_almacen.Usuario AS [Operario], 
			dbo.albaranes_almacen.Fecha AS [Fecha preparacion]


FROM		dbo.albaranes RIGHT OUTER JOIN
				dbo.precios_especiales 
					ON dbo.albaranes.N_CLIENTE = dbo.precios_especiales.Cliente_E AND 
					   dbo.albaranes.N_MATERIAL = dbo.precios_especiales.Material_E LEFT OUTER JOIN
				dbo.albaranes_almacen 
					ON CONVERT(INT,dbo.albaranes.VBELN) = dbo.albaranes_almacen.Entrega

WHERE        (dbo.ALBARANES.POSNR >= 900000) AND (dbo.ALBARANES.VSTEL = 'MAD')

GO