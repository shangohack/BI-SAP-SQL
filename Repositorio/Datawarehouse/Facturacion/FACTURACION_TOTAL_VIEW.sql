USE [DM_PP]
GO

/****** Object:  View [dbo].[FACTURACION_TOTAL_VIEW]    Script Date: 02/09/2023 1:47:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



ALTER VIEW [dbo].[FACTURACION_TOTAL_VIEW]
AS
SELECT		CONVERT(NUMERIC(20, 0), DW.va4.VBRK.VBELN) AS FACTURA, 
			DW.va4.VBRP.MATNR AS COD_MATERIAL, 
			DW.va4.VBRK.FKDAT AS FECHA, 
			DW.va4.KNA1.NAME1 AS CLIENTE, 
			CONVERT(NUMERIC(20, 0), DW.va4.VBRK.KUNRG) AS COD_CLIENTE, 
			DW.va4.MAKT.MAKTG AS MATERIAL, 
			DW.va4.VBRP.NETWR * DW.dbo.SIGNO.SIGNO AS IMPORTE, 
			DW.va4.VBRP.WAVWR * DW.dbo.SIGNO.SIGNO AS COSTES, 
            DW.va4.VBRP.NETWR * DW.dbo.SIGNO.SIGNO - DW.va4.VBRP.WAVWR * DW.dbo.SIGNO.SIGNO AS GANANCIA, 
			CONVERT(NUMERIC(20, 0), DW.va4.VBRP.UMVKZ / DW.va4.VBRP.UMVKN * DW.va4.VBRP.FKIMG * DW.dbo.SIGNO.SIGNO) AS CANTIDAD, 
			DW.va4.VBRP.MEINS AS UNIDAD, 
			CONVERT(NUMERIC(20, 0), dbo.representantes.Representante) AS Representante, 
			CONVERT(NUMERIC(20, 0), dbo.comisionistas.comisionista) AS Comisionista, 
			dbo.comisionistas.Nom_comisionista, 
			DW.va4.KNA1.PSTLZ AS CP, 
			SUBSTRING(DW.va4.KNA1.ORT01, CHARINDEX('-', DW.va4.KNA1.ORT01) + 1, LEN(DW.va4.KNA1.ORT01)) AS CIUDAD

FROM		DW.va4.VBRK INNER JOIN
				DW.va4.VBRP 
					ON DW.va4.VBRK.MANDT = DW.va4.VBRP.MANDT AND DW.va4.VBRK.VBELN = DW.va4.VBRP.VBELN INNER JOIN
				DW.va4.KNA1 
					ON DW.va4.VBRK.KUNRG = DW.va4.KNA1.KUNNR AND DW.va4.VBRK.MANDT = DW.va4.KNA1.MANDT INNER JOIN
				DW.va4.MAKT 
					ON DW.va4.VBRP.MATNR = DW.va4.MAKT.MATNR AND DW.va4.VBRP.MANDT = DW.va4.MAKT.MANDT INNER JOIN
				DW.dbo.SIGNO 
					ON DW.va4.VBRK.FKART = DW.dbo.SIGNO.FKART LEFT OUTER JOIN
				dbo.representantes 
					ON DW.va4.KNA1.KUNNR = dbo.representantes.Cliente LEFT OUTER JOIN
				dbo.comisionistas 
					ON DW.va4.KNA1.KUNNR = dbo.comisionistas.Cliente

WHERE       (DW.va4.VBRP.MATKL = '40000' OR DW.va4.VBRP.MATKL = '40001') AND 
			(DW.va4.MAKT.SPRAS = 'S') AND 
			(CONVERT(NUMERIC(10, 0), SUBSTRING(DW.va4.VBRK.FKDAT, 1, 4)) >= YEAR(GETDATE()) - 3) AND 
			(CONVERT(NUMERIC(20, 0), dbo.comisionistas.comisionista) = '15170' OR
										CONVERT(NUMERIC(20, 0), dbo.comisionistas.comisionista) = '15160' OR
										CONVERT(NUMERIC(20, 0), dbo.comisionistas.comisionista) = '15133')

GO