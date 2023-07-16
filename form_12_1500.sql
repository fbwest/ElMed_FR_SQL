declare @year int = 2022
declare @codemo int = 370024

use Elmedicine_Ivanovo

declare @form table (rowNum nvarchar(10), ds nvarchar(100), dsFrom nvarchar(10),
	dsTo nvarchar(10), dsLike nvarchar(100), dsName nvarchar(300))
insert into @form values
	('1.0', 'А00-Т98', null, null, '[A-T]%', '<b>Зарегистрировано заболеваний – всего</b>'),
	('2.0', 'А00-B99', null, null, '[AB]%', '<b>в том числе:<br>некоторые инфекционные и паразитарные болезни</b>'),
	('2.1', 'А00-А09', null, null, 'A0%', 'из них:<br>кишечные инфекции'),
	('2.2', 'A39', null, null, 'A39%', 'менингококковая инфекция'),
	('3.0', 'С00-D48', 'C00', 'D48.9', null, '<b>новообразования</b>'),
	('3.1', 'С00-С96', 'C00', 'C96.9', null, 'из них:<br>злокачественные новообразования'),
	('3.1.1', 'С81-С96', 'C81', 'C96.9', null, 'из них:<br>злокачественные новообразования лимфоидной, кроветворной и родственных им тканей'),
	('4.0', 'D50-D89', 'D50', 'D89.9', null, '<b>болезни крови, кроветворных органов и отдельные нарушения, вовлекающие иммунный механизм</b>'),
	('4.1', 'D50-D64', 'D50', 'D64.9', null, 'из них:<br>анемии'),
	('5.0', 'Е00-Е89', 'E00', 'E89.9', null, '<b>болезни эндокринной системы, расстройства питания и нарушения обмена веществ</b>'),
	('5.1', 'Е00-Е07', null, null, 'E0[0-7]%', 'из них:<br>болезни щитовидной железы'),
	('5.1.1', 'E00', null, null, 'E00%', 'из них:<br>синдром врожденной йодной недостаточности'),
	('5.1.2', 'Е03.1', null, null, 'Е03.1', 'врожденный гипотериоз'),
	('5.2', 'Е10-Е14', null, null, 'E1[0-4]%', 'сахарный диабет'),
	('5.3', 'E22', null, null, 'E22%', 'гиперфункция гипофиза'),
	('5.6', 'E25', null, null, 'E25%', 'адреногенитальные расстройства'),
	('5.9', 'Е55.0', null, null, 'Е55.0', 'рахит'),
	('5.10', 'Е70.0', null, null, 'Е70.0', 'фенилкетонурия'),
	('5.11', 'Е74.2', null, null, 'Е74.2', 'нарушения обмена галактозы (галактоземия)'),
	('5.14', 'E84', null, null, 'E84%', 'муковисцидоз'),
	('6.0', 'F01, F03-F99', 'F03', 'F99.9', 'F01%', '<b>психические расстройства и расстройства поведения</b>'),
	('6.1', 'F70-F79', null, null, 'F7%', 'из них:<br>умственная отсталость'),
	('6.2', 'F80', null, null, 'F80%', 'специфические расстройства речи и языка'),
	('6.3', 'F82', null, null, 'F82%', 'специфические расстройства развития моторной функции'),
	('6.4', 'F84', null, null, 'F84%', 'общие расстройства психологического развития'),
	('6.4.1', 'F84.0-3', null, null, 'F84.[0-3]', 'из них:<br>детский аутизм, атипичный аутизм, синдром Ретта, дезинтегративное расстройство детского возраста'),
	('7.0', 'G00-G98', 'G00', 'G98.9', null, '<b>болезни нервной системы</b>'),
	('7.9.1', 'G80', null, null, 'G80%', 'из них:<br>церебральный паралич'),
	('8.0', 'H00-H59', 'H00', 'H59.9', null, '<b>болезни глаза и его придаточного аппарата</b>'),
	('8.6', 'Н35.1', null, null, 'Н35.1', 'из них преретинопатия'),
	('9.0', 'H60-H95', 'H60', 'H95.9', null, '<b>болезни уха и сосцевидного отростка</b>'),
	('9.4', 'Н90', null, null, 'Н90%', 'из них:<br>кондуктивная и нейросенсорная потеря слуха'),
	('10.0', 'I00-I99', null, null, 'I%', '<b>болезни системы кровообращения</b>'),
	('11.0', 'J00-J98', 'J00', 'J98.9', null, '<b>болезни органов дыхания</b>'),
	('11.1', 'J00-J06', null, null, 'J0[0-6]%', 'из них:<br>острые респираторные инфекции верхних дыхательных путей'),
	('11.2', 'J09-J11', 'J09', 'J11.9', null, 'грипп'),
	('11.3', 'J12-J16, J18', null, null, 'J1[234568]%', 'пневмонии'),
	('12.0', 'K00-K92', 'K00', 'K92.9', null, '<b>болезни органов пищеварения</b>'),
	('13.0', 'L00-L98', 'L00', 'L98.9', null, '<b>болезни кожи и подкожной клетчатки</b>'),
	('14.0', 'M00-M99', null, null, 'M%', '<b>болезни костно-мышечной системы и соединительной ткани</b>'),
	('15.0', 'N00-N99', null, null, 'N%', '<b>болезни мочеполовой системы</b>'),
	('17.0', 'P05-P96', 'P05', 'P96.9', null, '<b>отдельные состояния, возникающие в перинатальном периоде</b>'),
	('17.1', 'Р10-Р15', null, null, 'P1[0-5]%', 'из них:<br>родовая травма'),
	('17.2', 'Р52', null, null, 'P52%', 'внутричерепное нетравматическое кровоизлияние у плода и новорожденного'),
	('17.3', 'Р91', null, null, 'Р91%', 'другие нарушения церебрального статуса у новорожденного'),
	('18.0', 'Q00-Q99', null, null, 'Q%', '<b>врожденные аномалии (пороки развития), деформации и хромосомные нарушения</b>'),
	('18.1', 'Q00-Q07', null, null, 'Q0[0-7]%', 'из них:<br>врожденные аномалии развития нервной системы'),
	('18.2', 'Q20-Q28', null, null, 'Q2[0-8]%', 'врожденные аномалии системы кровообращения'),
	('18.3', 'Q35-Q37', null, null, 'Q3[5-7]%', 'расщелина губы и неба (заячья губа и волчья пасть)'),
	('18.4', 'Q90-Q99', null, null, 'Q9%', 'хромосомные аномалии, не классифицированные в других рубриках'),
	('19.0', 'R00-R99', null, null, 'R%', '<b>симптомы, признаки и отклонения от нормы, выявленные при клинических и лабораторных исследованиях, не классифицированные в других рубриках</b>'),
	('20.0', 'S00-T98', 'S00', 'T98.9', null, '<b>травмы, отравления и некоторые другие последствия воздействия внешних причин</b>'),
	('20.1', 'S01, S11, S21, S31, S41, S51, S61, S71, S81, S91', null, null, 'S[0-9]1%', 'из них:<br>открытые укушенные раны (только с кодом внешней причины W54)'),
	('21', 'U07.1, U07.2', null, null, 'U07.[12]', '<b>COVID-19</b>');

declare @tempTable table (sl_ds1 nvarchar(10), sl_zslid int, sl_date_1 datetime, sl_dn int, sl_ds1_pr int,
	p_dr datetime, p_npolis nvarchar(20), usl_code_usl nvarchar(20)) 
  
insert into @tempTable
select sl.DS1, sl.D3_ZSLID, sl.DATE_1, sl.DN, sl.DS1_PR, p.DR, p.NPOLIS, usl.CODE_USL
from D3_SL_OMS sl
	left join D3_ZSL_OMS zsl on zsl.ID = sl.D3_ZSLID
	left join D3_PACIENT_OMS p on p.ID = zsl.D3_PID
	left join D3_USL_OMS usl on usl.D3_SLID = sl.ID
	join D3_SCHET_OMS sc on zsl.D3_SCID = sc.ID and sc.YEAR = @year and sc.CODE_MO = @codemo
where (sl.DS1 <> '') and (sl.D3_ZSLID <> '') and (sc.ID <> '')
	and floor(datediff(day, p.DR, sl.DATE_1) / 365.25) <= 3

select m.dsName, m.rowNum, m.ds,
	-- всего, ед
	count(distinct sl_zslid) as c4,
	-- до 1 года
	count(distinct case when floor(datediff(day, p_dr, sl_date_1) / 365.25) < 1 then sl_zslid end) as c5,
	-- 1-3
	count(distinct case when floor(datediff(day, p_dr, sl_date_1) / 365.25) between 1 and 3 then sl_zslid end) as c6,
	-- до 1 мес
	count(distinct case when datediff(day, p_dr, sl_date_1) < 30 then sl_zslid end) as c7,
	-- взято под дн (чел) - до 1 года
	count(distinct case when sl_dn = 2
		and floor(datediff(day, p_dr, sl_date_1) / 365.25) < 1 then t.p_npolis end) as c8,
	-- взято под дн (чел) - 1-3
	count(distinct case when sl_dn = 2
		and floor(datediff(day, p_dr, sl_date_1) / 365.25) between 1 and 3 then t.p_npolis end) as c9,
	-- впервые в жизни диагноз - до 1 года
	count(distinct case when sl_ds1_pr = 1
		and floor(datediff(day, p_dr, sl_date_1) / 365.25) < 1 then sl_zslid end) as c10,
	-- впервые в жизни диагноз - 1-3
	count(distinct case when sl_ds1_pr = 1
		and floor(datediff(day, p_dr, sl_date_1) / 365.25) between 1 and 3 then sl_zslid end) as c11,
	-- впервые в жизни диагноз - взято под дн (чел) - до 1 года
	count(distinct case when sl_ds1_pr = 1 and sl_dn = 2
		and floor(datediff(day, p_dr, sl_date_1) / 365.25) < 1 then sl_zslid end) as c12,
	-- впервые в жизни диагноз - взято под дн (чел) - 1-3
	count(distinct case when sl_ds1_pr = 1 and sl_dn = 2
		and floor(datediff(day, p_dr, sl_date_1) / 365.25) between 1 and 3 then sl_zslid end) as c13,
	-- впервые в жизни диагноз - профосмотр - до 1 года
	count(distinct case when sl_ds1_pr = 1
		and try_cast(usl_code_usl as int) in (4,6,10,11,19,20,26,80,81,3004,3010,3011,3019,3020,3026,3080,3081)
		and floor(datediff(day, p_dr, sl_date_1) / 365.25) < 1 then sl_zslid end) as c14,
	-- впервые в жизни диагноз - профосмотр - 1-3
	count(distinct case when sl_ds1_pr = 1
		and try_cast(usl_code_usl as int) in (4,6,10,11,19,20,26,80,81,3004,3010,3011,3019,3020,3026,3080,3081)
		and floor(datediff(day, p_dr, sl_date_1) / 365.25) between 1 and 3 then sl_zslid end) as c15,
	-- снято с дисп (чел) - до 1 года
	count(distinct case when sl_dn in (4,6)
		and floor(datediff(day, p_dr, sl_date_1) / 365.25) < 1 then t.p_npolis end) as c16,
	-- снято с дисп (чел) - 1-3
	count(distinct case when sl_dn in (4,6)
		and floor(datediff(day, p_dr, sl_date_1) / 365.25) between 1 and 3 then t.p_npolis end) as c17,
	-- состоит под дисп на конец года (чел) - до 1 года
	count(distinct case when sl_dn_max <= 2
		and floor(datediff(day, p_dr, sl_date_1) / 365.25) < 1 then t.p_npolis end) as c18,
	-- состоит под дисп на конец года (чел) - 1-3
	count(distinct case when sl_dn_max <= 2
		and floor(datediff(day, p_dr, sl_date_1) / 365.25) between 1 and 3 then t.p_npolis end) as c19
from @form m
	left join @tempTable t on
		sl_ds1 between m.dsFrom and m.dsTo or
		sl_ds1 like m.dsLike
	left join (select p_npolis, max(sl_dn) as sl_dn_max from @tempTable group by p_npolis) d
		on d.p_npolis = t.p_npolis
group by m.dsName, m.rowNum, m.ds
order by
	case when charindex('.', m.rowNum) = 0
		then m.rowNum
		else cast(substring(m.rowNum, 1, charindex('.', m.rowNum)-1) as int)
	end,
	case when charindex('.', m.rowNum, charindex('.', m.rowNum)+1) = 0
		then cast(substring(m.rowNum, charindex('.', m.rowNum)+1, len(m.rowNum)-charindex('.', m.rowNum)) as int)
		else substring(m.rowNum, charindex('.', m.rowNum)+1, charindex('.', m.rowNum, charindex('.', m.rowNum)+1)-charindex('.', m.rowNum)-1)
	end,
	case when charindex('.', m.rowNum, charindex('.', m.rowNum)+1) > 0 then
		substring(m.rowNum, charindex('.', m.rowNum, charindex('.', m.rowNum)+1)+1, len(m.rowNum)-charindex('.', m.rowNum, charindex('.', m.rowNum)+1))
	end