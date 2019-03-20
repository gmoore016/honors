import delimited ../Input/parInc.csv, clear case(preserve)


//Names family income variables
rename R7006500 parInc0
rename R7703700 parInc2
rename R8496100 parInc4
rename T0987800 parInc6
rename T2210000 parInc8
rename T3107800 parInc10
rename T4112300 parInc12 
rename T5022600 parInc14 

rename R0000100 mid

//Names family variable assets
//Bases missing years on last recorded assets
//Top 2% of values topcoded each year by average of obscured values
rename R6940103 assets0
gen assets2 = assets0
rename R8378703 assets4
gen assets6 = assets4
rename T2142702 assets8
gen assets10 = assets8
rename T4045802 assets12
gen assets14 = assets12

//Names family home value
//Bases missing years on last recorded value
//Top values topcoded
rename R6944402 homeVal0
gen homeVal2 = homeVal0
rename R8379601 homeVal4
gen homeVal6 = homeVal4
rename T2143900 homeVal8
gen homeVal10 = homeVal8
rename T4047100 homeVal12
gen homeVal14 = homeVal12

//Renames marriage
rename R6917500 married0
rename R7616100 married2
rename R8324800 married4
rename T0919900 married6
rename T2084600 married8
rename T3055100 married10
rename T3986700 married12
rename T4924000 married14

//Adds birth month
replace R0410300 = . if R0410300 < 0
replace R0410100 = . if R0410100 < 0
gen parDob = ym(1900 + R0410300, R0410100)
format parDob %tm
drop R0410300 R0410100

//Adds mother's education
label define gradeLab 1 "1ST GRADE"  2 "2ND GRADE"  3 "3RD GRADE"  4 "4TH GRADE"  5 "5TH GRADE"  6 "6TH GRADE"  7 "7TH GRADE"  8 "8TH GRADE"  9 "9TH GRADE"  10 "10TH GRADE"  11 "11TH GRADE"  12 "12TH GRADE"  13 "1ST YEAR COLLEGE"  14 "2ND YEAR COLLEGE"  15 "3RD YEAR COLLEGE"  16 "4TH YEAR COLLEGE"  17 "5TH YEAR COLLEGE"  18 "6TH YEAR COLLEGE"  19 "7TH YEAR COLLEGE"  20 "8TH YEAR COLLEGE OR MORE"  95 "UNGRADED"  0 "None"
rename R6540400 momEd
replace momEd = . if momEd < 0 | momEd == 95
label values momEd gradeLab
gen momGrad = momEd >= 16 & !missing(momEd)
replace momGrad = . if missing(momEd)

keep parInc* assets* homeVal* married* mid momEd momGrad parDob

reshape long parInc assets homeVal married, i(mid) j(year)
replace parInc = . if parInc < 0
replace assets = . if inlist(assets, -1, -2, -3, -4, -5)
replace homeVal = . if homeVal < 0
replace married = . if married < 0

rename married momMarried

sort mid year

save ../Output/ParData.dta, replace
