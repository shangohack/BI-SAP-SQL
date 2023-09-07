USE [DM_PP]
GO

/****** Object:  View [dbo].[stock]    Script Date: 03/09/2023 20:18:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[stock]
AS

SELECT		DW.va4.MARD.LGORT AS ALMACEN, 
			DW.va4.MARC.MATNR AS COD_MATERIAL, 
			DW.va4.MAKT.MAKTG AS MATERIAL, 
			DW.va4.MARD.LABST AS STOCK, 
			DW.va4.MARM.UMREZ AS KgEnvase, 
			DW.va4.MARM.MEINH

FROM        DW.va4.MAKT INNER JOIN
            DW.va4.MARA INNER JOIN
				DW.va4.MARC 
					ON DW.va4.MARA.MATNR = DW.va4.MARC.MATNR AND DW.va4.MARA.MANDT = DW.va4.MARC.MANDT INNER JOIN
                DW.va4.MARD 
					ON DW.va4.MARC.MATNR = DW.va4.MARD.MATNR AND DW.va4.MARC.MANDT = DW.va4.MARD.MANDT 
					ON DW.va4.MAKT.MATNR = DW.va4.MARA.MATNR AND DW.va4.MAKT.MANDT = DW.va4.MARA.MANDT INNER JOIN
                DW.va4.MARM 
					ON DW.va4.MARC.MATNR = DW.va4.MARM.MATNR AND DW.va4.MARC.MANDT = DW.va4.MARM.MANDT

WHERE       (DW.va4.MARM.MEINH = 'UNI') AND (LEN(DW.va4.MARC.MATNR) = 16) AND (DW.va4.MARA.PRDHA = '00100') 
				AND 
			(DW.va4.MARD.WERKS = 'VAL') AND (DW.va4.MAKT.MANDT = '040') AND (DW.va4.MAKT.SPRAS = 'S') OR (DW.va4.MARM.MEINH = 'UNI') 
				AND 
			(DW.va4.MARD.WERKS = 'VAL') AND (DW.va4.MAKT.MANDT = '040') AND (DW.va4.MAKT.SPRAS = 'S') AND (DW.va4.MARD.LGORT = 'MAD') 
				AND 
            (DW.va4.MARC.MATNR = '000000000540474115' OR DW.va4.MARC.MATNR = '000000000920034201') OR (DW.va4.MARM.MEINH = 'UNI') 
				AND 
			(DW.va4.MARD.WERKS = 'VAL') AND (DW.va4.MAKT.MANDT = '040') AND (DW.va4.MAKT.SPRAS = 'S') AND (DW.va4.MARD.LGORT = 'LPM') 
				AND 
			(DW.va4.MARC.MATNR = '000000000540474115' OR DW.va4.MARC.MATNR = '000000000920034201') OR (DW.va4.MARM.MEINH = 'UNI') 
				AND 
			(DW.va4.MARD.WERKS = 'VAL') AND (DW.va4.MAKT.MANDT = '040') AND (DW.va4.MAKT.SPRAS = 'S') AND (DW.va4.MARD.LGORT = 'TNF') 
				AND 
            (DW.va4.MARC.MATNR = '000000000540474115' OR DW.va4.MARC.MATNR = '000000000920034201') OR (DW.va4.MARM.MEINH = 'UNI') 
				AND 
			(DW.va4.MARD.WERKS = 'VAL') AND (DW.va4.MAKT.MANDT = '040') AND (DW.va4.MAKT.SPRAS = 'S') AND (DW.va4.MARD.LGORT = 'MAD') 
				AND 
            (DW.va4.MARC.MATNR = '000000000000001752' OR DW.va4.MARC.MATNR = '000000000000007561' OR DW.va4.MARC.MATNR = '000000000000007576')

GO