declare @year int = 2022
declare @codemo int = 370024

declare @formT table (rowNum nvarchar(10), ds nvarchar(100), dsFrom nvarchar(10), dsTo nvarchar(10),
	dsLike nvarchar(100), dsName nvarchar(300))
insert into @formT values
	('1', '', null, null, null, N'Врачи'),
	('2', '', null, null, null, N'Средние медицинские работники'),
	('3', '', null, null, null, N'Младший медицинский персонал'),
	('4', '', null, null, null, N'Прочий персонал'),
	('5', '', null, null, null, N'Всего')

select dsName, rowNum, ds
from @formT	--left join @sampleT on DS1 between dsFrom and dsTo or DS1 like dsLike
group by dsName, rowNum, ds
order by cast('/'+replace(rowNum,'.','/')+'/' as hierarchyid)