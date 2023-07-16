declare @year int = 2022
declare @codemo int = 370024

use Elmedicine_Ivanovo

declare @formT table (rowNum nvarchar(10), ds nvarchar(100), dsFrom nvarchar(10), dsTo nvarchar(10),
	dsLike nvarchar(100), dsName nvarchar(300))
insert into @formT values
	('1', '', null, null, '%', 'Трансплантации всего,<br>в том числе:'),
	('2', '', null, null, null, 'легкого'),
	('3', '', null, null, null, 'сердца'),
	('4', '', null, null, null, 'печени'),
	('5', '', null, null, null, 'поджелудочной железы'),
	('6', '', null, null, null, 'тонкой кишки'),
	('7', '', null, null, null, 'почки'),
	('8', '', null, null, null, 'костного мозга'),
	('8.1', '', null, null, null, 'в том числе: аутологичного'),
	('8.2', '', null, null, null, 'аллогенного'),
	('9', '', null, null, null, 'прочих органов'),
	('10', '', null, null, null, 'трансплантации 2-х и более органов')

select dsName, rowNum, ds
from @formT	--left join @sampleT on DS1 between dsFrom and dsTo or DS1 like dsLike
group by dsName, rowNum, ds
order by cast('/'+replace(rowNum,'.','/')+'/' as hierarchyid)