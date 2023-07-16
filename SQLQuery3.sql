USE Elmedicine_Ivanovo;

declare @year as int = 2022;
declare @previousYear as int = @year - 1;
declare @month as int = 12;

SELECT sc.CODE_MO, sl.ID, sum(sl.KD)
  FROM D3_SL_OMS sl
	  left join D3_ZSL_OMS zsl on zsl.ID = sl.D3_ZSLID
	  left join D3_PACIENT_OMS p on p.ID = zsl.D3_PID
	  left join D3_USL_OMS usl on usl.D3_SLID = sl.ID and usl.CODE_USL = '36'
	  join D3_SCHET_OMS sc on zsl.D3_SCID = sc.ID and sc.YEAR = @year and sc.MONTH = @month
  WHERE sc.CODE_MO <> '' and sl.KD <> '' and sl.ID in (170046,170047,170058)
  group by sc.CODE_MO, sl.ID