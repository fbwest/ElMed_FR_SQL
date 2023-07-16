declare @year as int = 2022;
declare @monthFrom as int = 1;
declare @monthTo as int = 12;

use Elmedicine_Ivanovo;

select coalesce(CODE_MO, 'Итого') as CODE_MO, (case when CODE_MO is null then '' else max(nam_mok) end) as nam_mok,
	-- всего
	count(distinct case when USL_OK = 3 then NPOLIS end) as c3,
	count(distinct case when USL_OK = 3 then ID end) as c4,
	-- обращений
	count(distinct case when USL_OK = 3 and POVOD = 1
		and try_cast(CODE_USL as int) in (1,2,3,5,6,7,8,19,20,12,3001,3002,3005,3007,3008,3019,3020,3003,4057,4058,4059,4060,4061)
		then NPOLIS end) as c5,
	count(distinct case when USL_OK = 3 and POVOD = 1
		and try_cast(CODE_USL as int) in (1,2,3,5,6,7,8,19,20,12,3001,3002,3005,3007,3008,3019,3020,3003,4057,4058,4059,4060,4061)
		then ID end) as c6,
	-- посещений
	count(distinct case when USL_OK = 3 and (
		(POVOD = 30 and try_cast(CODE_USL as int) in (6,31,32,33,34,35,38,39,3031,3032,3033,3034,3035,3038,3039))
		or
		(POVOD = 50 and (try_cast(CODE_USL as int) in (4070,4071) or try_cast(CODE_USL as int) between 4201 and 4216)))
		then NPOLIS end) as c7,
	count(distinct case when USL_OK = 3 and (
		(POVOD = 30 and try_cast(CODE_USL as int) in (6,31,32,33,34,35,38,39,3031,3032,3033,3034,3035,3038,3039))
		or
		(POVOD = 50 and (try_cast(CODE_USL as int) in (4070,4071) or try_cast(CODE_USL as int) between 4201 and 4216)))
		then ID end) as c8,
	-- медицинская услуга
	count(distinct case when USL_OK = 3 and POVOD = 27 and (
		try_cast(CODE_USL as int) in (58,59,66,67,68,69,70,72,74,78,79,82,86,87,88,89,90,93,95,96,97,98,99,4072)
		or try_cast(CODE_USL as int) between 4001 and 4056
		or try_cast(CODE_USL as int) between 4080 and 4094)
		then NPOLIS end) as c9,
	count(distinct case when USL_OK = 3 and POVOD = 27 and (
		try_cast(CODE_USL as int) in (58,59,66,67,68,69,70,72,74,78,79,82,86,87,88,89,90,93,95,96,97,98,99,4072)
		or try_cast(CODE_USL as int) between 4001 and 4056
		or try_cast(CODE_USL as int) between 4080 and 4094)
		then ID end) as c10,
	-- ₽ всего
	sum(case when USL_OK = 3 and RowNum = 1 then SUM_M end) as c11,
	-- ₽ обращений
	sum(case when USL_OK = 3 and POVOD = 1
		and try_cast(CODE_USL as int) in (1,2,3,5,6,7,8,19,20,12,3001,3002,3005,3007,3008,3019,3020,3003,4057,4058,4059,4060,4061)
		and RowNum = 1 then SUM_M end) as c12,
	-- ₽ посещений
	sum(case when USL_OK = 3 and (
		(POVOD = 30 and try_cast(CODE_USL as int) in (6,31,32,33,34,35,38,39,3031,3032,3033,3034,3035,3038,3039))
		or
		(POVOD = 50 and (try_cast(CODE_USL as int) in (4070,4071) or try_cast(CODE_USL as int) between 4201 and 4216)))
		and RowNum = 1 then SUM_M end) as c13,
	-- ₽ медицинская услуга
	sum(case when USL_OK = 3 and POVOD = 27 and (
		try_cast(CODE_USL as int) in (58,59,66,67,68,69,70,72,74,78,79,82,86,87,88,89,90,93,95,96,97,98,99,4072)
		or try_cast(CODE_USL as int) between 4001 and 4056
		or try_cast(CODE_USL as int) between 4080 and 4094)
		and RowNum = 1 then SUM_M end) as c14
from (
	select sc.CODE_MO as CODE_MO, f003.nam_mok as nam_mok, zsl.USL_OK as USL_OK, p.NPOLIS as NPOLIS, sl.ID as ID,
		sl.POVOD as POVOD, usl.CODE_USL as CODE_USL, sl.SUM_M as SUM_M,
		row_number() over(partition by sl.ID order by usl.CODE_USL) as RowNum
	from D3_SL_OMS sl
		left join D3_ZSL_OMS zsl on zsl.ID = sl.D3_ZSLID
		left join D3_PACIENT_OMS p on p.ID = zsl.D3_PID
		left join D3_USL_OMS usl on usl.D3_SLID = sl.ID
		join D3_SCHET_OMS sc on zsl.D3_SCID = sc.ID and sc.YEAR = @year and sc.MONTH between @monthFrom and @monthTo
		left join F003 f003 on sc.CODE_MO = f003.mcod
	where sc.CODE_MO <> '' and (sl.DS1 like 'C%' or sl.DS1 like 'D0%')
) as t
group by rollup(CODE_MO)
order by (case when CODE_MO is null then 1 else 2 end), CODE_MO