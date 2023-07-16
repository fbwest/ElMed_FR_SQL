declare @year int = 2022
declare @codemo int = 370024

use Elmedicine_Ivanovo

declare @formT table (rowNum nvarchar(10), ds nvarchar(100), dsFrom nvarchar(10), dsTo nvarchar(10),
	dsLike nvarchar(100), dsName nvarchar(300))
insert into @formT values
	('1', '', null, null, null, 'Аналгоседация'),
	('2', '', null, null, null, 'Эпидуральная анестезия'),
	('3', '', null, null, null, 'Спинальная (субарахноидальная) анестезия'),
	('4', '', null, null, null, 'Спинально-эпидуральная анестезия'),
	('5', '', null, null, null, 'Тотальная внутривенная анестезия'),
	('6', '', null, null, null, 'Комбинированный эндотрахеальный наркоз'),
	('7', '', null, null, null, 'Сочетанная анестезия'),
	('8', '', null, null, null, 'Сакральная анестезия'),
	('9', '', null, null, null, 'Внутриполостная анестезия'),
	('10', '', null, null, null, 'Всего')

select dsName, rowNum, ds
from @formT	--left join @sampleT on DS1 between dsFrom and dsTo or DS1 like dsLike
group by dsName, rowNum, ds
order by cast('/'+replace(rowNum,'.','/')+'/' as hierarchyid)