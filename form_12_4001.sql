﻿declare @year int = 2022
declare @codemo int = 370024

-- form 12 4001 --
declare @form table (rowNum nvarchar(10), ds nvarchar(100), dsFrom nvarchar(10), dsTo nvarchar(10),
	dsLike nvarchar(100), dsLike2 nvarchar(100), dsName nvarchar(300))
insert into @form values
	('1.0', 'A00-T98', null, null, '[A-T]%', null, N'<b>Зарегистрировано заболеваний – всего</b>'),
	('2.0', 'A00-B99', null, null, '[AB]%', null,
     N'<b>в том числе:<br>некоторые инфекционные и паразитарные болезни</b>'),
	('2.1', 'A00-A09', null, null, 'A0%', null, N'из них:<br>кишечные инфекции'),
	('2.2', 'A39', null, null, 'A39%', null, N'менингококковая инфекция'),
	('2.3', 'B15-B19', null, null, 'B1[5-9]%', null, N'вирусный гепатит'),
	('2.3.1', 'B18.2', null, null, 'B18.2', null, N'из них хронический вирусный гепатит С'),
	('3.0', 'C00-D48', 'C00', 'D48.9', null, null, N'<b>новообразования</b>'),
	('3.1', 'C00-C96', 'C00', 'C96.9', null, null, N'из них:<br>злокачественные новообразования'),
	('3.1.1', 'C81-C96', 'C81', 'C96.9', null, null,
     N'из них:<br>злокачественные новообразования лимфоидной, кроветворной и родственных им тканей'),
	('3.2', 'D10-D36', 'D10', 'D36.9', null, null, N'доброкачественные новообразования'),
	('4.0', 'D50-D89', 'D50', 'D89.9', null, null,
     N'<b>болезни крови, кроветворных органов и отдельные нарушения, вовлекающие иммунный механизм</b>'),
	('4.1', 'D50-D64', 'D50', 'D64.9', null, null, N'из них:<br>анемии'),
	('4.1.1', 'D60-D61', null, null, 'D6[01]%', null, N'из них:<br>апластические анемии'),
	('4.2', 'D65-D69', null, null, 'D6[5-9]%', null,
     N'нарушения свертываемости крови, пурпура и другие геморрагические состояния'),
	('4.2.1', 'D66-D68', null, null, 'D6[6-8]%', null, N'из них:<br>гемофилия'),
	('4.3', 'D80-D89', null, null, 'D8[0-9]%', null, N'отдельные нарушения, вовлекающие иммунный механизм'),
	('5.0', 'E00-E89', 'E00', 'E89.9', null, null,
     N'<b>болезни эндокринной системы, расстройства питания и нарушения обмена веществ</b>'),
	('5.1', 'E00-E07', null, null, 'E0[0-7]%', null, N'из них:<br>болезни щитовидной железы'),
	('5.1.1', 'E00', null, null, 'E00%', null, N'из них:<br>синдром врожденной йодной недостаточности'),
	('5.1.2', 'E01.0-2', null, null, 'E01.[0-2]', null, N'эндемический зоб, связанный с йодной недостаточностью'),
	('5.1.3', 'E02, E03', null, null, 'E0[23]%', null,
     N'субклинический гипотиреоз вследствие йодной недостаточности и другие формы гипотиреоза'),
	('5.1.4', 'E04', null, null, 'E04%', null, N'другие формы нетоксического зоба'),
	('5.1.5', 'E05', null, null, 'E05%', null, N'тиреотоксикоз (гипертиреоз)'),
	('5.1.6', 'E06', null, null, 'E06%', null, N'тиреоидит'),
	('5.2', 'E10-E14', null, null, 'E1[0-4]%', null, N'сахарный диабет'),
	('5.2.1', 'E10.3, E11.3, E12.3, E13.3, E14.3', null, null, 'E1[0-4].3', null, N'из него:<br>с поражением глаз'),
	('5.2.2', 'E10.2, E11.2, E12.2, E13.2, E14.2', null, null, 'E1[0-4].2', null, N'с поражением почек'),
	('5.2.3', 'E10', null, null, 'E10%', null, N'из него (из стр. 5.2):<br>сахарный диабет I типа'),
	('5.2.4', 'E11', null, null, 'E11%', null, N'сахарный диабет II типа'),
	('5.3', 'E22', null, null, 'E22%', null, N'гиперфункция гипофиза'),
	('5.4', 'E23.0', null, null, 'E23.0', null, N'гипопитуитаризм'),
	('5.5', 'E23.2', null, null, 'E23.2', null, N'несахарный диабет'),
	('5.6', 'E25', null, null, 'E25%', null, N'адреногенитальные расстройства'),
	('5.7', 'E28', null, null, 'E28%', null, N'дисфункция яичников'),
	('5.8', 'E29', null, null, 'E29%', null, N'дисфункция яичек'),
	('5.10', 'E66', null, null, 'E66%', null, N'ожирение'),
	('5.11', 'E70.0', null, null, 'E70.0', null, N'фенилкетонурия'),
	('5.12', 'E74.2', null, null, 'E74.2', null, N'нарушения обмена галактозы (галактоземия)'),
	('5.13', 'E75.2', null, null, 'E75.2', null, N'болезнь Гоше'),
	('5.14', 'E76', null, null, 'E76%', null, N'нарушения обмена гликозаминогликанов (мукополисахаридозы)'),
	('5.15', 'E84', null, null, 'E84%', null, N'муковисцидоз'),
	('6.0', 'F01, F03-F99', 'F03', 'F99.9', 'F01%', null, N'<b>психические расстройства и расстройства поведения</b>'),
	('6.1', 'F10-F19', null, null, 'F1[0-9]%', null,
     N'из них:<br>психические расстройства и расстройства поведения, связанные с употреблением психоактивных веществ'),
	('7.0', 'G00-G98', 'G00', 'G98.9', null, null, N'<b>болезни нервной системы</b>'),
	('7.1', 'G00-G09', null, null, 'G0[0-9]%', null, N'из них:<br>воспалительные болезни центральной нервной системы'),
	('7.1.1', 'G00', null, null, 'G00%', null, N'из них:<br>бактериальный менингит'),
	('7.1.2', 'G04', null, null, 'G04%', null, N'энцефалит, миелит и энцефаломиелит'),
	('7.2', 'G10-G12', null, null, 'G1[0-2]%', null,
     N'системные атрофии, поражающие преимущественно центральную нервную систему'),
	('7.3', 'G20, G21, G23-G25', null, null, 'G2[0135]%', null, N'экстрапирамидные и другие двигательные нарушения'),
	('7.3.2', 'G25', null, null, 'G25%', null, N'из них:<br>другие экстрапирамидные и двигательные нарушения'),
	('7.4', 'G30-G31', null, null, 'G3[01]%', null, N'другие дегенеративные болезни нервной системы'),
	('7.4.1', 'G30', null, null, 'G30%', null, N'из них болезнь Альцгеймера'),
	('7.5', 'G35-G37', null, null, 'G3[5-7]%', null, N'демиелинизирующие болезни центральной нервной системы'),
	('7.5.1', 'G35', null, null, 'G35%', null, N'из них:<br>рассеянный склероз'),
	('7.6', 'G40-G47', null, null, 'G4[0-7]%', null, N'эпизодические и пароксизмальные расстройства'),
	('7.6.1', 'G40-G41', null, null, 'G4[01]%', null, N'из них:<br>эпилепсия, эпилептический статус'),
	('7.6.2', 'G45', null, null, 'G45%', null,
     N'преходящие транзиторные церебральные ишемические приступы (атаки) и родственные синдромы'),
	('7.7', 'G50-G64', 'G50', 'G64.9', null, null,
     N'поражения отдельных нервов, нервных корешков и сплетений, полиневропатии и другие поражения периферической нервной системы'),
	('7.7.1', 'G61.0', null, null, 'G61.0', null, N'из них:<br>синдром Гийена-Барре'),
	('7.8', 'G70-G73', null, null, 'G7[0-3]%', null, N'болезни нервно-мышечного синапса и мышц'),
	('7.8.1', 'G70.0, 2', null, null, 'G70.[02]', null, N'из них:<br>миастения'),
	('7.8.2', 'G71.0', null, null, 'G71.0', null, N'мышечная дистрофия Дюшенна'),
	('7.9', 'G80-G83', null, null, 'G8[0-3]%', null, N'церебральный паралич и другие паралитические синдромы'),
	('7.9.1', 'G80', null, null, 'G80%', null, N'из них:<br>церебральный паралич'),
	('7.10', 'G90', null, null, 'G90%', null, N'расстройства вегетативной (автономной) нервной системы'),
	('7.11', 'G95.1', null, null, 'G95.1', null, N'сосудистые миелопатии'),
	('8.0', 'H00-H59', 'H00', 'H59.9', null, null, N'<b>болезни глаза и его придаточного аппарата</b>'),
	('8.1', 'H10', null, null, 'H10%', null, N'из них:<br>конъюнктивит'),
	('8.2', 'H16', null, null, 'H16%', null, N'кератит'),
	('8.2.1', 'H16.0', null, null, 'H16.0', null, N'из него:<br>язва роговицы'),
	('8.3', 'H25-H26', null, null, 'H2[56]%', null, N'катаракта'),
	('8.4', 'H30', null, null, 'H30%', null, N'хориоретинальное воспаление'),
	('8.5', 'H33.0', null, null, 'H33.0', null, N'отслойка сетчатки с разрывом сетчатки'),
	('8.6', 'H35.1', null, null, 'H35.1', null, N'преретинопатия'),
	('8.7', 'H35.3', null, null, 'H35.3', null, N'дегенерация макулы и заднего полюса'),
	('8.8', 'H40', null, null, null, null, N'глаукома'),
	('8.9', 'H44.2', null, null, 'H44.2', null, N'дегенеративная миопия'),
	('8.10', 'H46-H48', null, null, 'H4[6-8]%', null, N'болезни зрительного нерва и зрительных путей'),
	('8.10.1', 'H47.2', null, null, 'H47.2', null, N'из них:<br>атрофия зрительного нерва'),
	('8.11', 'H49-H52', 'H49', 'H52.9', null, null,
     N'болезни мышц глаза, нарушения содружественного движения глаз, аккомодации и рефракции'),
	('8.11.1', 'H52.1', null, null, 'H52.1', null, N'из них:<br>миопия'),
	('8.11.2', 'H52.2', null, null, 'H52.2', null, N'астигматизм'),
	('8.12', 'H54', null, null, 'H54%', null, N'слепота и пониженное зрение'),
	('8.12.1', 'H54.0', null, null, 'H54.0', null, N'из них:<br>слепота обоих глаз'),
	('9.0', 'H60-H95', 'H60', 'H95.9', null, null, N'<b>болезни уха и сосцевидного отростка</b>'),
	('9.1', 'H60-H61', null, null, 'H6[01]%', null, N'из них:<br>болезни наружного уха'),
	('9.2', 'H65-H66, H68-H74', 'H68', 'H74.9', 'H6[56]%', null, N'болезни среднего уха и сосцевидного отростка'),
	('9.2.1', 'H65.0, H65.1, H66.0', 'H65.0', 'H65.1', 'H66.0', null, N'из них:<br>острый средний отит'),
	('9.2.2', 'H65.2-4; H66.1-3', 'H65.2', 'H65.4', 'H66.[1-3]', null, N'хронический средний отит'),
	('9.2.3', 'H68-H69', null, null, 'H6[89]%', null, N'болезни слуховой (евстахиевой) трубы'),
	('9.2.4', 'H72', null, null, 'H72%', null, N'перфорация барабанной перепонки'),
	('9.2.5', 'H74', null, null, 'H74%', null, N'другие болезни среднего уха и сосцевидного отростка'),
	('9.3', 'H80-H81, H83', null, null, null, 'H8[013]%', N'болезни внутреннего уха'),
	('9.3.1', 'H80', null, null, 'H80%', null, N'из них:<br>отосклероз'),
	('9.3.2', 'H81.0', null, null, 'H81.0', null, N'болезнь Меньера'),
	('9.4', 'H90', null, null, 'H90%', null, N'кондуктивная и нейросенсорная потеря слуха'),
	('9.4.1', 'H90.0', null, null, 'H90.0', null, N'из них:<br>кондуктивная потеря слуха двусторонняя'),
	('9.4.2', 'H90.3', null, null, 'H90.3', null, N'нейросенсорная потеря слуха двусторонняя'),
	('10.0', 'I00-I99', null, null, 'I%', null, N'<b>болезни системы кровообращения</b>'),
	('10.1', 'I00-I02', null, null, 'I0[0-2]%', null, N'из них:<br>острая ревматическая лихорадка'),
	('10.2', 'I05-I09', null, null, 'I0[5-9]%', null, N'хронические ревматические болезни сердца'),
	('10.2.1', 'I05-I08', null, null, 'I0[5-8]%', null, N'из них:<br>ревматические поражения клапанов'),
	('10.3', 'I10-I13', null, null, 'I1[0-3]%', null, N'болезни, характеризующиеся повышенным кровяным давлением'),
	('10.3.1', 'I10', null, null, 'I10%', null, N'из них:<br>эссенциальная гипертензия'),
	('10.3.2', 'I11', null, null, 'I11%', null,
     N'гипертензивная болезнь сердца (гипертоническая болезнь с преимущественным поражением сердца)'),
	('10.3.3', 'I12', null, null, 'I12%', null,
     N'гипертензивная болезнь почки (гипертоническая болезнь с преимущественным поражением почек)'),
	('10.3.4', 'I13', null, null, 'I13%', null,
     N'гипертензивная болезнь сердца и почки (гипертоническая болезнь с преимущественным поражением сердца и почек)'),
	('10.4', 'I20-I25', null, null, 'I2[0-5]%', null, N'ишемические болезни сердца'),
	('10.4.1', 'I20', null, null, 'I20%', null, N'из них:<br>стенокардия'),
	('10.4.1.1', 'I20.0', null, null, 'I20.0', null, N'из нее:<br>нестабильная стенокардия'),
	('10.4.2', 'I21', null, null, 'I21%', null, N'острый инфаркт миокарда'),
	('10.4.3', 'I22', null, null, 'I22%', null, N'повторный инфаркт миокарда'),
	('10.4.4', 'I24', null, null, 'I24%', null, N'другие формы острых ишемических болезней сердца'),
	('10.4.5', 'I25', null, null, 'I25%', null, N'хроническая ишемическая болезнь сердца'),
	('10.4.5.1', 'I25.8', null, null, 'I25.8', null, N'из нее:<br>постинфарктный кардиосклероз'),
	('10.5', 'I30-I51', 'I30', 'I51.9', null, null, N'другие болезни сердца'),
	('10.5.1', 'I30', null, null, 'I30%', null, N'из них:<br>острый перикардит'),
	('10.5.2', 'I33', null, null, 'I33%', null, N'острый и подострый эндокардит'),
	('10.5.3', 'I40', null, null, 'I40%', null, N'острый миокардит'),
	('10.5.4', 'I42', null, null, 'I42%', null, N'кардиомиопатия'),
	('10.6', 'I60-I69', null, null, 'I6[0-9]%', null, N'цереброваскулярные болезни'),
	('10.6.1', 'I60', null, null, 'I60%', null, N'из них:<br>субарахноидальное кровоизлияние'),
	('10.6.2', 'I61, I62', null, null, 'I6[12]%', null, N'внутримозговое и другое внутричерепное кровоизлияние'),
	('10.6.3', 'I63', null, null, 'I63%', null, N'инфаркт мозга'),
	('10.6.4', 'I64', null, null, 'I64%', null, N'инсульт, не уточненный как кровоизлияние или инфаркт'),
	('10.6.5', 'I65-I66', null, null, 'I6[56]%', null,
     N'закупорка и стеноз прецеребральных, церебральных артерий, не приводящие к инфаркту мозга'),
	('10.6.6', 'I67', null, null, 'I67%', null, N'другие цереброваскулярные болезни'),
	('10.6.7', 'I69', null, null, 'I69%', null, N'последствия цереброваскулярных болезней'),
	('10.7', 'I70.2, I73.1', 'I70.2', 'I70.2', 'I73.1', null, N'эндартериит, тромбангиит облитерирующий'),
	('10.8', 'I80-I83, I85-I89', null, null, 'I8[^4]%', null,
     N'болезни вен, лимфатических сосудов и лимфатических узлов'),
	('10.8.1', 'I80', null, null, 'I80%', null, N'из них:<br>флебит и тромбофлебит'),
	('10.8.2', 'I81', null, null, 'I81%', null, N'тромбоз портальной вены'),
	('10.8.3', 'I83', null, null, 'I83%', null, N'варикозное расширение вен нижних конечностей'),
	('11.0', 'J00-J98', 'J00', 'J98.9', null, null, N'<b>болезни органов дыхания</b>'),
	('11.1', 'J00-J06', null, null, 'J0[0-6]%', null,
     N'из них:<br>острые респираторные инфекции верхних дыхательных путей'),
	('11.1.1', 'J04', null, null, 'J04%', null, N'из них:<br>острый ларингит и трахеит'),
	('11.1.2', 'J05', null, null, 'J05%', null, N'острый обструктивный ларингит (круп) и эпиглоттит'),
	('11.2', 'J09-J11', 'J09', 'J11.9', null, null, N'грипп'),
	('11.3', 'J12-J16, J18', null, null, 'J1[234568]%', null, N'пневмонии'),
	('11.3.1', 'J13', null, null, 'J13%', null, N'из них:<br>бронхопневмония, вызванная S.Pneumoniae'),
	('11.4', 'J20-J22', null, null, 'J2[0-2]%', null, N'острые респираторные инфекции нижних дыхательных путей'),
	('11.5', 'J30.1', null, null, 'J30.1', null, N'аллергический ринит (поллиноз)'),
	('11.6', 'J35-J36', null, null, 'J3[56]%', null,
     N'хронические болезни миндалин и аденоидов, перитонзиллярный абсцесс'),
	('11.7', 'J40-J43', null, null, 'J4[0-3]%', null, N'бронхит хронический и неуточненный, эмфизема'),
	('11.8', 'J44', null, null, 'J44%', null, N'другая хроническая обструктивная легочная болезнь'),
	('11.9', 'J47', null, null, 'J47%', null, N'бронхоэктатическая болезнь'),
	('11.10', 'J45, J46', null, null, 'J4[56]%', null, N'астма; астматический статус'),
	('11.11', 'J84-J90, J92-J94', 'J84', 'J90.9', 'J9[2-4]%', null,
     N'другие интерстициальные легочные болезни, гнойные и некротические состояния нижних дыхательных путей, другие болезни плевры'),
	('12.0', 'K00-K92', 'K00', 'K92.9', null, null, N'<b>болезни органов пищеварения</b>'),
	('12.1', 'K25-K26', null, null, 'K2[56]%', null, N'из них:<br>язва желудка и двенадцатиперстной кишки'),
	('12.2', 'K29', null, null, 'K29%', null, N'гастрит и дуоденит'),
	('12.3', 'K40-K46', null, null, 'K4[0-6]%', null, N'грыжи'),
	('12.4', 'K50-K52', null, null, 'K5[0-2]%', null, N'неинфекционный энтерит и колит'),
	('12.4.1', 'K50', null, null, 'K50%', null, N'из них:<br>болезнь Kрона'),
	('12.4.2', 'K51', null, null, 'K51%', null, N'язвенный колит'),
	('12.5', 'K55-K63', 'K55', 'K63.9', null, null, N'другие болезни кишечника'),
	('12.5.1', 'K56', null, null, 'K56%', null, N'из них:<br>паралитический илеус и непроходимость кишечника без грыжи'),
	('12.6', 'K64', null, null, 'K64%', null, N'геморрой'),
	('12.7', 'K70-K76', null, null, 'K7[0-6]%', null, N'болезни печени'),
	('12.7.1', 'K74', null, null, 'K74%', null, N'из них:<br>фиброз и цирроз печени'),
	('12.8', 'K80-K83', null, null, 'K8[0-3]%', null, N'болезни желчного пузыря, желчевыводящих путей'),
	('12.9', 'K85-K86', null, null, 'K8[56]%', null, N'болезни поджелудочной железы'),
	('12.9.1', 'K85', null, null, 'K85%', null, N'из них:<br>острый панкреатит'),
	('13.0', 'L00-L98', 'L00', 'L98.9', null, null, N'<b>болезни кожи и подкожной клетчатки</b>'),
	('13.1', 'L20', null, null, 'L20%', null, N'из них:<br>атопический дерматит'),
	('13.2', 'L23-L25', null, null, 'L2[3-5]%', null, N'контактный дерматит'),
	('13.3', 'L30', null, null, 'L30%', null, N'другие дерматиты (экзема)'),
	('13.4', 'L40', null, null, 'L40%', null, N'псориаз'),
	('13.4.1', 'L40.5', null, null, 'L40.5', null, N'из него:<br>псориаз артропатический'),
	('13.5', 'L93.0', null, null, 'L93.0', null, N'дискоидная красная волчанка'),
	('13.6', 'L94.0', null, null, 'L94.0', null, N'локализованная склеродермия'),
	('14.0', 'M00-M99', null, null, 'M%', null, N'<b>болезни костно-мышечной системы и соединительной ткани</b>'),
	('14.1', 'M00-M25', 'M00', 'M25.9', null, null, N'из них:<br>артропатии'),
	('14.1.1', 'M00.1', null, null, 'M00.1', null, N'из них:<br>пневмококковый артрит и полиартрит'),
	('14.1.2', 'M02', null, null, 'M02%', null, N'реактивные артропатии'),
	('14.1.3', 'M05-M06', null, null, 'M0[56]%', null, N'ревматоидный артрит (серопозитивный и серонегативный)'),
	('14.1.5', 'M15-M19', null, null, 'M1[5-9]%', null, N'артрозы'),
	('14.2', 'M30-M35', null, null, 'M3[0-5]%', null, N'системные поражения соединительной ткани'),
	('14.2.1', 'M32', null, null, 'M32%', null, N'из них:<br>системная красная волчанка'),
	('14.3', 'M40-M43', null, null, 'M4[0-3]%', null, N'деформирующие дорсопатии'),
	('14.4', 'M45-M48', null, null, 'M4[5-8]%', null, N'спондилопатии'),
	('14.4.1', 'M45', null, null, 'M45%', null, N'из них:<br>анкилозирующий спондилит'),
	('14.5', 'M65-M67', null, null, 'M6[5-7]%', null, N'поражение синовиальных оболочек и сухожилей'),
	('14.6', 'M80-M94', 'M80', 'M94.9', null, null, N'остеопатии и хондропатии'),
	('14.6.1', 'M80', null, null, 'M80%', null, N'из них:<br>остеопороз с патологическим переломом'),
	('14.6.2', 'M81', null, null, 'M81%', null, N'остеопороз без патологического перелома'),
	('15.0', 'N00-N99', null, null, 'N%', null, N'<b>болезни мочеполовой системы</b>'),
	('15.1', 'N00-N07, N09-N15, N25-N28', 'N09', 'N15.9', 'N0[0-7]%', 'N2[5-8]%',
     N'из них:<br>гломерулярные, тубулоинтерстициальные болезни почек, другие болезни почки и мочеточника'),
	('15.2', 'N17-N19', null, null, 'N1[7-9]%', null, N'почечная недостаточность'),
	('15.3', 'N20-N21, N23', null, null, 'N2[013]%', null, N'мочекаменная болезнь'),
	('15.4', 'N30-N32, N34-N36, N39', null, null, 'N3[0124569]%', null, N'другие болезни мочевой системы'),
	('15.5', 'N40-N42', null, null, 'N4[0-2]%', null, N'болезни предстательной железы'),
	('15.7', 'N60', null, null, 'N60%', null, N'доброкачественная дисплазия молочной железы'),
	('15.8', 'N70-N73, N75-N76', null, null, 'N7[012356]%', null, N'воспалительные болезни женских тазовых органов'),
	('15.8.1', 'N70', null, null, 'N70%', null, N'из них:<br>сальпингит и оофорит'),
	('15.9', 'N80', null, null, 'N80%', null, N'эндометриоз'),
	('15.10', 'N86', null, null, 'N86%', null, N'эрозия и эктропион шейки матки'),
	('15.11', 'N91-N94', null, null, 'N9[1-4]%', null, N'расстройства менструаций'),
	('16.0', 'O00-O99', null, null, 'O%', null, N'<b>беременность, роды и послеродовой период</b>'),
	('18.0', 'Q00-Q99', null, null, 'Q%', null,
     N'<b>врожденные аномалии (пороки развития), деформации и хромосомные нарушения</b>'),
	('18.1', 'Q00-Q07', null, null, 'Q0[0-7]%', null, N'из них:<br>врожденные аномалии развития нервной системы'),
	('18.2', 'Q10-Q15', null, null, 'Q1[0-5]%', null, N'врожденные аномалии глаза'),
	('18.3', 'Q20-Q28', null, null, 'Q2[0-8]%', null, N'врожденные аномалии системы кровообращения'),
	('18.4', 'Q50-Q52', null, null, 'Q5[0-2]%', null, N'врожденные аномалии женских половых органов'),
	('18.5', 'Q56', null, null, 'Q56%', null, N'неопределенность пола и псевдогермафродитизм'),
	('18.6', 'Q65', null, null, 'Q65%', null, N'врожденные деформации бедра'),
	('18.7', 'Q80', null, null, 'Q80%', null, N'врожденный ихтиоз'),
	('18.8', 'Q85.0', null, null, 'Q85.0', null, N'нейрофиброматоз'),
	('18.9', 'Q90', null, null, 'Q90%', null, N'синдром Дауна'),
	('19.0', 'R00-R99', null, null, 'R%', null,
     N'<b>симптомы, признаки и отклонения от нормы, выявленные при клинических и лабораторных исследованиях, не' +
     N'классифицированные в других рубриках</b>'),
	('20.0', 'S00-T98', 'S00', 'T98.9', null, null,
     N'<b>травмы, отравления и некоторые другие последствия воздействия внешних причин</b>'),
	('20.1', 'S01, S11, S21, S31, S41, S51, S61, S71, S81, S91', null, null, 'S[0-9]1%', null,
     N'из них:<br>открытые укушенные раны (только с кодом внешней причины W54)'),
	('21', 'U07.1, U07.2', null, null, 'U07.[12]', null, '<b>COVID-19</b>');

declare @tempTable table (DS1 nvarchar(10), ZSLID int, DATE_1 datetime, DN int, DS1_PR int,
	P_CEL nvarchar(3), DR datetime, NPOLIS nvarchar(20), CODE_USL nvarchar(20)) 
insert into @tempTable
    select sl.DS1, sl.D3_ZSLID, sl.DATE_1, sl.DN, sl.DS1_PR, sl.P_CEL, p.DR, p.NPOLIS, usl.CODE_USL
    from D3_SL_OMS sl
        left join D3_ZSL_OMS zsl on zsl.ID = sl.D3_ZSLID
        left join D3_PACIENT_OMS p on p.ID = zsl.D3_PID 
        left join D3_USL_OMS usl on usl.D3_SLID = sl.ID
        join D3_SCHET_OMS sc on zsl.D3_SCID = sc.ID and sc.YEAR = @year and sc.CODE_MO = @codemo
    where sl.DS1 <> '' and sl.D3_ZSLID <> '' and sc.ID <> ''
        and floor(datediff(day, p.DR, sl.DATE_1) / 365.25) > 60

select
	count(distinct t.NPOLIS) as s4001_1,
	count(distinct case when DS1_PR = 1 then t.NPOLIS end) as s4001_2,
	count(distinct case when dnMax <= 2 then t.NPOLIS end) as s4001_3,
	count(distinct case when dnMax <= 2	and (b18 > 0 and k74 > 0) then t.NPOLIS end) as s4003_1,
	count(distinct case when dnMax <= 2	and (b18 > 0 and c22 > 0) then t.NPOLIS end) as s4003_2,
	count(distinct case when DN = 2 and rowNum = '10.0' then t.NPOLIS end) as s4004_1,
	count(distinct case when DN = 2 and rowNum = '10.0' and dnMax >= 4 then t.NPOLIS end) as s4004_2
from @form m
	left join @tempTable t on
		t.DS1 between m.dsFrom and m.dsTo
		or t.DS1 like m.dsLike
		or t.DS1 like m.dsLike2
	left join (
		select NPOLIS,
			count(distinct case when DS1 like 'B18%' then NPOLIS end) as b18,
			count(distinct case when DS1 = 'K74.6' then NPOLIS end) as k74,
			count(distinct case when DS1 = 'C22.0' then NPOLIS end) as c22,
			max(DN) as dnMax
		from @tempTable
		group by NPOLIS
	) p on p.NPOLIS = t.NPOLIS