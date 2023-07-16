declare @year as int = 2022;
declare @monthFrom as int = 1;
declare @monthTo as int = 12;

use Elmedicine_Ivanovo;

select sc.CODE_MO, f003.nam_mok,
	count(distinct case when zsl.USL_OK in (1,2) and zsl.VIDPOM in (32,33) then sl.ID end) as c5,
	sum(distinct case when zsl.USL_OK in (1,2) and zsl.VIDPOM in (32,33) then zsl.SUMV end) as c6

from D3_SL_OMS sl
	left join D3_ZSL_OMS zsl on zsl.ID = sl.D3_ZSLID
	join D3_SCHET_OMS sc on zsl.D3_SCID = sc.ID and sc.YEAR = @year and sc.MONTH between @monthFrom and @monthTo
	left join F003 f003 on sc.CODE_MO = f003.mcod

where sc.CODE_MO <> ''
group by sc.CODE_MO, f003.nam_mok
order by sc.CODE_MO, f003.nam_mok