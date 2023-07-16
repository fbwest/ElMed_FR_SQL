declare @year int = 2022
declare @codemo int = 370024

use Elmedicine_Ivanovo

declare @formT table (rowNum nvarchar(10), ds nvarchar(100), dsFrom nvarchar(10), dsTo nvarchar(10),
	dsLike nvarchar(100), dsName nvarchar(300))
insert into @formT values
	('1', '', null, null, '%', 'Операций при врожденных пороках развития (ВПР) – всего'),
	('1.1', 'Q20-Q28', null, null, 'Q2[0-8]%', 'из них:<br><b>ВПР системы кровообращения</b>'),
	('1.1.1', '', null, null, null, 'из них у родившихся в сроки 22-37 недель беременности'),
	('1.2', 'Q50-Q64', 'Q50', 'Q64.9', null, '<b>ВПР мочеполовой системы</b>'),
	('1.2.1', '', null, null, null, 'из них у родившихся в сроки 22-37 недель беременности'),
	('1.3', 'Q00-Q07', null, null, 'Q0[0-7]%', '<b>ВПР нервной системы</b>'),
	('1.3.1', '', null, null, null, 'из них у родившихся в сроки 22-37 недель беременности'),
	('1.4', 'Q10-Q15', null, null, 'Q1[0-5]%', '<b>ВПР органов зрения</b>'),
	('1.4.1', '', null, null, null, 'из них у родившихся в сроки 22-37 недель беременности'),
	('1.5', 'Q30-Q34', null, null, 'Q3[0-4]%', '<b>ВПР органов дыхания</b>'),
	('1.5.1', '', null, null, null, 'из них у родившихся в сроки 22-37 недель беременности'),
	('1.6', 'Q30-Q34', null, null, 'Q3[0-4]%', '<b>расщелина губы и неба</b>'),
	('1.6.1', '', null, null, null, 'из них у родившихся в сроки 22-37 недель беременности'),
	('1.7', 'H35.1', null, null, 'H35.1', '<b>ретинопатия недоношенных</b><br>(родившихся в сроки 22-37 недель беременности)')

select dsName, rowNum, ds
from @formT	--left join @sampleT on DS1 between dsFrom and dsTo or DS1 like dsLike
group by dsName, rowNum, ds
order by cast('/'+replace(rowNum,'.','/')+'/' as hierarchyid)