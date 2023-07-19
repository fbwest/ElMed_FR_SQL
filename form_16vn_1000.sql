declare @year int = 2022
declare @codemo int = 370024

declare @formT table (rowNumM nvarchar(10), rowNumW nvarchar(10), ds nvarchar(100), dsFrom nvarchar(10), dsTo nvarchar(10),
	dsLike nvarchar(100), dsName nvarchar(300))
insert into @formT values
	('01', '02', 'A00-B99', null, null, '[AB]%', N'Некоторые инфекционные и паразитарные болезни'),
	('03', '04', 'A15-A19', null, null, 'A1[5-9]%', N'из них:<br>туберкулез'),
	('05', '06', 'C00-D48', 'C00', 'D48.9', null, N'Новообразования'),
    ('07', '08', 'C00-C97', 'C00', 'C97.9', null, N'из них:<br>злокачественные новообразования'),
	('09', '10', 'D50-D89', 'D50', 'D89.9', null, N'Болезни крови, кроветворных органов и отдельные нарушения,' +
	                                              N'вовлекающие иммунный механизм'),
	('11', '12', 'E00-E89, E90', null, null, 'E%', N'Болезни эндокринной системы, расстройства питания и нарушения' +
	                                               N'обмена веществ'),
	('13', '14', 'E10-E14', null, null, 'E1[0-4]%', N'из них:<br>сахарный диабет'),
	('15', '16', 'F00-F99', null, null, 'F%', N'Психические расстройства и расстройства поведения'),
	('17', '18', 'G00-G98, G99', null, null, 'G%', N'Болезни нервной системы'),
	('19', '20', 'H00-H59', 'H00', 'H59.9', null, N'Болезни глаза и его придаточного аппарата'),
	('21', '22', 'H60-H95', 'H60', 'H95.9', null, N'Болезни уха и сосцевидного отростка'),
	('23', '24', 'I00-I99', null, null, 'I%', N'Болезни системы кровообращения'),
	('25', '26', 'I20-I25', null, null, 'I2[0-5]%', N'из них:<br>ишемические болезни сердца'),
	('27', '28', 'I60-I69', null, null, 'I6%', N'цереброваскулярные болезни'),
	('29', '30', 'J00-J98, J99', null, null, 'J%', N'Болезни органов дыхания'),
	('31', '32', 'J00,J01,J04,J05,J06', null, null, 'J0[01456]%', N'из них:<br>острые респираторные инфекции верхних' +
	                                                              N'дыхательных путей'),
	('33', '34', 'J09,J11', 'J09', 'J09.9', 'J11%', N'грипп'),
	('35', '36', 'J12-J18', null, null, 'J1[2-8]%', N'пневмония'),
	('37', '38', 'K00-K92, K93', null, null, 'K%', N'Болезни органов пищеварения'),
	('39', '40', 'L00-L99', null, null, 'L%', N'Болезни кожи и подкожной клетчатки'),
	('41', '42', 'M00-M99', null, null, 'M%', N'Болезни костно-мышечной системы и соединительной ткани'),
	('43', '44', 'N00-N99', null, null, 'N%', N'Болезни мочеполовой системы'),
	('45', '45', 'O00-O99', null, null, 'O%', N'Беременность, роды и послеродовой период'),
	('46', '47', 'Q00-Q99', null, null, 'Q%', N'Врожденные аномалии (пороки развития), деформации и хромосомные' +
	                                          N'нарушения'),
	('48', '49', 'S00-T98', null, null, '[ST]%', N'Травмы, отравления и некоторые другие последствия воздействия' +
	                                             N'внешних причин'),
	('50', '51', 'U07.1, U07.2', null, null, 'U07.[12]', N'COVID-19'),
    ('54', '54', 'O03-O08', null, null, 'O0[3-8]%', N'из них:<br>аборты (из стр. 45)')
    /*('55', '56', '', null, null, null, N'уход за больным'),
    ('57', '58', '', null, null, null, N'отпуск в связи с санаторно-курортным лечением (без туберкулеза и долечивания' +
                                 N'инфаркта миокарда)'),
    ('59', '60', '', null, null, null, N'освобождение от работы в связи с карантином и бактерионосительством'),
    ('61', '62', 'Z20.8,Z22.8,Z29.0', null, null, null, N'из них: в связи с карантином по COVID-19 (из стр. 59–60)'),
    ('63', '64', '', null, null, null, N'ИТОГО ПО ВСЕМ ПРИЧИНАМ'),
    ('65', '65', '', null, null, null, N'Отпуск по беременности и родам')*/

declare @sampleT table (DS1 nvarchar(10), ID int, DATE_Z_1 datetime, DATE_Z_2 datetime, DR datetime, W int)
insert into @sampleT
	select sl.DS1, zsl.ID, zsl.DATE_Z_1, zsl.DATE_Z_2, p.DR, p.W
	from D3_SL_OMS sl
		left join D3_ZSL_OMS zsl on zsl.ID = sl.D3_ZSLID
		left join D3_PACIENT_OMS p on p.ID = zsl.D3_PID
		join D3_SCHET_OMS sc on zsl.D3_SCID = sc.ID --and sc.YEAR = @year and sc.CODE_MO = @codemo
	where sl.DS1 <> '' and sl.D3_ZSLID <> '' and sc.ID <> ''

declare @result table (dsName nvarchar(300), rowNumM nvarchar(10), rowNumW nvarchar(10), ds nvarchar(100),
    m5 int, w5 int, m6 int, w6 int, m7 int, w7 int, m8 int, w8 int, m9 int, w9 int, m10 int, w10 int,
    m11 int, w11 int, m12 int, w12 int, m13 int, w13 int, m14 int, w14 int, m15 int, w15 int, m16 int, w16 int)
insert into @result
    select dsName, rowNumM, rowNumW, ds,
        sum(iif(W = 1, datediff(day, DATE_Z_1, DATE_Z_2) + 1, 0)) as m5,
        sum(iif(W = 2, datediff(day, DATE_Z_1, DATE_Z_2) + 1, 0)) as w5,
        count(distinct iif(W = 1, ID, null)) as m6,
        count(distinct iif(W = 2, ID, null)) as w6,
        count(distinct iif(W = 1 and floor(datediff(day, DR, DATE_Z_1) / 365.25) between 15 and 19, ID, null)) as m7,
        count(distinct iif(W = 2 and floor(datediff(day, DR, DATE_Z_1) / 365.25) between 15 and 19, ID, null)) as w7,
        count(distinct iif(W = 1 and floor(datediff(day, DR, DATE_Z_1) / 365.25) between 20 and 24, ID, null)) as m8,
        count(distinct iif(W = 2 and floor(datediff(day, DR, DATE_Z_1) / 365.25) between 20 and 24, ID, null)) as w8,
        count(distinct iif(W = 1 and floor(datediff(day, DR, DATE_Z_1) / 365.25) between 25 and 29, ID, null)) as m9,
        count(distinct iif(W = 2 and floor(datediff(day, DR, DATE_Z_1) / 365.25) between 25 and 29, ID, null)) as w9,
        count(distinct iif(W = 1 and floor(datediff(day, DR, DATE_Z_1) / 365.25) between 30 and 34, ID, null)) as m10,
        count(distinct iif(W = 2 and floor(datediff(day, DR, DATE_Z_1) / 365.25) between 30 and 34, ID, null)) as w10,
        count(distinct iif(W = 1 and floor(datediff(day, DR, DATE_Z_1) / 365.25) between 35 and 39, ID, null)) as m11,
        count(distinct iif(W = 2 and floor(datediff(day, DR, DATE_Z_1) / 365.25) between 35 and 39, ID, null)) as w11,
        count(distinct iif(W = 1 and floor(datediff(day, DR, DATE_Z_1) / 365.25) between 40 and 44, ID, null)) as m12,
        count(distinct iif(W = 2 and floor(datediff(day, DR, DATE_Z_1) / 365.25) between 40 and 44, ID, null)) as w12,
        count(distinct iif(W = 1 and floor(datediff(day, DR, DATE_Z_1) / 365.25) between 45 and 49, ID, null)) as m13,
        count(distinct iif(W = 2 and floor(datediff(day, DR, DATE_Z_1) / 365.25) between 45 and 49, ID, null)) as w13,
        count(distinct iif(W = 1 and floor(datediff(day, DR, DATE_Z_1) / 365.25) between 50 and 54, ID, null)) as m14,
        count(distinct iif(W = 2 and floor(datediff(day, DR, DATE_Z_1) / 365.25) between 50 and 54, ID, null)) as w14,
        count(distinct iif(W = 1 and floor(datediff(day, DR, DATE_Z_1) / 365.25) between 55 and 59, ID, null)) as m15,
        count(distinct iif(W = 2 and floor(datediff(day, DR, DATE_Z_1) / 365.25) between 55 and 59, ID, null)) as w15,
        count(distinct iif(W = 1 and floor(datediff(day, DR, DATE_Z_1) / 365.25) >= 60, ID, null)) as m16,
        count(distinct iif(W = 2 and floor(datediff(day, DR, DATE_Z_1) / 365.25) >= 60, ID, null)) as w16
    from @formT	left join @sampleT on DS1 between dsFrom and dsTo or DS1 like dsLike
    group by dsName, rowNumM, rowNumW, ds

insert into @result
    select N'Всего по заболеваниям', '52', '53', N'(стр. 01-50)<br>(стр. 02-51)',
           sum(iif(rowNumM in (01,05,09,11,15,17,19,21,23,29,37,39,41,43,46,48,50), m5, 0)),
           sum(iif(rowNumW in (02,06,10,12,16,18,20,22,24,30,38,40,42,44,45,47,49,51), w5, 0)),
           sum(iif(rowNumM in (01,05,09,11,15,17,19,21,23,29,37,39,41,43,46,48,50), m6, 0)),
           sum(iif(rowNumW in (02,06,10,12,16,18,20,22,24,30,38,40,42,44,45,47,49,51), w6, 0)),
           sum(iif(rowNumM in (01,05,09,11,15,17,19,21,23,29,37,39,41,43,46,48,50), m7, 0)),
           sum(iif(rowNumW in (02,06,10,12,16,18,20,22,24,30,38,40,42,44,45,47,49,51), w7, 0)),
           sum(iif(rowNumM in (01,05,09,11,15,17,19,21,23,29,37,39,41,43,46,48,50), m8, 0)),
           sum(iif(rowNumW in (02,06,10,12,16,18,20,22,24,30,38,40,42,44,45,47,49,51), w8, 0)),
           sum(iif(rowNumM in (01,05,09,11,15,17,19,21,23,29,37,39,41,43,46,48,50), m9, 0)),
           sum(iif(rowNumW in (02,06,10,12,16,18,20,22,24,30,38,40,42,44,45,47,49,51), w9, 0)),
           sum(iif(rowNumM in (01,05,09,11,15,17,19,21,23,29,37,39,41,43,46,48,50), m10, 0)),
           sum(iif(rowNumW in (02,06,10,12,16,18,20,22,24,30,38,40,42,44,45,47,49,51), w10, 0)),
           sum(iif(rowNumM in (01,05,09,11,15,17,19,21,23,29,37,39,41,43,46,48,50), m11, 0)),
           sum(iif(rowNumW in (02,06,10,12,16,18,20,22,24,30,38,40,42,44,45,47,49,51), w11, 0)),
           sum(iif(rowNumM in (01,05,09,11,15,17,19,21,23,29,37,39,41,43,46,48,50), m12, 0)),
           sum(iif(rowNumW in (02,06,10,12,16,18,20,22,24,30,38,40,42,44,45,47,49,51), w12, 0)),
           sum(iif(rowNumM in (01,05,09,11,15,17,19,21,23,29,37,39,41,43,46,48,50), m13, 0)),
           sum(iif(rowNumW in (02,06,10,12,16,18,20,22,24,30,38,40,42,44,45,47,49,51), w13, 0)),
           sum(iif(rowNumM in (01,05,09,11,15,17,19,21,23,29,37,39,41,43,46,48,50), m14, 0)),
           sum(iif(rowNumW in (02,06,10,12,16,18,20,22,24,30,38,40,42,44,45,47,49,51), w14, 0)),
           sum(iif(rowNumM in (01,05,09,11,15,17,19,21,23,29,37,39,41,43,46,48,50), m15, 0)),
           sum(iif(rowNumW in (02,06,10,12,16,18,20,22,24,30,38,40,42,44,45,47,49,51), w15, 0)),
           sum(iif(rowNumM in (01,05,09,11,15,17,19,21,23,29,37,39,41,43,46,48,50), m16, 0)),
           sum(iif(rowNumW in (02,06,10,12,16,18,20,22,24,30,38,40,42,44,45,47,49,51), w16, 0))
    from @result

select * from @result
order by cast(rowNumM as int)