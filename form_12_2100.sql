declare @year int = 2022
declare @codemo int = 370024

-- form 12 2100 --
declare @form table (rowNum nvarchar(10), ds nvarchar(100), dsFrom nvarchar(10),
	dsTo nvarchar(10),dsLike nvarchar(100), dsName nvarchar(300))
insert into @form values
	('1.0', 'Z00-Z99', null, null, 'Z%', N'<b>Всего</b>'),
	('1.1', 'Z00-Z13', 'Z00', 'Z13.9', null, N'из них:<br>обращения в медицинские организации для медицинского' +
	                                         N'осмотра и обследования некоторые инфекционные и паразитарные болезни'),
	('1.1.1', 'Z02.7', null, null, 'Z02.7', N'из них:<br>обращения в связи с получением медицинских документов'),
	('1.1.2', 'Z03.8', null, null, 'Z03.8', N'наблюдение при подозрении на COVID-19'),
	('1.1.3', 'Z11.5', null, null, 'Z11.5', N'скрининговое обследование с целью выявления COVID-19'),
	('1.2', 'Z20-Z29', null, null, 'Z2[0-9]%', N'потенциальная опасность для здоровья, связанная с инфекционными' +
	                                           N'болезнями'),
	('1.2.1', 'Z20.8', null, null, 'Z20.8', N'из них:<br>контакт с больным COVID-19'),
	('1.2.2', 'Z22', null, null, 'Z22%', N'носительство возбудителя инфекционной болезни'),
	('1.2.3', 'Z22.8', null, null, 'Z22.8', N'из них носительство возбудителя COVID-19'),
	('1.4', 'Z40-Z54', 'Z40', 'Z54.9', null, N'обращения в медицинские организации в связи с необходимостью' +
	                                         N'проведения специфических процедур и получения медицинской помощи'),
	('1.4.1', 'Z50', null, null, 'Z50%', N'из них:<br>помощь, включающая использование реабилитационных процедур'),
	('1.4.2', 'Z51.5', null, null, 'Z51.5', N'паллиативная помощь'),
	('1.5', 'Z55-Z65', 'Z55', 'Z65.9', null, N'потенциальная опасность для здоровья, связанная с социально-' +
	                                         N'экономическими и психосоциальными обстоятельствами'),
	('1.6', 'Z70-Z76', null, null, 'Z7[0-6]%', N'обращения в медицинские организации в связи с другими' +
	                                           N'обстоятельствами'),
	('1.6.1', 'Z72', null, null, 'Z72%', N'из них:<br>проблемы, связанные с образом жизни'),
	('1.7', 'Z80-Z99', 'Z80', 'Z99.9', null, N'потенциальная опасность для здоровья, связанная с личным или семейным' +
	                                         N'анамнезом и определенными обстоятельствами, влияющими на здоровье'),
	('1.7.1', 'Z80-Z84', null, null, 'Z8[0-4]%', N'из них:<br>заболевания в семейном анамнезе'),
	('1.7.1.1', 'Z82.2', null, null, 'Z82.2', N'из них:<br>глухота и потеря слуха'),
	('1.7.2', 'Z93.2, Z93.3', null, null, 'Z93.[23]', N'наличие илеостомы, колостомы');

declare @tempTable table (DS1 nvarchar(10), ZSLID int, DS1_PR int)
insert into @tempTable
    select sl.DS1, sl.D3_ZSLID, sl.DS1_PR
    from D3_SL_OMS sl
        left join D3_ZSL_OMS zsl on zsl.ID = sl.D3_ZSLID
        left join D3_PACIENT_OMS p on p.ID = zsl.D3_PID
        join D3_SCHET_OMS sc on zsl.D3_SCID = sc.ID and sc.YEAR = @year and sc.CODE_MO = @codemo
    where (sl.DS1 <> '') and (sl.D3_ZSLID <> '') and (sc.ID <> '')
	    and floor(datediff(day, p.DR, sl.DATE_1) / 365.25) between 15 and 17

select m.dsName, m.rowNum, m.ds,
	count(distinct ZSLID) as c4,
	count(distinct case when DS1_PR != 1 then ZSLID end) as c5
from @form m
	left join @tempTable t on
		DS1 between m.dsFrom and m.dsTo
		or DS1 like m.dsLike
group by m.dsName, m.rowNum, m.ds
order by cast('/'+replace(rowNum,'.','/')+'/' as hierarchyid)