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

//ID Numbers
rename C0000100 cid
rename C0000200 mid

//Demographics
rename C0005300 race
label values race raceLab
rename C0005400 sex
label values sex sexLab
rename C0005700 dob

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

//Get only observations with data on receiving loans
drop if missing(recloan0) & missing(recloan2) ///
	& missing(recloan4) & missing(recloan6) ///
	& missing(recloan8) & missing(recloan10)
	
//Change to long data
reshape long maj recloan loan region, i(cid) j(year)

//Code to Stata missings
replace maj = . if maj < 0
replace loan = 0 if !recloan & !missing(recloan)
replace loan = . if loan < 0
replace region = . if region < 0
replace recloan = . if recloan < 0

//Generates dummy for after policy change
gen cohort = (year >= 8)
label define cohLab 0 "control" 1 "test"
label values cohort cohLab



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


