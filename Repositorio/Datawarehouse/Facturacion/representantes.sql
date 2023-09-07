USE [DM_PP]
GO

/****** Object:  View [dbo].[representantes]    Script Date: 02/09/2023 18:57:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[representantes]
AS

SELECT      MANDT, 
			PERNR AS Representante, 
			KUNNR AS Cliente

FROM        DW.va4.KNVP

GROUP BY	MANDT, PERNR, KUNNR, PARVW

HAVING		(MANDT = '040') AND (PARVW = 'VE') AND (PERNR = N'00000041')

GO