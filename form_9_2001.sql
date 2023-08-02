declare @year int = 2022
declare @codemo int = 370024

declare @formT table (rowNum nvarchar(5), ds nvarchar(30), dsLike nvarchar(20), dsName nvarchar(100), id int)
insert into @formT values
    ('02', 'B35.0-B35.9', 'B35%', N'в том числе: мужчины<br>женщины', 1),
    ('04', 'B35.0,4', 'B35.[04]', N'из них: микроспории', 1),
    ('06', 'B35.0,4', 'B35.[04]', N'трихофитии', 1),
    ('09', 'B35.1-3', 'B35.[1-3]', N'в том числе: мужчины<br>женщины', 2),
    ('11', 'B35.1', 'B35.1', N'из них онихомикозы', 2),
    ('14', 'B86', 'B86%', N'в том числе: мужчины<br>женщины', 3)

declare @sampleT table (DS1 nvarchar(10), DATE_Z_1 datetime, DR datetime, W int, KOD_TER int, NPOLIS nvarchar(20))
insert into @sampleT
	select sl.DS1, zsl.DATE_Z_1, p.DR, p.W, p.KOD_TER, p.NPOLIS
	from D3_SL_OMS sl
		left join D3_ZSL_OMS zsl on zsl.ID = sl.D3_ZSLID
		left join D3_PACIENT_OMS p on p.ID = zsl.D3_PID
		join D3_SCHET_OMS sc on zsl.D3_SCID = sc.ID and sc.YEAR = @year and sc.CODE_MO = @codemo
	where sl.DS1 <> '' and sl.D3_ZSLID <> '' and sc.ID <> ''
        and sl.DS1_PR <> 1 or sl.DS1_PR is null

select dsName, rowNum, ds, id,
    count(distinct iif(W = 1, NPOLIS, null)) as m5,
    count(distinct iif(W = 2, NPOLIS, null)) as w5,
    count(distinct iif(W = 1 and floor(datediff(day, DR, DATE_Z_1) / 365.25) <= 1, NPOLIS, null)) as m6,
    count(distinct iif(W = 2 and floor(datediff(day, DR, DATE_Z_1) / 365.25) <= 1, NPOLIS, null)) as w6,
    count(distinct iif(W = 1 and floor(datediff(day, DR, DATE_Z_1) / 365.25) between 2 and 14, NPOLIS, null)) as m7,
    count(distinct iif(W = 2 and floor(datediff(day, DR, DATE_Z_1) / 365.25) between 2 and 14, NPOLIS, null)) as w7,
    count(distinct iif(W = 1 and floor(datediff(day, DR, DATE_Z_1) / 365.25) between 15 and 17, NPOLIS, null)) as m8,
    count(distinct iif(W = 2 and floor(datediff(day, DR, DATE_Z_1) / 365.25) between 15 and 17, NPOLIS, null)) as w8,
    count(distinct iif(W = 1 and floor(datediff(day, DR, DATE_Z_1) / 365.25) between 18 and 29, NPOLIS, null)) as m9,
    count(distinct iif(W = 2 and floor(datediff(day, DR, DATE_Z_1) / 365.25) between 18 and 29, NPOLIS, null)) as w9,
    count(distinct iif(W = 1 and floor(datediff(day, DR, DATE_Z_1) / 365.25) between 30 and 39, NPOLIS, null)) as m10,
    count(distinct iif(W = 2 and floor(datediff(day, DR, DATE_Z_1) / 365.25) between 30 and 39, NPOLIS, null)) as w10,
    count(distinct iif(W = 1 and floor(datediff(day, DR, DATE_Z_1) / 365.25) >= 40, NPOLIS, null)) as m11,
    count(distinct iif(W = 2 and floor(datediff(day, DR, DATE_Z_1) / 365.25) >= 40, NPOLIS, null)) as w11,
    count(distinct iif(W = 1 and KOD_TER <> '', NPOLIS, null)) as m12,
    count(distinct iif(W = 2 and KOD_TER <> '', NPOLIS, null)) as w12,
    count(distinct iif(W = 1 and KOD_TER <> ''
                           and floor(datediff(day, DR, DATE_Z_1) / 365.25) <= 1, NPOLIS, null)) as m13,
    count(distinct iif(W = 2 and KOD_TER <> ''
                           and floor(datediff(day, DR, DATE_Z_1) / 365.25) <= 1, NPOLIS, null)) as w13,
    count(distinct iif(W = 1 and KOD_TER <> ''
                           and floor(datediff(day, DR, DATE_Z_1) / 365.25) between 2 and 14, NPOLIS, null)) as m14,
    count(distinct iif(W = 2 and KOD_TER <> ''
                           and floor(datediff(day, DR, DATE_Z_1) / 365.25) between 2 and 14, NPOLIS, null)) as w14,
    count(distinct iif(W = 1 and KOD_TER <> ''
                           and floor(datediff(day, DR, DATE_Z_1) / 365.25) between 15 and 17, NPOLIS, null)) as m15,
    count(distinct iif(W = 2 and KOD_TER <> ''
                           and floor(datediff(day, DR, DATE_Z_1) / 365.25) between 15 and 17, NPOLIS, null)) as w15
from @formT	f left join @sampleT on DS1 like dsLike
group by dsName, rowNum, ds, id
order by rowNum