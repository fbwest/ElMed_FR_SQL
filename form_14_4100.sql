declare @year int = 2022
declare @codemo int = 370024

use Elmedicine_Ivanovo

declare @formT table (rowNum nvarchar(10), ds nvarchar(100), dsFrom nvarchar(10), dsTo nvarchar(10),
	dsLike nvarchar(100), dsName nvarchar(300))
insert into @formT values
	('1', '', null, null, '%', '<b>Оперировано пациентов – всего, чел</b>'),
	('2', '', null, null, null, 'из них:<br>дети до 17 лет включительно'),
	('3', '', null, null, null, 'лица старше трудоспособного возраста'),
	('4', '', null, null, null, 'Из общего числа операций (стр.1, гр. 3 табл. 4000) проведено операций с использованием, ед:<br>лазерной аппаратуры'),
	('5', '', null, null, null, 'криогенной аппаратуры'),
	('6', '', null, null, null, 'эндоскопической аппаратуры'),
	('7', '', null, null, null, 'из них стерилизации женщин'),
	('8', '', null, null, null, 'рентгеновской аппаратуры')

select dsName, rowNum, ds
from @formT	--left join @sampleT on DS1 between dsFrom and dsTo or DS1 like dsLike
group by dsName, rowNum, ds
order by cast('/'+replace(rowNum,'.','/')+'/' as hierarchyid)