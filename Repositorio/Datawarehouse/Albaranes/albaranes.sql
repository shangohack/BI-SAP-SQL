USE [DM_PP]
GO

/****** Object:  View [dbo].[albaranes]    Script Date: 02/09/2023 1:48:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



ALTER VIEW [dbo].[albaranes]
AS

SELECT      DW.va4.LIKP.VBELN, 
            DW.va4.LIKP.WADAT_IST AS Fecha, 
            DW.va4.LIPS.POSNR, 
            DW.va4.LIKP.KUNAG AS N_CLIENTE, 
            DW.va4.KNA1.NAME1 AS CLIENTE, 
            DW.va4.LIPS.MATNR AS N_MATERIAL, 
            DW.va4.MAKT.MAKTG AS MATERIAL,

            CASE
                WHEN DW.va4.LIKP.VSTEL = 'DEV' THEN DW.va4.LIPS.NTGEW * - 1 ELSE DW.va4.LIPS.NTGEW
            END AS CANTIDAD,

            DW.va4.VBAP.NETWR / NULLIF (DW.va4.VBAP.KWMENG * (NULLIF (DW.va4.VBAP.UMZIZ / DW.va4.VBAP.UMZIN, 0)), 0) AS PRECIO, 
                                   
            CASE
                WHEN DW.va4.LIKP.VSTEL = 'DEV' 
                    THEN DW.va4.LIPS.NTGEW * (DW.va4.VBAP.NETWR / NULLIF (DW.va4.VBAP.KWMENG * (NULLIF (DW.va4.VBAP.UMZIZ / DW.va4.VBAP.UMZIN, 0)), 0)) * - 1  
                    ELSE DW.va4.LIPS.NTGEW * (DW.va4.VBAP.NETWR / NULLIF (DW.va4.VBAP.KWMENG * (NULLIF (DW.va4.VBAP.UMZIZ / DW.va4.VBAP.UMZIN, 0)), 0))
            END AS IMPORTE,

            DW.va4.VBUK.FKSTK AS STATUS_DOC, 
            DW.va4.LIKP.VSTEL, 
            DW.va4.KNVV.PLTYP AS Tarifa
                        
FROM            DW.va4.VBAP INNER JOIN
				DW.va4.MAKT INNER JOIN
					DW.va4.LIPS 
						ON DW.va4.MAKT.MANDT = DW.va4.LIPS.MANDT AND DW.va4.MAKT.MATNR = DW.va4.LIPS.MATNR INNER JOIN
                    DW.va4.LIKP INNER JOIN
                    DW.va4.KNA1 
						ON DW.va4.LIKP.MANDT = DW.va4.KNA1.MANDT AND DW.va4.LIKP.KUNAG = DW.va4.KNA1.KUNNR INNER JOIN
                    DW.va4.VBUK 
						ON DW.va4.LIKP.MANDT = DW.va4.VBUK.MANDT AND DW.va4.LIKP.VBELN = DW.va4.VBUK.VBELN 
						ON DW.va4.LIPS.MANDT = DW.va4.LIKP.MANDT AND DW.va4.LIPS.VBELN = DW.va4.LIKP.VBELN 
						ON DW.va4.VBAP.MANDT = DW.va4.LIPS.MANDT AND DW.va4.VBAP.VBELN = DW.va4.LIPS.VGBEL AND DW.va4.VBAP.POSNR = DW.va4.LIPS.VGPOS LEFT OUTER JOIN
                    DW.va4.KNVV 
						ON DW.va4.KNA1.KUNNR = DW.va4.KNVV.KUNNR AND DW.va4.KNA1.MANDT = DW.va4.KNVV.MANDT

WHERE       (DW.va4.LIKP.VBELN <> '0082008884') 
            AND (DW.va4.LIKP.WADAT_IST <> '00000000') 
            AND (DW.va4.LIKP.MANDT = '040') 
            AND (DW.va4.LIPS.MATKL = '40000' OR DW.va4.LIPS.MATKL = '40001') 
            AND (DW.va4.MAKT.SPRAS = 'S') 
            AND (YEAR(DW.va4.LIKP.WADAT_IST) >= YEAR(GETDATE()) - 3) 
                    OR (DW.va4.LIKP.VBELN <> '0082008884') 
                    AND (DW.va4.LIKP.WADAT_IST <> '00000000') 
                    AND (DW.va4.LIKP.MANDT = '040') 
                    AND (DW.va4.MAKT.SPRAS = 'S') 
                    AND (DW.va4.LIPS.MATNR = '000000000540474115') 
                    AND (DW.va4.LIKP.VSTEL = 'MAD') 
                        OR (DW.va4.LIKP.VBELN <> '0082008884') 
                        AND (DW.va4.LIKP.WADAT_IST <> '00000000') 
                        AND (DW.va4.LIKP.MANDT = '040') 
                        AND (DW.va4.MAKT.SPRAS = 'S') 
                        AND (DW.va4.LIPS.MATNR = '000000000920034201') 
                        AND (DW.va4.LIKP.VSTEL = 'MAD')



GO