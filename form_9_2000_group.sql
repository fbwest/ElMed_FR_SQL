declare @year int = 2022
declare @codemo int = 370024

declare @formT table (rowNum nvarchar(5), ds nvarchar(20), dsLike nvarchar(20), dsName nvarchar(100), id int)
insert into @formT values
	('01', 'A50-A53', 'A5[0-3]%', N'Сифилис - все формы, всего', 1),
	('48', 'A54.0-A54.9', 'A54%', N'Гонококковая инфекция, всего', 2),
	('55', 'A59.0,8,9', 'A59.[089]', N'Трихомоноз, всего', 3),
	('58', 'A56.0-4,8', 'A56.[0-48]', N'Хламидийные  инфекции, всего', 4),
	('61', 'A60.0,1,9', 'A60.[019]', N'Аногенитальная герпетическая вирусная инфекция, всего', 5),
	('64', 'A63.0', 'A63.0', N'Аногенитальные (венерические) бородавки, всего', 6)

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