/****** Script for SelectTopNRows command from SSMS  ******/
SELECT zsl.ID, zsl.USL_OK, RSLT, p.ID, DR, floor(datediff(day, DR, DATE_Z_1) / 365.25) as age, DS1
  FROM [Elmedicine_Ivanovo].[dbo].[D3_ZSL_OMS] zsl
  left join [Elmedicine_Ivanovo].[dbo].[D3_PACIENT_OMS] p on p.ID = zsl.D3_PID
  left join [Elmedicine_Ivanovo].[dbo].[D3_SL_OMS] sl on sl.D3_ZSLID = zsl.ID
  where rslt in (105,106,205,206,313,405,406,411) and YEAR(DATE_Z_1) = 2022