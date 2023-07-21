﻿declare @year int = 2022
declare @codemo int = 370024

declare @formT table (rowNum nvarchar(10), profil_name nvarchar(200), profil_id int, child int)
insert into @formT values
	('2', N'из них:<br>аллергологические для взрослых', 9, 0),
	('3', N'аллергологические для детей', 9, 1),
	('6', N'гинекологические для взрослых', 6, 0),
	('6.1', N'из них: гинекологические для вспомогательных репродуктивных технологий', 8, 0),
	('7', N'гинекологические для детей', 7, 1),
	('8', N'гастроэнтерологические для взрослых', 14, 0),
	('9', N'гастроэнтерологические для детей', 14, 1),
	('10', N'гематологические для взрослых', 15, 0),
	('11', N'гематологические для детей', 15, 1),
	('12', N'геронтологические', 16, null),
	('13', N'дерматологические для взрослых', 17, 0),
	('14', N'дерматологические для детей', 17, 1),
	('15', N'венерологические для взрослых', 18, 0),
	('16', N'венерологические для детей', 18, 1),
	('17', N'инфекционные для взрослых', 24, 0),
	('18', N'инфекционные для детей', 24, 1),
	('19', N'кардиологические для взрослых', 26, 0),
	('20', N'кардиологические для детей', 19, 1),
	('21', N'наркологические', 62, null),
	('22', N'неврологические для взрослых', 34, 0),
	('23', N'неврологические для детей', 34, 1),
	('23.1', N'из них:<br>психоневрологические для детей', 37, 1),
	('24', N'нефрологические для взрослых', 41, 0),
	('25', N'нефрологические для детей', 41, 1),
	('26', N'онкологические для взрослых', 42, 0),
	('26.1', N'из них:<br>онкологические торакальные', 43, 0),
	('26.2', N'онкологические абдоминальные', 44, 0),
	('26.3', N'онкоурологические', 45, 0),
	('26.4', N'онкогинекологические', 46, 0),
	('26.5', N'онкологические опухолей головы и шеи', 47, 0),
	('26.6', N'онкологические опухолей костей, кожи и мягких тканей', 48, 0),
	('26.7', N'онкологические паллиативные', 49, 0),
	('27', N'онкологические для детей', 20, 1),
	('28', N'оториноларингологические для взрослых', 50, 0),
	('29', N'оториноларингологические для детей', 50, 1),
	('30', N'офтальмологические для взрослых', 52, 0),
	('31', N'офтальмологические для детей', 52, 1),
	('32', N'ожоговые', 82, null),
	('33', N'паллиативные для взрослых', 53, 0),
	('34', N'паллиативные для детей', 53, 1),
	('35', N'педиатрические соматические', 55, null),
	('36', N'проктологические', 29, null),
	('37', N'психиатрические для взрослых', 58, 0),
	('37.1', N'из них:<br>психосоматические', 59, 0),
	('37.2', N'соматопсихиатрические', 60, 0),
	('38', N'психиатрические для детей', 37, 1),
	('39', N'профпатологические', 57, null),
	('40', N'пульмонологические для взрослых', 63, 0),
	('41', N'пульмонологические для детей', 63, 1),
	('42', N'радиологические', 64, null),
	('43', N'реабилитационные соматические для взрослых', 30, 0),
	('43.1', N'из них:<br>реабилитационные для больных с заболеваниями центральной нервной системы и органов' +
	         N'чувств', 31, 0),
	('43.2', N'реабилитационные для больных с заболеваниями опорно-двигательного аппарата и периферической нервной' +
	         N'системы', 32, 0),
	('43.3', N'реабилитационные для наркологических больных', 33, 0),
	('44', N'реабилитационные соматические для детей', 30, 1),
	('46', N'ревматологические для взрослых', 65, 0),
	('47', N'ревматологические для детей', 65, 1),
	('49', N'скорой медицинской помощи краткосрочного пребывания', 68, null),
	('50', N'скорой медицинской помощи суточного пребывания', 69, null),
	('51', N'терапевтические', 71, null),
	('52', N'токсикологические', 72, null),
	('53', N'травматологические для взрослых', 74, 0),
	('54', N'травматологические для детей', 74, 1),
	('55', N'ортопедические для взрослых', 75, 0),
	('56', N'ортопедические для детей', 75, 1),
	('57', N'туберкулезные для взрослых', 78, 0),
	('58', N'туберкулезные для детей', 78, 1),
	('59', N'урологические для взрослых', 77, 0),
	('60', N'урологические для детей', 77, 1),
	('60.1', N'из них:<br>уроандрологические для детей', 21, 1),
	('61', N'хирургические для взрослых', 80, 0),
	('62', N'абдоминальной хирургии', 81, null),
	('63', N'хирургические для детей', 22, 1),
	('64', N'нейрохирургические для взрослых', 38, 0),
	('65', N'нейрохирургические для детей', 38, 1),
	('66', N'торакальной хирургии для взрослых', 73, 0),
	('67', N'торакальной хирургии для детей', 73, 1),
	('68', N'кардиохирургические', 66, null),
	('69', N'сосудистой хирургии', 67, null),
	('70', N'хирургические гнойные для взрослых', 79, 0),
	('71', N'хирургические гнойные для детей', 79, 1),
	('72', N'челюстно-лицевой хирургии', 84, null),
	('73', N'стоматологические для детей', 70, 1),
	('74', N'эндокринологические для взрослых', 85, 0),
	('75', N'эндокринологические для детей', 23, 1),
	('76', N'из общего числа (из стр.1), в медицинских организациях, расположенных в сельской местности', null, null)

declare @sampleT table (RSLT int, DET int, DR datetime, DATE_1 datetime, KD int, NPOLIS nvarchar(20), PROFIL_K int)
insert into @sampleT
	select zsl.RSLT, sl.DET, p.DR, sl.DATE_1, sl.KD, p.NPOLIS, sl.PROFIL_K
	from D3_SL_OMS sl
		left join D3_ZSL_OMS zsl on zsl.ID = sl.D3_ZSLID
		left join D3_PACIENT_OMS p on p.ID = zsl.D3_PID
	    left join OtdelDb otd on sl.PODR = OTDID_REGION_NOTEDIT
		join D3_SCHET_OMS sc on zsl.D3_SCID = sc.ID and sc.YEAR = @year and sc.CODE_MO = @codemo
	where sl.DS1 <> '' and sl.D3_ZSLID <> '' and sc.ID <> ''
		and PodrID in (202,203,205,206,207,208,209,210)

declare @form_sampleT table (rowNum nvarchar(10), profil_name nvarchar(200),
	RSLT int, DET int, DR datetime, DATE_1 datetime, KD int, NPOLIS nvarchar(20))
insert into @form_sampleT
	select rowNum, profil_name, RSLT, s.DET, DR, DATE_1, KD, NPOLIS
	from @formT f
		left join @sampleT s on PROFIL_K = f.profil_id
			and ((child is null)
			or (child = 1 and floor(datediff(day, DR, DATE_1) / 365.25) < 18)
			or (child = 0 and floor(datediff(day, DR, DATE_1) / 365.25) >= 18))
	union all
	select '4', N'для беременных и рожениц',
           null,null,null,null,null,null
	union all
	select '4', N'для беременных и рожениц', RSLT, DET, DR, DATE_1, KD, NPOLIS
	from @sampleT where PROFIL_K in (1, 4)
	union all
	select '5', N'для патологии беременности',
           null,null,null,null,null,null
	union all
	select '5', N'для патологии беременности', RSLT, DET, DR, DATE_1, KD, NPOLIS
	from @sampleT where PROFIL_K in (2, 5)
	union all
	select '48', N'сестринского ухода',
           null,null,null,null,null,null
	union all
	select '48', N'сестринского ухода', RSLT, DET, DR, DATE_1, KD, NPOLIS
	from @sampleT where PROFIL_K in (3, 54)

declare @result table (rowNum nvarchar(10), profil_name nvarchar(200),
	c7 int, c8 int, c9 int, c10 int, c11 int, c12 int, c13 int, c14 int)
insert into @result
    select rowNum, profil_name,
        -- c3, c4, c5, c6
        count(distinct case when RSLT in (101,201) and floor(datediff(day, DR, DATE_1) / 365.25) >= 18 then NPOLIS end),
        count(distinct case when RSLT in (101,201) and floor(datediff(day, DR, DATE_1) / 365.25) > 60 then NPOLIS end),
        count(distinct case when RSLT in (101,201) and floor(datediff(day, DR, DATE_1) / 365.25) <= 17 then NPOLIS end),
        count(distinct case when RSLT in (101,201) and floor(datediff(day, DR, DATE_1) / 365.25) <= 3 then NPOLIS end),
        sum(iif(floor(datediff(day, DR, DATE_1) / 365.25) >= 18, KD, 0)),
        sum(iif(floor(datediff(day, DR, DATE_1) / 365.25) > 60, KD, 0)),
        sum(iif(floor(datediff(day, DR, DATE_1) / 365.25) <= 17, KD, 0)),
        sum(iif(floor(datediff(day, DR, DATE_1) / 365.25) <= 3, KD, 0))
    from @form_sampleT
    group by rowNum, profil_name

insert into @result
select '1', N'Всего',
       sum(c7), sum(c8), sum(c9), sum(c10), sum(c11), sum(c12), sum(c13), sum(c14)
from @result
where charindex('.', rowNum) = 0

select * from @result
order by cast('/'+replace(rowNum,'.','/')+'/' as hierarchyid)