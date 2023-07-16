declare @year int = 2022
declare @codemo int = 370024

use Elmedicine_Ivanovo

declare @formT table (rowNum nvarchar(10), ds nvarchar(100), dsFrom nvarchar(10), dsTo nvarchar(10),
	dsLike nvarchar(100), dsName nvarchar(300))
insert into @formT values
	('1', 'Е10-Е11, E13-E14', null, null, 'E1[0134]%', 'сахарный диабет (из стр. 5.4)'),
	('2', 'I10, I11.9, I12.9, I13.9', 'I10', 'I10.9', 'I1[123].9', 'болезни, характеризующиеся повышенным кровяным давлением (из стр. 10.3)'),
	('3', 'I25', null, null, 'I25%', 'хроническая ишемическая болезнь сердца (стр. 10.4.5)'),
	('4', 'J40-J43', null, null, 'J4[0-3]%', 'бронхит хронический и неуточненный, эмфизема (стр. 11.7)'),
	('5', 'J44', null, null, 'J44%', 'другая хроническая обструктивная легочная болезнь (стр. 11.8)'),
	('6', 'J47', null, null, 'J47%', 'бронхоэктатическая болезнь (стр. 11.9)'),
	('7', 'J45, J46', null, null, 'J4[56]%', 'астма, астматический статус (стр. 11.10)')

declare @sampleT table (DS1 nvarchar(10), NPOLIS nvarchar(20), DR datetime, DATE_1 datetime) 
insert into @sampleT
	select sl.DS1, p.NPOLIS, p.DR, sl.DATE_1
	from D3_SL_OMS sl
		left join D3_ZSL_OMS zsl on zsl.ID = sl.D3_ZSLID
		left join D3_PACIENT_OMS p on p.ID = zsl.D3_PID
		join D3_SCHET_OMS sc on zsl.D3_SCID = sc.ID and sc.YEAR = @year and sc.CODE_MO = @codemo
	where sl.DS1 <> '' and sl.D3_ZSLID <> '' and sc.ID <> ''
		and zsl.USL_OK = 1
		and zsl.RSLT in (105,106,205,206,313,405,406,411)

select dsName, rowNum, ds,
	count(distinct case when floor(datediff(day, DR, DATE_1) / 365.25) <= 14 then NPOLIS end) as c4,
	count(distinct case when floor(datediff(day, DR, DATE_1) / 365.25) between 15 and 19 then NPOLIS end) as c5,
	count(distinct case when floor(datediff(day, DR, DATE_1) / 365.25) between 20 and 24 then NPOLIS end) as c6,
	count(distinct case when floor(datediff(day, DR, DATE_1) / 365.25) between 25 and 29 then NPOLIS end) as c7,
	count(distinct case when floor(datediff(day, DR, DATE_1) / 365.25) between 30 and 34 then NPOLIS end) as c8,
	count(distinct case when floor(datediff(day, DR, DATE_1) / 365.25) between 35 and 39 then NPOLIS end) as c9,
	count(distinct case when floor(datediff(day, DR, DATE_1) / 365.25) between 40 and 44 then NPOLIS end) as c10,
	count(distinct case when floor(datediff(day, DR, DATE_1) / 365.25) between 45 and 49 then NPOLIS end) as c11,
	count(distinct case when floor(datediff(day, DR, DATE_1) / 365.25) between 50 and 54 then NPOLIS end) as c12,
	count(distinct case when floor(datediff(day, DR, DATE_1) / 365.25) between 55 and 59 then NPOLIS end) as c13,
	count(distinct case when floor(datediff(day, DR, DATE_1) / 365.25) between 60 and 64 then NPOLIS end) as c14,
	count(distinct case when floor(datediff(day, DR, DATE_1) / 365.25) between 65 and 69 then NPOLIS end) as c15,
	count(distinct case when floor(datediff(day, DR, DATE_1) / 365.25) between 70 and 74 then NPOLIS end) as c16,
	count(distinct case when floor(datediff(day, DR, DATE_1) / 365.25) between 75 and 79 then NPOLIS end) as c17,
	count(distinct case when floor(datediff(day, DR, DATE_1) / 365.25) between 80 and 84 then NPOLIS end) as c18,
	count(distinct case when floor(datediff(day, DR, DATE_1) / 365.25) >= 85 then NPOLIS end) as c19
from @formT	left join @sampleT on DS1 between dsFrom and dsTo or DS1 like dsLike
group by dsName, rowNum, ds
order by cast(rowNum as int)