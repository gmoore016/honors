clear all

infile using ../Input/child.dct

//Unneeded documentation parameter
drop Y2267000

//Define labels
label define raceLab   1 "HISPANIC"  2 "BLACK"  3 "NON-BLACK, NON-HISPANIC"
label define sexLab  1 "MALE"  2 "FEMALE"
label define majLab  0 "NONE, NO MAJOR DECLARED YET"  1 "AGRICULTURE / NATURAL RESOURCES"  2 "ANTHROPOLOGY"  3 "ARCHAEOLOGY"  4 "ARCHITECTURE/ENVIRONMENTAL DESIGN"  5 "AREA STUDIES"  6 "BIOLOGICAL SCIENCES"  7 "BUSINESS"  8 "COMMUNICATIONS"  9 "COMPUTER/INFORMATION SCIENCE"  10 "CRIMINOLOGY"  11 "ECONOMICS"  12 "EDUCATION"  13 "ENGINEERING"  14 "ENGLISH"  15 "FINE AND APPLIED ARTS"  16 "FOREIGN LANGUAGES"  17 "HISTORY"  18 "HOME ECONOMICS"  19 "INTERDISCIPLINARY STUDIES"  20 "MATHEMATICS"  21 "NURSING"  22 "OTHER HEALTH PROFESSIONS"  23 "PHILOSOPHY"  24 "PHYSICAL SCIENCES"  25 "POLITICAL SCIENCE AND GOVERNMENT"  26 "PRE-DENTAL"  27 "PRE-LAW"  28 "PRE-MED"  29 "PRE-VET"  30 "PSYCHOLOGY"  31 "SOCIOLOGY"  32 "SOCIAL WORK"  33 "THEOLOGY/RELIGIOUS STUDIES"  99 "OTHER FIELD (SPECIFY)"
label define ynLab  1 "Yes"  0 "No"
label define regionLab 1 "NORTHEAST" 2 "NORTH CENTRAL" 3 "SOUTH" 4 "WEST"
label define majTypeLab 0 "Humanities" 1 "STEM" 2 "Social Science" 3 "Professions" 4 "Business"
label define gradeLab 1 "1ST GRADE"  2 "2ND GRADE"  3 "3RD GRADE"  4 "4TH GRADE"  5 "5TH GRADE"  6 "6TH GRADE"  7 "7TH GRADE"  8 "8TH GRADE"  9 "9TH GRADE"  10 "10TH GRADE"  11 "11TH GRADE"  12 "12TH GRADE"  13 "1ST YEAR COLLEGE"  14 "2ND YEAR COLLEGE"  15 "3RD YEAR COLLEGE"  16 "4TH YEAR COLLEGE"  17 "5TH YEAR COLLEGE"  18 "6TH YEAR COLLEGE"  19 "7TH YEAR COLLEGE"  20 "8TH YEAR COLLEGE OR MORE"  95 "UNGRADED"  0 "None"

//ID Numbers
rename C0000100 cid
rename C0000200 mid

//Demographics
rename C0005300 race
label values race raceLab
rename C0005400 sex
label values sex sexLab
rename C0005700 dob

//Year of study
rename Y1012100 grade0
rename Y1254300 grade2
rename Y1488000 grade4
rename Y1737800 grade6
rename Y2018600 grade8
rename Y2343700 grade10
rename Y2673200 grade12
rename Y3029600 grade14

label values grade* gradeLab

//Fields of study
rename Y1025600 maj0
rename Y1270800 maj2
rename Y1504800 maj4
rename Y1755100 maj6
rename Y2036100 maj8
rename Y2360600 maj10
rename Y2691100 maj12
rename Y3046600 maj14

label values maj* majLab
label define vlY3046600   0 "NONE, NO MAJOR DECLARED YET"  54 "ACCOUNTING"  1 "AGRICULTURE/NATURAL RESOURCES"  34 "ANIMAL SCIENCE"  2 "ANTHROPOLOGY"  60 "APPLIED SCIENCES"  65 "APPLIED TECHNOLOGY (ELECTRICAL, HVAC, INDUSTRIAL MAINTENANCE, ETC.)"  4 "ARCHITECTURE/ENVIRONMENTAL DESIGN"  64 "AUTOMOTIVE/DIESEL TECHNOLOGY"  35 "BIOLOGY"  36 "BIOCHEMISTRY/PHYSIOLOGY/BIOMEDICAL SCIENCE"  7 "BUSINESS"  37 "CHEMISTRY"  39 "COGNITIVE SCIENCE/NEUROSCIENCE"  8 "COMMUNICATIONS"  9 "COMPUTER/INFORMATION SCIENCE/INFORMATION TECHNOLOGY"  38 "COSOMETOLOGY/AESTHETICS"  73 "COUNSELING"  10 "CRIMINOLOGY/CRIMINAL JUSTICE"  40 "CULINARY ARTS"  41 "DENTAL ASSISTANT"  11 "ECONOMICS"  12 "EDUCATION"  74 "EMERGENCY MEDICAL TECHNOLOGY"  13 "ENGINEERING"  14 "ENGLISH"  67 "ENVIRONMENTAL SCIENCES"  42 "FINANCE"  15 "FINE AND APPLIED ARTS/ART HISTORY"  16 "FOREIGN LANGUAGES"  75 "GENERAL EDUCATION"  43 "GENERAL STUDIES/LIBERAL ARTS"  56 "GEOGRAPHY"  44 "GRAPHIC DESIGN"  71 "HEALTH SCIENCES"  45 "HEALTHCARE ADMINISTRATION"  17 "HISTORY"  59 "HOSPITALITY/HOTEL MANAGEMENT"  18 "HUMAN ECOLOGY/HOME ECONOMICS"  46 "HUMAN RESOURCES"  19 "INTERDISCIPLINARY STUDIES"  55 "JOURNALISM/MEDIA STUDIES"  68 "KINESIOLOGY/SPORTS SCIENCE"  47 "MARKETING/ADVERTISING"  20 "MATHEMATICS"  48 "MEDICAL ASSISTANT"  72 "MEDICAL TECHNOLOGY"  49 "MUSIC"  21 "NURSING"  22 "OTHER HEALTH PROFESSIONS"  52 "OTHER SCIENCE"  62 "PARALEGAL STUDIES"  50 "PHARMACY/PRE-PHARMACY"  23 "PHILOSOPHY"  70 "PHYSICAL/OCCUPATIONAL THERAPY"  51 "PHYSICS"  25 "POLITICAL SCIENCE AND GOVERNMENT"  26 "PRE-DENTAL"  27 "PRE-LAW"  28 "PRE-MED"  29 "PRE-VET"  30 "PSYCHOLOGY"  63 "PUBLIC HEALTH/HUMAN SERVIES"  61 "PUBLIC POLICY/ADMINISTRATION"  58 "PUBLIC SAFETY"  57 "SECURITY/EMERGENCY MANAGEMENT"  32 "SOCIAL WORK"  31 "SOCIOLOGY"  53 "THEATRE/ MUSICAL THEATRE/DANCE"  33 "THEOLOGY/RELIGIOUS STUDIES"  69 "VETERINARY TECHNOLOGY"  66 "WELDING"  99 "OTHER FIELD (SPECIFY)"
//Recoded majors in 2014
label values maj14 vlY3046600

//Receive loan?
rename Y1026600 recloan0
rename Y1271800 recloan2
rename Y1505800 recloan4
rename Y1756100 recloan6
rename Y2037100 recloan8
rename Y2361600 recloan10
rename Y2692100 recloan12
rename Y3047600 recloan14

label values recloan* ynLab

//Region
rename Y1193000 region0
rename Y1435200 region2
rename Y1673400 region4
rename Y1949200 region6
rename Y2267800 region8
rename Y2616700 region10
rename Y2967200 region12
rename Y3332700 region14

label values region* regionLab

//Loan quantities
rename Y1026700 loan0
rename Y1271900 loan2
rename Y1505900 loan4
rename Y1756200 loan6
rename Y2037200 loan8
rename Y2361700 loan10
rename Y2692200 loan12
rename Y3047700 loan14

//Tuition
rename Y1026400 fulltuition0
rename Y1026500 partialtuition0
rename Y1271600 fulltuition2
rename Y1271700 partialtuition2
rename Y1505600 fulltuition4
rename Y1505700 partialtuition4
rename Y1755900 fulltuition6
rename Y1756000 partialtuition6
rename Y2036900 fulltuition8
rename Y2037000 partialtuition8
rename Y2361400 fulltuition10
rename Y2361500 partialtuition10
rename Y2691900 fulltuition12
rename Y2692000 partialtuition12

rename Y3047500 tuition14


forvalues i = 0(2)12{
	//One of these should be missing (since missings coded as -7 for now)
	assert fulltuition`i' < 0 | partialtuition`i' < 0
	//Treating full-time tuition and part-time tuition identically
	gen tuition`i' = max(fulltuition`i', partialtuition`i')
}


forval i = 0(2)10{
	//Again, missings are negative
	replace recloan`i' = . if recloan`i' < 0
}

//Interview dates
//gen intDate0 = mdy(Y1180501, Y1180500, Y1180502)
gen intDate0 = ym(Y1180502, Y1180501)
//gen intDate2 = mdy(Y1421101, Y1421100, Y1421102)
gen intDate2 = ym(Y1421102, Y1421101)
//gen intDate4 = mdy(Y1450201, Y1450200, Y1450202)
gen intDate4 = ym(Y1450202, Y1450201)
//gen intDate6 = mdy(Y1695601, Y1695600, Y1695602)
gen intDate6 = ym(Y1695602, Y1695601)
//gen intDate8 = mdy(Y1981601, Y1981600, Y1981602)
gen intDate8 = ym(Y1981602, Y1981601) 
//gen intDate10 = mdy(Y2300401, Y2300400, Y2300402)
gen intDate10 = ym(Y2300402, Y2300401)

gen intDate12 = ym(Y2633102, Y2633101)
gen intDate14 = ym(Y2990502, Y2990501)
format intDate* %tm
drop Y1* Y2*

//Calculates how many siblings total
duplicates tag mid, generate(sibs)
	
//Change to long data
reshape long maj recloan loan region grade intDate tuition fulltuition partialtuition, i(cid) j(year)

//Generate rough value for age
//Must use year(dofm(intDate)) since intDate in %tm and year takes %td
gen age = year(dofm(intDate)) - dob

//Dummy for student in college; used to find concurrent siblings
gen inCollege = grade >= 13
duplicates tag year mid inCollege if inCollege > 0, generate(sibsInCollege)

//Drops observations who are not 21 or 22
keep if inlist(age, 21, 22)

//Code to Stata missings
replace maj = . if maj < 0
replace loan = 0 if !recloan & !missing(recloan)
replace loan = . if loan < 0
replace region = . if region < 0
replace recloan = . if recloan < 0
replace grade = . if grade < 0
replace partialtuition = . if partialtuition < 0
replace fulltuition = . if fulltuition < 0
replace tuition = . if tuition < 0


//Generates dummy for after policy change
gen cohort = (year >= 8)
label define cohLab 0 "control" 1 "test"
label values cohort cohLab

//Creates value of treatment
//Freshmen received an increase of 3500-2625=875
//Sophomores received an increase of 4500-3500=1000
gen polImpact = 0
//Students who are sophomores in the 2007-2008 school year receive only sophomore package
replace polImpact = 1000 if  ((grade == 14 & inrange(intDate, ym(2007, 8), ym(2008, 8))) | ///
	 (grade == 15 & inrange(intDate, ym(2008, 8), ym(2009, 8))) | ///
	 (grade == 16 & inrange(intDate, ym(2009, 8), ym(2010, 8))) | ///
	 (grade == 17 & inrange(intDate, ym(2010, 8), ym(2011, 8))))

//Students who enter school after the policy change get full impact
replace polImpact = 1875 if  ((grade == 13 & intDate > ym(2007, 8)) | ///
	 (grade == 14 & intDate > ym(2008, 8)) | ///
	 (grade == 15 & intDate > ym(2009, 8)) | ///
	 (grade == 16 & intDate > ym(2010, 8)) | ///
	 (grade == 17 & intDate > ym(2011, 8)))
	

//Places majors into bins
gen majType = .
//Humanities: Area Studies (5) English (14) Art (15) Language (16) History (17)
//		Interdisciplinary Studies (19) Philosophy (23) Theology (33)
replace majType = 0 if inlist(maj, 5, 14, 15, 16, 17, 19, 23, 33)
//STEM: Agriculture (1) Architecture (4) Biology (6) CS(9) Engineering (13) 
//		Math (20) Physics (24)
replace majType = 1 if inlist(maj, 1, 4, 6, 9, 13, 20, 24)
//Social Science: Anthropology(2) Archaeology (3) Economics (11) Home Ec (18)
//		Political Science (25) Psychology (30) Sociology (31)
replace majType = 2 if inlist(maj, 2, 3, 11, 18, 25, 30, 31)
//Professional: Communications (8) Criminology (10) Education (12)
//		Nursing (21) Other Health (22) Pre-Dental/Law/Med/Vet (26-29)
//		Social Work (32)
replace majType = 3 if inlist(maj, 7, 8, 10, 12, 21, 22, 26, 27, 28, 29, 32)
//Business: Business (7)
replace majType = 4 if maj == 7




//assert missing(majType) == missing(maj) | maj == 0 | maj == 99

label values majType majTypeLab

gen fallSemester = halfyear(dofm(intDate)) - 1


save ../Output/ChildData.dta, replace

