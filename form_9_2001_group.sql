declare @year int = 2022
declare @codemo int = 370024

declare @formT table (rowNum nvarchar(5), ds nvarchar(20), dsLike nvarchar(20), dsName nvarchar(100), id int)
insert into @formT values
	('01', '<b>B35.0-B35.9</b>', 'B35%', N'<b>Дерматофитии</b> (всего)', 1),
	('08', 'B35.1-3', 'B35.[1-3]', N'микозы стоп и кистей, всего', 2),
	('13', '<b>B86</b>', 'B86%', N'<b>Чесотка</b>', 3)

declare @sampleT table (DS1 nvarchar(10), DATE_Z_1 datetime, DR datetime, W int, KOD_TER int, NPOLIS nvarchar(20))
insert into @sampleT
	select sl.DS1, zsl.DATE_Z_1, p.DR, p.W, p.KOD_TER, p.NPOLIS
	from D3_SL_OMS sl
		left join D3_ZSL_OMS zsl on zsl.ID = sl.D3_ZSLID
		left join D3_PACIENT_OMS p on p.ID = zsl.D3_PID
		join D3_SCHET_OMS sc on zsl.D3_SCID = sc.ID and sc.YEAR = @year and sc.CODE_MO = @codemo
	where sl.DS1 <> '' and sl.D3_ZSLID <> '' and sc.ID <> ''
        and sl.DS1_PR <> 1 or sl.DS1_PR is null

select dsName, rowNum, ds, id,
    count(distinct NPOLIS) as c5,
    count(distinct iif(floor(datediff(day, DR, DATE_Z_1) / 365.25) <= 1, NPOLIS, null)) as c6,
    count(distinct iif(floor(datediff(day, DR, DATE_Z_1) / 365.25) between 2 and 14, NPOLIS, null)) as c7,
    count(distinct iif(floor(datediff(day, DR, DATE_Z_1) / 365.25) between 15 and 17, NPOLIS, null)) as c8,
    count(distinct iif(floor(datediff(day, DR, DATE_Z_1) / 365.25) between 18 and 29, NPOLIS, null)) as c9,
    count(distinct iif(floor(datediff(day, DR, DATE_Z_1) / 365.25) between 30 and 39, NPOLIS, null)) as c10,
    count(distinct iif(floor(datediff(day, DR, DATE_Z_1) / 365.25) >= 40, NPOLIS, null)) as c11,
    count(distinct iif(KOD_TER <> '', NPOLIS, null)) as c12,
    count(distinct iif(KOD_TER <> ''
                           and floor(datediff(day, DR, DATE_Z_1) / 365.25) <= 1, NPOLIS, null)) as c13,
    count(distinct iif(KOD_TER <> ''
                           and floor(datediff(day, DR, DATE_Z_1) / 365.25) between 2 and 14, NPOLIS, null)) as c14,
    count(distinct iif(KOD_TER <> ''
                           and floor(datediff(day, DR, DATE_Z_1) / 365.25) between 15 and 17, NPOLIS, null)) as c15
from @formT	f left join @sampleT on DS1 like dsLike
group by dsName, rowNum, ds, id
order by id