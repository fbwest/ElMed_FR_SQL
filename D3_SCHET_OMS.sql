use [Elmedicine_Ivanovo]
SELECT CODE_MO, nam_mok, count(*)
  FROM [dbo].[D3_SCHET_OMS]
  left join dbo.f003 on mcod = CODE_MO
  group by CODE_MO, nam_mok
  having CODE_MO <> ''
  order by CODE_MO