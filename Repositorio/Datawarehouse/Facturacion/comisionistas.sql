USE [DM_PP]
GO

/****** Object:  View [dbo].[comisionistas]    Script Date: 02/09/2023 18:57:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[comisionistas]
AS

SELECT      DW.va4.KNVP.MANDT, 
			DW.va4.KNVP.LIFNR AS comisionista, 
			DW.va4.KNVP.KUNNR AS Cliente, 
			DW.va4.LFA1.NAME1 AS Nom_comisionista

FROM        dbo.representantes INNER JOIN
				DW.va4.KNVP 
					ON dbo.representantes.Cliente = DW.va4.KNVP.KUNNR INNER JOIN
                DW.va4.LFA1 
					ON DW.va4.KNVP.MANDT = DW.va4.LFA1.MANDT AND DW.va4.KNVP.LIFNR = DW.va4.LFA1.LIFNR

GROUP BY	DW.va4.KNVP.MANDT, DW.va4.KNVP.LIFNR, DW.va4.KNVP.KUNNR, DW.va4.KNVP.PARVW, DW.va4.LFA1.NAME1

HAVING      (DW.va4.KNVP.MANDT = '040') AND 
			(DW.va4.KNVP.LIFNR <> '0000015041' OR DW.va4.KNVP.LIFNR <> '0000015015') AND 
			(DW.va4.KNVP.PARVW = 'R0')

GO