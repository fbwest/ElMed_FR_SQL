declare @year int = 2022
declare @codemo int = 370024

declare @formT table (rowNum nvarchar(10), job nvarchar(100))
insert into @formT values
	('1', N'Всего'),
	('2', N'из них в медицинских организациях, расположенных в сельской местности')

select rowNum, job
from @formT
order by rowNum