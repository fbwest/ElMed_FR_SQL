declare @year int = 2022
declare @codemo int = 370024

declare @formT table (rowNum nvarchar(10), ds nvarchar(100), dsFrom nvarchar(10), dsTo nvarchar(10),
	dsLike nvarchar(100), dsName nvarchar(300))
insert into @formT values
	('1', 'A00-T98', null, null, '[A-T]%', N'<b>Всего, в том числе:</b>'),
	('2', 'A00-B99', null, null, '[AB]%', N'некоторые инфекционные и паразитарные болезни'),
	('3', 'C00-D48', 'C00', 'D48.9', null, N'новообразования'),
	('4', 'D50-D89', 'D50', 'D89.9', null, N'болезни крови, кроветворных органов и отдельные нарушения, вовлекающие' +
	                                       N'иммунный механизм'),
	('5', 'E00-E90', null, null, 'E%', N'болезни эндокринной системы, расстройства питания и нарушения обмена веществ'),
	('6', 'F00-F99', null, null, 'F%', N'психические расстройства и расстройства поведения'),
	('7', 'G00-G99', null, null, 'G%', N'болезни нервной системы'),
	('8', 'H00-H59', 'H00', 'H59.9', null, N'болезни глаза и его придаточного аппарата'),
	('9', 'H60-H95', 'H60', 'H95.9', null, N'болезни уха и сосцевидного отростка'),
	('10', 'I00-I99', null, null, 'I%', N'болезни системы кровообращения'),
	('11', 'J00-J99', null, null, 'J%', N'болезни органов дыхания'),
	('12', 'K00-K93', null, null, 'K%', N'болезни органов пищеварения'),
	('13', 'L00-L98', 'L00', 'L98.9', null, N'болезни кожи и подкожной клетчатки'),
	('14', 'M00-M99', null, null, 'M%', N'болезни костно-мышечной системы и соединительной ткани'),
	('15', 'N00-N99', null, null, 'N%', N'болезни мочеполовой системы'),
	('16', 'O00-O99', null, null, 'O%', N'беременность, роды и послеродовой период'),
	('17', 'Q00-Q99', null, null, 'Q%', N'врожденные аномалии, пороки развития, деформации и хромосомные нарушения'),
	('18', 'R00-R99', null, null, 'R%', N'симптомы, признаки и отклонения от нормы, выявленные при клинических' +
	                                    N'и лабораторных исследованиях, не классифицированные в других рубриках'),
	('19', 'S00-T98', null, null, '[ST]%', N'травмы, отравления и некоторые другие последствия воздействия внешних' +
	                                       N'причин'),
	('20', 'Z00-Z99', null, null, 'Z%', N'Кроме того: факторы, влияющие на состояние здоровья и обращения в' +
	                                    N'учреждения здравоохранения'),
	('21', 'U07.1-U07.2', null, null, 'U07.[12]', N'COVID-19')

declare @sampleT table (DS1 nvarchar(10), USL_OK int, RSLT int, KD int, NPOLIS nvarchar(20))
insert into @sampleT
	select sl.DS1, zsl.USL_OK, zsl.RSLT, sl.KD, p.NPOLIS
	from D3_SL_OMS sl
		left join D3_ZSL_OMS zsl on zsl.ID = sl.D3_ZSLID
		left join D3_PACIENT_OMS p on p.ID = zsl.D3_PID
		join D3_SCHET_OMS sc on zsl.D3_SCID = sc.ID and sc.YEAR = @year and sc.CODE_MO = @codemo
	where sl.DS1 <> '' and sl.D3_ZSLID <> '' and sc.ID <> ''
		and floor(datediff(day, DR, DATE_1) / 365.25) >= 18

select dsName, rowNum, ds,
    count(distinct case when USL_OK = 1 and RSLT in (101,201) then NPOLIS end) as c4,
    sum(iif(USL_OK = 1, KD, 0)) as c5,
    count(distinct case when USL_OK = 1 and RSLT in (105,106,205,206,313,405,406,411) then NPOLIS end) as c6,
    count(distinct case when USL_OK = 2 and RSLT in (101,201) then NPOLIS end) as c7,
    sum(iif(USL_OK = 2, KD, 0)) as c8,
    count(distinct case when USL_OK = 2 and RSLT in (105,106,205,206,313,405,406,411) then NPOLIS end) as c9
from @formT	left join @sampleT on DS1 between dsFrom and dsTo or DS1 like dsLike
group by dsName, rowNum, ds
order by cast(rowNum as int)