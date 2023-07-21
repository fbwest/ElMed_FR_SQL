declare @year int = 2022
declare @codemo int = 370024

declare @formT table (rowNum nvarchar(10), job nvarchar(100))
insert into @formT values
	('1', N'Врачи'),
	('2', N'Средние медицинские работники'),
	('3', N'Младший медицинский персонал'),
	('4', N'Прочий персонал'),
	('5', N'Всего')

select rowNum, job
from @formT
order by rowNum