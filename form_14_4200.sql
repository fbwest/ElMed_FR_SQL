declare @year int = 2022
declare @codemo int = 370024

use Elmedicine_Ivanovo

declare @formT table (rowNum nvarchar(10), ds nvarchar(100), dsFrom nvarchar(10), dsTo nvarchar(10),
	dsLike nvarchar(100), dsName nvarchar(300))
insert into @formT values
	('0', '', null, null, null, 'на органе зрения (из стр. 4 табл. 4000):'),
	('1', '', null, null, null, 'из них:<br>с помощью микрохирургического оборудования<br>в том числе:'),
	('1.1', '', null, null, null, 'по поводу травмы глаза'),
	('1.2', '', null, null, null, 'по поводу диабетической ретинопатии'),
	('1.3', '', null, null, null, 'по поводу ретинопатии недоношеннных'),
	('1.4', '', null, null, null, 'по поводу отслойки сетчатки'),
	('2', '', null, null, null, 'с использованием лазерной аппаратуры<br>в том числе:'),
	('2.1', '', null, null, null, 'по поводу диабетической ретинопатии'),
	('2.2', '', null, null, null, 'по поводу ретинопатии недоношенных'),
	('3', '', null, null, null, 'на ухе (стр. 5.1 табл. 4000) - слухоулучшающие'),
	('3.1', '', null, null, null, 'из них кохлеарная имплантация'),
	('4', '', null, null, null, 'на желудке по поводу язвенной болезни (стр. 9.1 табл. 4000) – органосохраняющие')

select dsName, case when rowNum = '0' then '' else rowNum end as rowNum, ds
from @formT	--left join @sampleT on DS1 between dsFrom and dsTo or DS1 like dsLike
group by dsName, rowNum, ds
order by cast('/'+replace(rowNum,'.','/')+'/' as hierarchyid)