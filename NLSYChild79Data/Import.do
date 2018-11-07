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

