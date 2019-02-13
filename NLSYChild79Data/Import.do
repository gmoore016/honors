clear all

infile using Download/child.dct

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

label values grade* gradeLab

//Fields of study
rename Y1025600 maj0
rename Y1270800 maj2
rename Y1504800 maj4
rename Y1755100 maj6
rename Y2036100 maj8
rename Y2360600 maj10

label values maj* majLab

//Receive loan?
rename Y1026600 recloan0
rename Y1271800 recloan2
rename Y1505800 recloan4
rename Y1756100 recloan6
rename Y2037100 recloan8
rename Y2361600 recloan10

label values recloan* ynLab

//Region
rename Y1193000 region0
rename Y1435200 region2
rename Y1673400 region4
rename Y1949200 region6
rename Y2267800 region8
rename Y2616700 region10

label values region* regionLab

//Loan quantities
rename Y1026700 loan0
rename Y1271900 loan2
rename Y1505900 loan4
rename Y1756200 loan6
rename Y2037200 loan8
rename Y2361700 loan10

forval i = 0(2)10{
	replace recloan`i' = . if recloan`i' < 0
}

//Interview dates
gen intDate0 = mdy(Y1180501, Y1180500, Y1180502)
gen intDate2 = mdy(Y1421101, Y1421100, Y1421102)
gen intDate4 = mdy(Y1450201, Y1450200, Y1450202)
gen intDate6 = mdy(Y1695601, Y1695600, Y1695602)
gen intDate8 = mdy(Y1981601, Y1981600, Y1981602)
gen intDate10 = mdy(Y2300401, Y2300400, Y2300402)
format intDate* %td
drop Y1* Y2*

//Get only observations with data on receiving loans
drop if missing(recloan0) & missing(recloan2) ///
	& missing(recloan4) & missing(recloan6) ///
	& missing(recloan8) & missing(recloan10)
	
//Change to long data
reshape long maj recloan loan region grade intDate, i(cid) j(year)

//Code to Stata missings
replace maj = . if maj < 0
replace loan = 0 if !recloan & !missing(recloan)
replace loan = . if loan < 0
replace region = . if region < 0
replace recloan = . if recloan < 0
replace grade = . if grade < 0

//Generates dummy for after policy change
gen cohort = (year >= 8)
label define cohLab 0 "control" 1 "test"
label values cohort cohLab

//Creates value of treatment
//Freshmen received an increase of 3500-2625=875
//Sophomores received an increase of 4500-3500=1000
gen polImpact = 0
//Students who are sophomores in the 2007-2008 school year receive only sophomore package
replace polImpact = 1000 if  ((grade == 14 & inrange(intDate, date("15aug2007", "DMY"), date("15aug2008", "DMY"))) | ///
	 (grade == 15 & inrange(intDate, date("15aug2008", "DMY"), date("15aug2009", "DMY"))) | ///
	 (grade == 16 & inrange(intDate, date("15aug2009", "DMY"), date("15aug2010", "DMY"))) | ///
	 (grade == 17 & inrange(intDate, date("15aug2010", "DMY"), date("15aug2011", "DMY"))))

//Students who enter school after the policy change get full impact
replace polImpact = 1875 if  ((grade == 13 & intDate > date("15aug2007", "DMY")) | ///
	 (grade == 14 & intDate > date("15aug2008", "DMY")) | ///
	 (grade == 15 & intDate > date("15aug2009", "DMY")) | ///
	 (grade == 16 & intDate > date("15aug2010", "DMY")) | ///
	 (grade == 17 & intDate > date("15aug2011", "DMY")))
	

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

assert missing(majType) == missing(maj) | maj == 0 | maj == 99

label values majType majTypeLab


