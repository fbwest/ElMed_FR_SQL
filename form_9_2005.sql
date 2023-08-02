declare @year int = 2022
declare @codemo int = 370024

declare @formT table (rowNum nvarchar(5), ds nvarchar(20), dsLike nvarchar(20), dsName nvarchar(100))
insert into @formT values
	('01', 'A50-A53', 'A5[0-3]%', N'Сифилис'),
	('02', 'A54.0-A54.9', 'A54%', N'Гонококковая инфекция'),
	('03', 'A59.0,8,9', 'A59.[089]', N'Трихомоноз'),
	('04', 'A56.0-4,8', 'A56.[0-48]', N'Хламидийные инфекции'),
	('05', 'A60.0,1,9', 'A60.[019]', N'Аногенитальная герпетическая вирусная инфекция'),
	('06', 'A63.0', 'A63.0', N'Аногенитальные (вен.) бородавки'),
	('07', 'B86', 'B86%', N'Чесотка')

declare @sampleT table (DS1 nvarchar(10), ID int)
insert into @sampleT
	select sl.DS1, sl.ID
	from D3_SL_OMS sl
		left join D3_ZSL_OMS zsl on zsl.ID = sl.D3_ZSLID
		join D3_SCHET_OMS sc on zsl.D3_SCID = sc.ID and sc.YEAR = @year and sc.CODE_MO = @codemo
	where sl.DS1 <> '' and sl.D3_ZSLID <> '' and sc.ID <> ''
        and sl.DS1_PR <> 1 or sl.DS1_PR is null

select dsName, rowNum
from @formT	f left join @sampleT on DS1 like dsLike
group by dsName, rowNum
order by rowNum