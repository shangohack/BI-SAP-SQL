USE [DM_PP]
GO

/****** Object:  View [dbo].[direccionescorreo]    Script Date: 03/09/2023 15:45:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[direccionescorreo]
AS

SELECT      DW.va4.KNA1.KUNNR AS Cliente_Cod, 
			DW.va4.ADR6.ADDRNUMBER * 1 AS Cliente_smpt, 
			DW.va4.ADR6.SMTP_ADDR, 
			DW.va4.ADR6.CLIENT, 
			DW.va4.ADR6.FLGDEFAULT, 
			DW.va4.ADR6.HOME_FLAG

FROM        DW.va4.ADR6 INNER JOIN
				DW.va4.KNA1 
					ON DW.va4.ADR6.ADDRNUMBER = DW.va4.KNA1.ADRNR AND 
					   DW.va4.ADR6.CLIENT = DW.va4.KNA1.MANDT

WHERE       (DW.va4.ADR6.CLIENT = '040') AND 
			(DW.va4.ADR6.FLGDEFAULT = 'X') OR
				(DW.va4.ADR6.CLIENT = '040') AND 
				(DW.va4.ADR6.HOME_FLAG = 'X')

GO