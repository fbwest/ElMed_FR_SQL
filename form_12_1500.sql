declare @year int = 2022
declare @codemo int = 370024

declare @form table (rowNum nvarchar(10), ds nvarchar(100), dsFrom nvarchar(10),
	dsTo nvarchar(10), dsLike nvarchar(100), dsName nvarchar(300))
insert into @form values
	('1.0', 'A00-T98', null, null, '[A-T]%', N'<b>Зарегистрировано заболеваний – всего</b>'),
	('2.0', 'A00-B99', null, null, '[AB]%', N'<b>в том числе:<br>некоторые инфекционные и паразитарные болезни</b>'),
	('2.1', 'A00-A09', null, null, 'A0%', N'из них:<br>кишечные инфекции'),
	('2.2', 'A39', null, null, 'A39%', N'менингококковая инфекция'),
	('3.0', 'C00-D48', 'C00', 'D48.9', null, N'<b>новообразования</b>'),
	('3.1', 'C00-C96', 'C00', 'C96.9', null, N'из них:<br>злокачественные новообразования'),
	('3.1.1', 'C81-C96', 'C81', 'C96.9', null, N'из них:<br>злокачественные новообразования лимфоидной, кроветворной' +
	                                           N'и родственных им тканей'),
	('4.0', 'D50-D89', 'D50', 'D89.9', null, N'<b>болезни крови, кроветворных органов и отдельные нарушения,' +
	                                         N'вовлекающие иммунный механизм</b>'),
	('4.1', 'D50-D64', 'D50', 'D64.9', null, N'из них:<br>анемии'),
	('5.0', 'E00-E89', 'E00', 'E89.9', null, N'<b>болезни эндокринной системы, расстройства питания и нарушения' +
	                                         N'обмена веществ</b>'),
	('5.1', 'E00-E07', null, null, 'E0[0-7]%', N'из них:<br>болезни щитовидной железы'),
	('5.1.1', 'E00', null, null, 'E00%', N'из них:<br>синдром врожденной йодной недостаточности'),
	('5.1.2', 'E03.1', null, null, 'E03.1', N'врожденный гипотериоз'),
	('5.2', 'E10-E14', null, null, 'E1[0-4]%', N'сахарный диабет'),
	('5.3', 'E22', null, null, 'E22%', N'гиперфункция гипофиза'),
	('5.6', 'E25', null, null, 'E25%', N'адреногенитальные расстройства'),
	('5.9', 'E55.0', null, null, 'E55.0', N'рахит'),
	('5.10', 'E70.0', null, null, 'E70.0', N'фенилкетонурия'),
	('5.11', 'E74.2', null, null, 'E74.2', N'нарушения обмена галактозы (галактоземия)'),
	('5.14', 'E84', null, null, 'E84%', N'муковисцидоз'),
	('6.0', 'F01, F03-F99', 'F03', 'F99.9', 'F01%', N'<b>психические расстройства и расстройства поведения</b>'),
	('6.1', 'F70-F79', null, null, 'F7%', N'из них:<br>умственная отсталость'),
	('6.2', 'F80', null, null, 'F80%', N'специфические расстройства речи и языка'),
	('6.3', 'F82', null, null, 'F82%', N'специфические расстройства развития моторной функции'),
	('6.4', 'F84', null, null, 'F84%', N'общие расстройства психологического развития'),
	('6.4.1', 'F84.0-3', null, null, 'F84.[0-3]', N'из них:<br>детский аутизм, атипичный аутизм, синдром Pетта,' +
	                                              N'дезинтегративное расстройство детского возраста'),
	('7.0', 'G00-G98', 'G00', 'G98.9', null, N'<b>болезни нервной системы</b>'),
	('7.9.1', 'G80', null, null, 'G80%', N'из них:<br>церебральный паралич'),
	('8.0', 'H00-H59', 'H00', 'H59.9', null, N'<b>болезни глаза и его придаточного аппарата</b>'),
	('8.6', 'H35.1', null, null, 'H35.1', N'из них преретинопатия'),
	('9.0', 'H60-H95', 'H60', 'H95.9', null, N'<b>болезни уха и сосцевидного отростка</b>'),
	('9.4', 'H90', null, null, 'H90%', N'из них:<br>кондуктивная и нейросенсорная потеря слуха'),
	('10.0', 'I00-I99', null, null, 'I%', N'<b>болезни системы кровообращения</b>'),
	('11.0', 'J00-J98', 'J00', 'J98.9', null, N'<b>болезни органов дыхания</b>'),
	('11.1', 'J00-J06', null, null, 'J0[0-6]%', N'из них:<br>острые респираторные инфекции верхних дыхательных путей'),
	('11.2', 'J09-J11', 'J09', 'J11.9', null, N'грипп'),
	('11.3', 'J12-J16, J18', null, null, 'J1[234568]%', N'пневмонии'),
	('12.0', 'K00-K92', 'K00', 'K92.9', null, N'<b>болезни органов пищеварения</b>'),
	('13.0', 'L00-L98', 'L00', 'L98.9', null, N'<b>болезни кожи и подкожной клетчатки</b>'),
	('14.0', 'M00-M99', null, null, 'M%', N'<b>болезни костно-мышечной системы и соединительной ткани</b>'),
	('15.0', 'N00-N99', null, null, 'N%', N'<b>болезни мочеполовой системы</b>'),
	('17.0', 'P05-P96', 'P05', 'P96.9', null, N'<b>отдельные состояния, возникающие в перинатальном периоде</b>'),
	('17.1', 'P10-P15', null, null, 'P1[0-5]%', N'из них:<br>родовая травма'),
	('17.2', 'P52', null, null, 'P52%', N'внутричерепное нетравматическое кровоизлияние у плода и новорожденного'),
	('17.3', 'P91', null, null, 'P91%', N'другие нарушения церебрального статуса у новорожденного'),
	('18.0', 'Q00-Q99', null, null, 'Q%', N'<b>врожденные аномалии (пороки развития), деформации и хромосомные' +
	                                      N'нарушения</b>'),
	('18.1', 'Q00-Q07', null, null, 'Q0[0-7]%', N'из них:<br>врожденные аномалии развития нервной системы'),
	('18.2', 'Q20-Q28', null, null, 'Q2[0-8]%', N'врожденные аномалии системы кровообращения'),
	('18.3', 'Q35-Q37', null, null, 'Q3[5-7]%', N'расщелина губы и неба (заячья губа и волчья пасть)'),
	('18.4', 'Q90-Q99', null, null, 'Q9%', N'хромосомные аномалии, не классифицированные в других рубриках'),
	('19.0', 'R00-R99', null, null, 'R%', N'<b>симптомы, признаки и отклонения от нормы, выявленные при клинических' +
	                                      N'и лабораторных исследованиях, не классифицированные в других рубриках</b>'),
	('20.0', 'S00-T98', 'S00', 'T98.9', null, N'<b>травмы, отравления и некоторые другие последствия воздействия' +
	                                          N'внешних причин</b>'),
	('20.1', 'S01, S11, S21, S31, S41, S51, S61, S71, S81, S91', null, null, 'S[0-9]1%', N'из них:<br>открытые' +
	                                                            N'укушенные раны (только с кодом внешней причины W54)'),
	('21', 'U07.1, U07.2', null, null, 'U07.[12]', '<b>COVID-19</b>');

declare @tempTable table (DS1 nvarchar(10), ZSLID int, DATE_1 datetime, DN int, DS1_PR int,	DR datetime,
    NPOLIS nvarchar(20), CODE_USL nvarchar(20))
insert into @tempTable
    select sl.DS1, sl.D3_ZSLID, sl.DATE_1, sl.DN, sl.DS1_PR, p.DR, p.NPOLIS, usl.CODE_USL
    from D3_SL_OMS sl
        left join D3_ZSL_OMS zsl on zsl.ID = sl.D3_ZSLID
        left join D3_PACIENT_OMS p on p.ID = zsl.D3_PID
        left join D3_USL_OMS usl on usl.D3_SLID = sl.ID
        join D3_SCHET_OMS sc on zsl.D3_SCID = sc.ID and sc.YEAR = @year and sc.CODE_MO = @codemo
    where sl.DS1 <> '' and sl.D3_ZSLID <> '' and sc.ID <> ''
	    and floor(datediff(day, p.DR, sl.DATE_1) / 365.25) <= 3

select m.dsName, m.rowNum, m.ds,
	-- всего, ед
	count(distinct ZSLID) as c4,
	-- до 1 года
	count(distinct case when floor(datediff(day, DR, DATE_1) / 365.25) < 1 then ZSLID end) as c5,
	-- 1-3
	count(distinct case when floor(datediff(day, DR, DATE_1) / 365.25) between 1 and 3 then ZSLID end) as c6,
	-- до 1 мес
	count(distinct case when datediff(day, DR, DATE_1) < 30 then ZSLID end) as c7,
	-- взято под дн (чел) - до 1 года
	count(distinct case when DN = 2
		and floor(datediff(day, DR, DATE_1) / 365.25) < 1 then t.NPOLIS end) as c8,
	-- взято под дн (чел) - 1-3
	count(distinct case when DN = 2
		and floor(datediff(day, DR, DATE_1) / 365.25) between 1 and 3 then t.NPOLIS end) as c9,
	-- впервые в жизни диагноз - до 1 года
	count(distinct case when DS1_PR = 1
		and floor(datediff(day, DR, DATE_1) / 365.25) < 1 then ZSLID end) as c10,
	-- впервые в жизни диагноз - 1-3
	count(distinct case when DS1_PR = 1
		and floor(datediff(day, DR, DATE_1) / 365.25) between 1 and 3 then ZSLID end) as c11,
	-- впервые в жизни диагноз - взято под дн (чел) - до 1 года
	count(distinct case when DS1_PR = 1 and DN = 2
		and floor(datediff(day, DR, DATE_1) / 365.25) < 1 then ZSLID end) as c12,
	-- впервые в жизни диагноз - взято под дн (чел) - 1-3
	count(distinct case when DS1_PR = 1 and DN = 2
		and floor(datediff(day, DR, DATE_1) / 365.25) between 1 and 3 then ZSLID end) as c13,
	-- впервые в жизни диагноз - профосмотр - до 1 года
	count(distinct case when DS1_PR = 1
		and try_cast(CODE_USL as int) in (4,6,10,11,19,20,26,80,81,3004,3010,3011,3019,3020,3026,3080,3081)
		and floor(datediff(day, DR, DATE_1) / 365.25) < 1 then ZSLID end) as c14,
	-- впервые в жизни диагноз - профосмотр - 1-3
	count(distinct case when DS1_PR = 1
		and try_cast(CODE_USL as int) in (4,6,10,11,19,20,26,80,81,3004,3010,3011,3019,3020,3026,3080,3081)
		and floor(datediff(day, DR, DATE_1) / 365.25) between 1 and 3 then ZSLID end) as c15,
	-- снято с дисп (чел) - до 1 года
	count(distinct case when DN in (4,6)
		and floor(datediff(day, DR, DATE_1) / 365.25) < 1 then t.NPOLIS end) as c16,
	-- снято с дисп (чел) - 1-3
	count(distinct case when DN in (4,6)
		and floor(datediff(day, DR, DATE_1) / 365.25) between 1 and 3 then t.NPOLIS end) as c17,
	-- состоит под дисп на конец года (чел) - до 1 года
	count(distinct case when dnMax <= 2
		and floor(datediff(day, DR, DATE_1) / 365.25) < 1 then t.NPOLIS end) as c18,
	-- состоит под дисп на конец года (чел) - 1-3
	count(distinct case when dnMax <= 2
		and floor(datediff(day, DR, DATE_1) / 365.25) between 1 and 3 then t.NPOLIS end) as c19
from @form m
	left join @tempTable t on
		DS1 between m.dsFrom and m.dsTo
		or DS1 like m.dsLike
	left join (select NPOLIS, max(DN) as dnMax from @tempTable group by NPOLIS) d
		on d.NPOLIS = t.NPOLIS
group by m.dsName, m.rowNum, m.ds
order by cast('/'+replace(rowNum,'.','/')+'/' as hierarchyid)