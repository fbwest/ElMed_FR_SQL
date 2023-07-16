declare @year as int = 2022;
declare @monthFrom as int = 1;
declare @monthTo as int = 12;

use Elmedicine_Ivanovo;

select coalesce(CODE_MO, 'Итого') as CODE_MO, (case when CODE_MO is null then '' else max(nam_mok) end) as nam_mok,
	-- всего
	count(distinct case when USL_OK = 1 then NPOLIS end) as c3,
	count(distinct case when USL_OK = 1 then ID end) as c4,
	-- химио
	count(distinct case when USL_OK = 1 and USL_TIP = 2	then NPOLIS end) as c5,
	count(distinct case when USL_OK = 1 and USL_TIP = 2	then ID end) as c6,
	-- лучевая
	count(distinct case when USL_OK = 1 and USL_TIP = 3	then NPOLIS end) as c7,
	count(distinct case when USL_OK = 1 and USL_TIP = 3	then ID end) as c8,
	-- химиолучевая
	count(distinct case when USL_OK = 1 and USL_TIP = 4	then NPOLIS end) as c9,
	count(distinct case when USL_OK = 1 and USL_TIP = 4	then ID end) as c10,
	-- хирургическая
	count(distinct case when USL_OK = 1 and USL_TIP = 1	then NPOLIS end) as c11,
	count(distinct case when USL_OK = 1 and USL_TIP = 1	then ID end) as c12,
	-- ₽ всего
	sum(case when USL_OK = 1 then SUM_M end) as c13,
	-- ₽ химио
	sum(case when USL_OK = 1 and USL_TIP = 2 then SUM_M end) as c14,
	-- ₽ лучевая
	sum(case when USL_OK = 1 and USL_TIP = 3 then SUM_M end) as c15,
	-- ₽ химиолучевая
	sum(case when USL_OK = 1 and USL_TIP = 4 then SUM_M end) as c16,
	-- ₽ хирургическая
	sum(case when USL_OK = 1 and USL_TIP = 1 then SUM_M end) as c17
from (
	select sc.CODE_MO as CODE_MO, f003.nam_mok as nam_mok, zsl.USL_OK as USL_OK, p.NPOLIS as NPOLIS, sl.ID as ID,
		sl.SUM_M as SUM_M, onk_usl.USL_TIP as USL_TIP
	from D3_SL_OMS sl
		left join D3_ZSL_OMS zsl on zsl.ID = sl.D3_ZSLID
		left join D3_PACIENT_OMS p on p.ID = zsl.D3_PID
		left join D3_ONK_SL_OMS onk_sl on onk_sl.D3_SLID = sl.ID
		left join D3_ONK_USL_OMS onk_usl on onk_usl.D3_ONKSLID = onk_sl.ID
		join D3_SCHET_OMS sc on zsl.D3_SCID = sc.ID and sc.YEAR = @year and sc.MONTH between @monthFrom and @monthTo
		left join F003 f003 on sc.CODE_MO = f003.mcod
	where sc.CODE_MO <> '' and (sl.DS1 like 'C%' or sl.DS1 like 'D0%')
) as t
group by rollup(CODE_MO)
order by (case when CODE_MO is null then 1 else 2 end), CODE_MO