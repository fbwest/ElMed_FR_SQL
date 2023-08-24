declare @year int = 2022
declare @codemo int = 370024

declare @formT table (rowNum nvarchar(5), ds nvarchar(30), dsLike nvarchar(20), dsName nvarchar(100), id int)
insert into @formT values
    ('02', 'A50-A53', 'A5[0-3]%', N'в том числе: мужчины<br>женщины', 1),
    ('04', 'A50.0-A50.9', 'A50%', N'в том числе:<br><b>врожденный сифилис</b>', 1),
    ('06', 'A50.0', 'A50.0', N'в том числе: сифилис ранний врожденный с симптомами', 1),
    ('08', 'A50.1', 'A50.1', N'сифилис ранний врожденный скрытый', 1),
    ('10', 'A50.3-A50.6', 'A50.[3-6]', N'сифилис поздний врожденный', 1),
    ('12', 'A50.2, A50.7, A50.9', 'A50.[279]', N'сифилис врожденный неуточненный', 1),
    ('14', '<b>A51.0-A51.9</b>', 'A51%', N'<b>ранний сифилис</b>', 1),
    ('16', 'A51.0-A51.2', 'A51.[0-2]', N'из них: первичный сифилис', 1),
    ('18', 'A51.3-A51.4', 'A51.[34]', N'вторичный сифилис', 1),
    ('20', 'A51.3', 'A51.3', N'из них: сифилис кожи и слизистых оболочек', 1),
    ('22', 'A51.4', 'A51.4', N'другие формы вторичного сифилиса', 1),
    ('24', 'A51.4', 'A51.4', N'из них: ранний нейросифилис', 1),
    ('26', 'A51.5', 'A51.5', N'сифилис ранний скрытый', 1),
    ('28', 'A51.9', 'A51.9', N'сифилис ранний неуточненный', 1),
    ('30', '<b>A52.0-A52.9</b>', 'A52%', N'<b>поздний сифилис</b>', 1),
    ('32', 'A52.0', 'A52.0', N'из них: сифилис сердечно-сосудистой системы', 1),
    ('34', 'A52.1-A52.3', 'A52.[1-3]', N'поздний нейросифилис', 1),
    ('36', 'A52.7', 'A52.7', N'другие симптомы позднего сифилиса', 1),
    ('38', 'A52.8', 'A52.8', N'сифилис поздний скрытый', 1),
    ('40', 'A52.9', 'A52.9', N'сифилис поздний неуточненный', 1),
    ('42', '<b>A53.0, A53.9</b>', 'A53.[09]', N'<b>другие и неуточненные формы сифилиса</b>', 1),
    ('44', 'A53.0', 'A53.0', N'из них: скрытый, неуточненный как ранний или поздний сифилис', 1),
    ('46', 'A53.9', 'A53.9', N'сифилис неуточненный', 1),
    ('49', 'A54.0-A54.9', 'A54%', N'в том числе: мужчины<br>женщины', 2),
    ('51', 'A54.1-A54.2, A54.8-A54.9', 'A54.[1289]', N'в том числе:<br>осложненная', 2),
    ('53', 'A54.3', 'A54.3', N'гонококковая инфекция глаз', 2),
    ('56', 'A59.0, A59.8, A59.9', 'A59.[089]', N'в том числе: мужчины<br>женщины', 3),
    ('59', 'A56.0, A56.4, A56.8', 'A56.[048]', N'в том числе: мужчины<br>женщины', 4),
    ('62', 'A60.0, A60.1, A60.9', 'A60.[019]', N'в том числе: мужчины<br>женщины', 5),
    ('65', 'A63.0', 'A63.0', N'в том числе: мужчины<br>женщины', 6)

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
    count(distinct iif(W = 1 and KOD_TER = 2, NPOLIS, null)) as m12,
    count(distinct iif(W = 2 and KOD_TER = 2, NPOLIS, null)) as w12,
    count(distinct iif(W = 1 and KOD_TER = 2
                           and floor(datediff(day, DR, DATE_Z_1) / 365.25) <= 1, NPOLIS, null)) as m13,
    count(distinct iif(W = 2 and KOD_TER = 2
                           and floor(datediff(day, DR, DATE_Z_1) / 365.25) <= 1, NPOLIS, null)) as w13,
    count(distinct iif(W = 1 and KOD_TER = 2
                           and floor(datediff(day, DR, DATE_Z_1) / 365.25) between 2 and 14, NPOLIS, null)) as m14,
    count(distinct iif(W = 2 and KOD_TER = 2
                           and floor(datediff(day, DR, DATE_Z_1) / 365.25) between 2 and 14, NPOLIS, null)) as w14,
    count(distinct iif(W = 1 and KOD_TER = 2
                           and floor(datediff(day, DR, DATE_Z_1) / 365.25) between 15 and 17, NPOLIS, null)) as m15,
    count(distinct iif(W = 2 and KOD_TER = 2
                           and floor(datediff(day, DR, DATE_Z_1) / 365.25) between 15 and 17, NPOLIS, null)) as w15
from @formT	f left join @sampleT on DS1 like dsLike
group by dsName, rowNum, ds, id
order by rowNum