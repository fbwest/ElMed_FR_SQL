declare @year as int = 2022;
declare @monthFrom as int = 1;
declare @monthTo as int = 12;

USE Elmedicine_Ivanovo;

declare @tableVedPr table(id int, ved nvarchar(100))
insert into @tableVedPr (id, ved) values
	(3, 'Министерство здравоохранения Российской Федерации'),
	(10, 'Федеральное медико-биологическое агентство'),
	(36, 'Федеральное агентство научных организаций'),
	(9, 'Российская академия медицинских наук'),
	(37, 'Российская академия наук'),
	(31, 'Министерство промышленности и торговли Российской Федерации'),
	(30, 'Министерство энергетики Российской Федерации'),
	(32, 'Министерство сельского хозяйства Российской Федерации'),
	(26, 'Министерство финансов Российской Федерации'),
	(23, 'Федеральное агентство воздушного транспорта'),
	(25, 'Федеральное дорожное агентство'),
	(24, 'Федеральное агентство морского и речного транспорта'),
	(28, 'Министерство экономического развития Российской Федерации'),
	(35, 'Федеральная служба по надзору в сфере защиты прав потребителей и благополучия человека'),
	(16, 'Министерство труда и социального развития Российской Федерации'),
	(29, 'Федеральное агентство по управлению государственным имуществом'),
	(27, 'Федеральная налоговая служба'),
	(34, 'Управление делами Президента Российской Федерации'),
	(21, 'Министерство иностранных дел Российской Федерации'),
	(33, 'Федеральная служба судебных приставов'),
	(22, 'Федеральное агентство специального строительства')

SELECT vedpr.ved as ved, f003.nam_mok as mo,
	-- амбулат - проф цель
	count(distinct case when (zsl.USL_OK = 3) and
		(sl.POVOD in (1,2,3,4,6,9,16,17,18,19,20,21,22,23,24,25,26,28,29,31,32,33,35,45,46)) then sl.ID end)
		as amb_prof_12,
	sum(case when (zsl.USL_OK = 3) and
		(sl.POVOD in (1,2,3,4,6,9,16,17,18,19,20,21,22,23,24,25,26,28,29,31,32,33,35,45,46)) then sl.SUM_M end)
		as amb_prof_13,
	-- амбулат - неотложная
	count(distinct case when (zsl.USL_OK = 3) and (sl.POVOD = 11) then sl.ID end) as amb_neotl_12,
	sum(case when (zsl.USL_OK = 3) and (sl.POVOD = 11) then sl.SUM_M end) as amb_neotl_13,
	-- амбулат - заболевание
	count(distinct case when (zsl.USL_OK = 3) and
		(sl.POVOD in (30,50) or (sl.POVOD = 3 and usl.CODE_USL = '36')) then sl.ID end) as amb_zabol_12,
	sum(case when (zsl.USL_OK = 3) and
		(sl.POVOD in (30,50) or (sl.POVOD = 3 and usl.CODE_USL = '36')) then sl.SUM_M end) as amb_zabol_13,
	-- дневной стац - пациенто-день
	sum(case when zsl.USL_OK = 2 then sl.KD end) as dnstac_kd_12,
	-- дневной стац - случай госпитал
	count(distinct case when zsl.USL_OK = 2 then sl.ID end) as dnstac_12,
	sum(case when zsl.USL_OK = 2 then sl.SUM_M end) as dnstac_13,
	-- дневной стац - высокотех - пациенто-день
	sum(case when zsl.USL_OK = 2 and zsl.VIDPOM in (32,33) then sl.KD end) as dnstac_vmp_kd_12,
	-- дневной стац - высокотех - случай госпитал
	count(distinct case when zsl.USL_OK = 2 and zsl.VIDPOM in (32,33) then sl.ID end) as dnstac_vmp_12,
	sum(case when zsl.USL_OK = 2 and zsl.VIDPOM in (32,33) then sl.SUM_M end) as dnstac_vmp_13,
	-- стационар - койко-день
	sum(case when zsl.USL_OK = 1 then sl.KD end) as stac_kd_12,
	-- стационар - случай госпитал
	count(distinct case when zsl.USL_OK = 1 then sl.ID end) as stac_12,
	sum(case when zsl.USL_OK = 1 then sl.SUM_M end) as stac_13,
	-- стационар - высокотех - койко-день
	sum(case when zsl.USL_OK = 1 and zsl.VIDPOM in (32,33) then sl.KD end) as stac_vmp_kd_12,
	-- стационар - высокотех - случай госпитал
	count(distinct case when zsl.USL_OK = 1 and zsl.VIDPOM in (32,33) then sl.ID end) as stac_vmp_12,
	sum(case when zsl.USL_OK = 1 and zsl.VIDPOM in (32,33) then sl.SUM_M end) as stac_vmp_13,
	-- скорая
	count(distinct case when zsl.USL_OK = 4 then zsl.ID end) as emergency_12,
	sum(case when zsl.USL_OK = 4 then zsl.SUMV end) as emergency_13,
	-- итого по МО
	sum(case
			when zsl.USL_OK in (1,2)
				or (zsl.USL_OK = 3
				and (sl.POVOD in (1,2,3,4,6,9,11,16,17,18,19,20,21,22,23,24,25,26,28,29,30,31,32,33,35,45,46,50)
				or (sl.POVOD = 3 and usl.CODE_USL = '36'))) then sl.SUM_M
			when zsl.USL_OK = 4 then zsl.SUMV
		end) as itog_13

  FROM D3_SL_OMS sl
	  left join D3_ZSL_OMS zsl on zsl.ID = sl.D3_ZSLID
	  left join D3_PACIENT_OMS p on p.ID = zsl.D3_PID
	  left join D3_USL_OMS usl on usl.D3_SLID = sl.ID and usl.CODE_USL = '36'
	  join D3_SCHET_OMS sc on zsl.D3_SCID = sc.ID and sc.YEAR = @year and sc.MONTH between @monthFrom and @monthTo
	  left join F003 f003 on sc.CODE_MO = f003.mcod
	  join @tableVedPr vedpr on f003.vedpri = vedpr.id

  WHERE sc.CODE_MO <> ''
  group by vedpr.ved, f003.nam_mok
  order by f003.nam_mok