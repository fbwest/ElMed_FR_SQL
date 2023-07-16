declare @year int = 2022
declare @codemo int = 370024

use Elmedicine_Ivanovo

declare @formT table (rowNum nvarchar(10), ds nvarchar(100), dsFrom nvarchar(10), dsTo nvarchar(10),
	dsLike nvarchar(100), dsName nvarchar(300))
insert into @formT values
	('1', '', null, null, '%', '<b>Всего новорожденных с заболеваниями</b><br>в том числе с заболеваниями:'),
	('2', 'J00-J06, J09-J11', 'J09', 'J11.9', 'J0[0-6]%', '<b>острые респираторные инфекции верхних дыхательных путей, грипп</b>'),
	('3', 'J12-J18', null, null, 'J1[2-8]%', '<b>пневмонии</b>'),
	('4', 'L00-L08', null, null, 'L0[0-8]%', '<b>инфекции кожи и подкожной клетчатки</b>'),
	('5', 'P05-P96', 'P05', 'P96.9', null, '<b>отдельные состояния, возникающие в перинатальном периоде</b>'),
	('5.1', 'P05', null, null, 'P05%', 'из них:<br>замедленный рост и недостаточность питания'),
	('5.2', 'P10-P15', null, null, 'P1[0-5]%', 'родовая травма - всего'),
	('5.2.1', 'P10', null, null, 'P10%', 'в том числе разрыв внутричерепных тканей и кровоизлияние вследствие родовой травмы'),
	('5.3', 'P20-P28', null, null, 'P2[0-8]%', 'дыхательные нарушения, характерные для перинатального периода - всего'),
	('5.3.1', 'P20, P21', null, null, 'P2[01]%', 'из них:<br>внутриутробная гипоксия, асфиксия при родах'),
	('5.3.2', 'P22', null, null, 'P22%', 'дыхательное расстройство у новорожденных'),
	('5.3.3', 'P23', null, null, 'P23%', 'врожденная пневмония'),
	('5.3.4', 'P24', null, null, 'P24%', 'неонатальные аспирационные синдромы'),
	('5.4', 'P35-P39', null, null, 'P3[5-9]%', 'инфекционные болезни, специфичные для перинатального периода - всего'),
	('5.4.1', 'P36', null, null, 'P36%', 'из них бактериальный сепсис новорожденного'),
	('5.5', 'P55-P57', null, null, 'P5[5-7]%', 'гемолитическая болезнь плода и новорожденного, водянка плода, обусловленная гемолитической болезнью; ядерная желтуха'),
	('5.6', 'P58-P59', null, null, 'P5[89]%', 'неонатальная желтуха, обусловленная чрезмерным гемолизом, другими и неуточненными причинами'),
	('5.7', 'P53, P60, P61', 'P60', 'P61.9', 'P53%', 'геморрагическая болезнь, диссеминированное внутрисосудистое свертывание у плода и новорожденного, другие перинатальные гематологические нарушения'),
	('6', 'Q00-Q99', null, null, 'Q%', '<b>врожденные аномалии (пороки развития), деформации и хромосомные нарушения</b>'),
	('7', 'U07.1-2', null, null, 'U07.[12]', '<b>COVID-19</b>'),
	('8', '', null, null, null, '<b>Прочие болезни</b>')

declare @sampleT table (DS1 nvarchar(10), NPOLIS nvarchar(20), VNOV_D int, VNOV_M int, RSLT int) 
insert into @sampleT
	select sl.DS1, p.NPOLIS, p.VNOV_D, zsl.VNOV_M, zsl.RSLT
	from D3_SL_OMS sl
		left join D3_ZSL_OMS zsl on zsl.ID = sl.D3_ZSLID
		left join D3_PACIENT_OMS p on p.ID = zsl.D3_PID
		join D3_SCHET_OMS sc on zsl.D3_SCID = sc.ID and sc.YEAR = @year and sc.CODE_MO = @codemo
	where sl.DS1 <> '' and sl.D3_ZSLID <> '' and sc.ID <> ''
		and zsl.USL_OK = 1
		and datediff(day, DR, DATE_1) <= 6

select dsName, rowNum, ds,
	count(distinct case when VNOV_D between 500 and 999 or VNOV_M between 500 and 999 then NPOLIS end) as c4,
	count(distinct case when VNOV_D between 500 and 999 or VNOV_M between 500 and 999
		and RSLT in (105,106,205,206,313,405,406,411) then NPOLIS end) as c5,
	count(distinct case when VNOV_D between 500 and 999 or VNOV_M between 500 and 999
		and RSLT in (105,106,205,206,313,405,406,411) then NPOLIS end) as c6,
	count(distinct case when VNOV_D >= 1000 or VNOV_M >= 1000 then NPOLIS end) as c7,
	count(distinct case when (VNOV_D >= 1000 or VNOV_M >= 1000)
		and RSLT in (105,106,205,206,313,405,406,411) then NPOLIS end) as c8,
	count(distinct case when (VNOV_D >= 1000 or VNOV_M >= 1000)
		and RSLT in (105,106,205,206,313,405,406,411) then NPOLIS end) as c9
from @formT	left join @sampleT on DS1 between dsFrom and dsTo or DS1 like dsLike
group by dsName, rowNum, ds
order by cast('/'+replace(rowNum,'.','/')+'/' as hierarchyid)