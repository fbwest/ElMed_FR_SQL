declare @year int = 2022
declare @month int = 12

use Elmedicine_Ivanovo

declare @formT table (rowNum nvarchar(10), ds nvarchar(100), dsFrom nvarchar(10), dsTo nvarchar(10),
	dsLike nvarchar(100), dsName nvarchar(300))
insert into @formT values
	('1.', 'J00-J99', null, null, 'J%',
		'<span style="background-color:lightblue;"><b>Болезни системы кровообращения всего, из них:</b></span>'),
	('1.1', 'J00-J06', null, null, 'J0[0-6]%', 'Острые респираторные инфекции верхних дыхательных путей, из них'),
	('1.2', 'J05', null, null, 'J05%', '	острый обструктивный ларингит [круп] и эпиглоттит'),
	('1.3', 'J09-J11', 'J09', 'J11.9', null, 'Грипп'),
	('1.3.N', null, null, null, null, '<b>     Пневмония</b>'),
	('1.4', 'J12', null, null, 'J12%', 'Вирусная пневмония'),
	('1.5', 'J13-J15', null, null, 'J1[3-5]%', 'Бактериальная пневмония'),
	('1.6', 'J16', null, null, 'J16%', 'Другие острые пневмонии'),
	('1.7', 'J18', null, null, 'J18%', 'Пневмония без уточнения возбудителя'),
	('1.8', 'J20-J22', null, null, 'J2[0-2]%', 'Острые респираторные инфекции нижних дыхательных путей'),
	('2.', 'А00-А09', null, null, 'A0%',
		'<span style="background-color:lightblue;"><b>Кишечные инфекции, из них:</b></span>'),
	('2.1', 'A02', null, null, 'A02%', 'Сальмонеллезные инфекции'),
	('2.2', 'A04', null, null, 'A04%', 'Бактериальные кишечные инфекции'),
	('2.3', 'A08', null, null, 'A08%', 'Вирусные и другие уточненные кишечные инфекции'),
	('3.', 'K35-K38', null, null, 'K3[5-8]%',
		'<span style="background-color:lightblue;"><b>Болезни аппендикса (червеобразного отростка) всего, из них:</b></span>'),
	('3.1', 'K35', null, null, 'K35%', 'Острый аппендицит'),
	('4.', '', null, null, '%', '<span style="background-color:lightblue;"><b>ВСЕГО</b></span>')
	
declare @sampleT table (sl_ds1 nvarchar(10), sl_zslid int, zsl_rslt int, zsl_usl_ok int) 
insert into @sampleT
	select sl.DS1, sl.D3_ZSLID, zsl.RSLT, zsl.USL_OK
	from D3_SL_OMS sl
		left join D3_ZSL_OMS zsl on zsl.ID = sl.D3_ZSLID
		left join D3_PACIENT_OMS p on p.ID = zsl.D3_PID
		join D3_SCHET_OMS sc on zsl.D3_SCID = sc.ID and sc.YEAR = @year and sc.MONTH = @month
	where sl.D3_ZSLID <> '' and sc.ID <> '' and floor(datediff(day, p.DR, zsl.DATE_Z_1) / 365.25) between 1 and 17

select case when right(rowNum, 1) = 'N' then '' else rowNum end as rowNum, dsName, ds,
	-- амбул-поликл
	case when ds is not null then
		count(distinct case when zsl_usl_ok = 3 and zsl_rslt in (105,106,205,206,313,405,406,411) then sl_zslid end)
	else null end as c3,
	-- стационар
	case when ds is not null then
		count(distinct case when zsl_usl_ok = 1 and zsl_rslt in (105,106,205,206,313,405,406,411) then sl_zslid end)
	else null end as c4,
	-- стационарозамещ
	case when ds is not null then
		count(distinct case when zsl_usl_ok = 2 and zsl_rslt in (105,106,205,206,313,405,406,411) then sl_zslid end)
	else null end as c5,
	-- скорой вне МО
	case when ds is not null then
		count(distinct case when zsl_usl_ok = 4 and zsl_rslt in (405,406,411) then sl_zslid end)
	else null end as c6
from @formT f
	left join @sampleT on
		sl_ds1 between f.dsFrom and f.dsTo
		or sl_ds1 like f.dsLike
group by rowNum, dsName, ds
order by
	case when charindex('.', rowNum) = 0
		then rowNum
		else cast(substring(rowNum, 1, charindex('.', rowNum)-1) as int)
	end,
	case when charindex('.', rowNum, charindex('.', rowNum)+1) = 0
		then cast(substring(rowNum, charindex('.', rowNum)+1, len(rowNum)-charindex('.', rowNum)) as int)
		else substring(rowNum, charindex('.', rowNum)+1, charindex('.', rowNum, charindex('.', rowNum)+1)-charindex('.', rowNum)-1)
	end,
	case when charindex('.', rowNum, charindex('.', rowNum)+1) > 0 then
		substring(rowNum, charindex('.', rowNum, charindex('.', rowNum)+1)+1, len(rowNum)-charindex('.', rowNum, charindex('.', rowNum)+1))
	end