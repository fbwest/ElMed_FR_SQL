/****** Script for SelectTopNRows command from SSMS  ******/
SELECT zsl.[D3_SCID], p.FAM, sc.YEAR, sc.MONTH
  FROM [Elmedicine_Ivanovo].[dbo].[D3_ZSL_OMS] zsl
  left join Elmedicine_Ivanovo.dbo.D3_PACIENT_OMS p on p.ID = zsl.D3_PID
  left join Elmedicine_Ivanovo.dbo.D3_SCHET_OMS sc on sc.ID = zsl.D3_SCID
  where sc.MONTH between 8 and 10
