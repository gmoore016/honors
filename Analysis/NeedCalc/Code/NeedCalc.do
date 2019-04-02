use ../Input/Adjusted.dta, clear
//Available Income Calc




//Preliminary stats:

//Household is composed of:
//Child and mother, plus siblings, plus spouse
gen hhSize = 2 + sibs + momMarried

//Mother's age
gen mAge = floor((ym(2008, 1) - parDob) / 12)

//Imputing assets for those missing
reg assets 








//Box 1: Just parInc

//Box 2: Income Allowances
tempvar incAllowance
gen `incAllowance' = 0

//Social security allowance
replace `incAllowance' = `incAllowance' + .0765 * parInc if parInc < 94200
replace `incAllowance' = `incAllowance' + 7206.3 + 0.145 * (parInc - 94200) if parInc >= 94200



//Income protection (line 12), aka table A3
//Assumes parents are not also in college

//Household size 2
replace `incAllowance' = `incAllowance' + 15000 if hhSize == 2

//Household size 3
replace `incAllowance' = `incAllowance' + 18680 if hhSize == 3 & sibsInCollege == 0
replace `incAllowance' = `incAllowance' + 16130 if hhSize == 3 & sibsInCollege == 1

//Household size 4
replace `incAllowance' = `incAllowance' + 23070 if hhSize == 4 & sibsInCollege == 0
replace `incAllowance' = `incAllowance' + 20510 if hhSize == 4 & sibsInCollege == 1
replace `incAllowance' = `incAllowance' + 17950 if hhSize == 4 & sibsInCollege == 2

//Household size 5
replace `incAllowance' = `incAllowance' + 27220 if hhSize == 5 & sibsInCollege == 0
replace `incAllowance' = `incAllowance' + 24660	if hhSize == 5 & sibsInCollege == 1
replace `incAllowance' = `incAllowance' + 22100 if hhSize == 5 & sibsInCollege == 2
replace `incAllowance' = `incAllowance' + 19540 if hhSize == 5 & sibsInCollege == 3
replace `incAllowance' = `incAllowance' + 16980 if hhSize == 5 & sibsInCollege == 4

//Household size 6
replace `incAllowance' = `incAllowance' + 31840 if hhSize >= 6 & sibsInCollege == 0
replace `incAllowance' = `incAllowance' + 29280 if hhSize >= 6 & sibsInCollege == 1
replace `incAllowance' = `incAllowance' + 26720 if hhSize >= 6 & sibsInCollege == 2
replace `incAllowance' = `incAllowance' + 24160 if hhSize >= 6 & sibsInCollege == 3
replace `incAllowance' = `incAllowance' + 21600 if hhSize >= 6 & sibsInCollege == 4
replace `incAllowance' = `incAllowance' + 21600 - 2550 if hhSize >= 6 & sibsInCollege == 5
replace `incAllowance' = `incAllowance' + 21600 - (sibsInCollege - 6) * 2550 if hhSize >= 6 & sibsInCollege >= 6
replace `incAllowance' = `incAllowance' + (hhSize - 6) * 3590 if hhSize >= 6



//Single-parent deducation (line 13)
replace `incAllowance' = `incAllowance' + min(3200, .35 * parInc) if !momMarried & !missing(momMarried)


//Box 3
tempvar availInc
gen `availInc' = parInc - `incAllowance'


//Box 4
tempvar availAssets
gen `availAssets' = assets - homeVal
//Table A5
replace `availAssets' = . if missing(momMarried)

//Mother married
replace `availAssets' = `availAssets' - 0 if mAge <= 25 & momMarried & !missing(momMarried)
replace `availAssets' = `availAssets' - 2500 if mAge == 26 & momMarried & !missing(momMarried)
replace `availAssets' = `availAssets' - 5100 if mAge == 27 & momMarried & !missing(momMarried)
replace `availAssets' = `availAssets' - 7600 if mAge == 28 & momMarried & !missing(momMarried)
replace `availAssets' = `availAssets' - 10200 if mAge == 29 & momMarried & !missing(momMarried)
replace `availAssets' = `availAssets' - 12700 if mAge == 30 & momMarried & !missing(momMarried)
replace `availAssets' = `availAssets' - 15200 if mAge == 31 & momMarried & !missing(momMarried)
replace `availAssets' = `availAssets' - 17800 if mAge == 32 & momMarried & !missing(momMarried)
replace `availAssets' = `availAssets' - 20300 if mAge == 33 & momMarried & !missing(momMarried)
replace `availAssets' = `availAssets' - 22900 if mAge == 34 & momMarried & !missing(momMarried)
replace `availAssets' = `availAssets' - 25400 if mAge == 35 & momMarried & !missing(momMarried)
replace `availAssets' = `availAssets' - 27900 if mAge == 36 & momMarried & !missing(momMarried)
replace `availAssets' = `availAssets' - 30500 if mAge == 37 & momMarried & !missing(momMarried)
replace `availAssets' = `availAssets' - 33000 if mAge == 38 & momMarried & !missing(momMarried)
replace `availAssets' = `availAssets' - 35600 if mAge == 39 & momMarried & !missing(momMarried)
replace `availAssets' = `availAssets' - 38100 if mAge == 40 & momMarried & !missing(momMarried)
replace `availAssets' = `availAssets' - 39100 if mAge == 41 & momMarried & !missing(momMarried)
replace `availAssets' = `availAssets' - 40100 if mAge == 42 & momMarried & !missing(momMarried)
replace `availAssets' = `availAssets' - 41100 if mAge == 43 & momMarried & !missing(momMarried)
replace `availAssets' = `availAssets' - 42100 if mAge == 44 & momMarried & !missing(momMarried)
replace `availAssets' = `availAssets' - 43100 if mAge == 45 & momMarried & !missing(momMarried)
replace `availAssets' = `availAssets' - 44200 if mAge == 46 & momMarried & !missing(momMarried)
replace `availAssets' = `availAssets' - 45300 if mAge == 47 & momMarried & !missing(momMarried)
replace `availAssets' = `availAssets' - 46400 if mAge == 48 & momMarried & !missing(momMarried)
replace `availAssets' = `availAssets' - 47600 if mAge == 49 & momMarried & !missing(momMarried)
replace `availAssets' = `availAssets' - 48700 if mAge == 50 & momMarried & !missing(momMarried)
replace `availAssets' = `availAssets' - 50200 if mAge == 51 & momMarried & !missing(momMarried)
replace `availAssets' = `availAssets' - 51500 if mAge == 52 & momMarried & !missing(momMarried)
replace `availAssets' = `availAssets' - 53000 if mAge == 53 & momMarried & !missing(momMarried)
replace `availAssets' = `availAssets' - 54300 if mAge == 54 & momMarried & !missing(momMarried)
replace `availAssets' = `availAssets' - 55900 if mAge == 55 & momMarried & !missing(momMarried)
replace `availAssets' = `availAssets' - 57300 if mAge == 56 & momMarried & !missing(momMarried)
replace `availAssets' = `availAssets' - 59000 if mAge == 57 & momMarried & !missing(momMarried)
replace `availAssets' = `availAssets' - 60700 if mAge == 58 & momMarried & !missing(momMarried)
replace `availAssets' = `availAssets' - 62500 if mAge == 59 & momMarried & !missing(momMarried)
replace `availAssets' = `availAssets' - 64300 if mAge == 60 & momMarried & !missing(momMarried)
replace `availAssets' = `availAssets' - 66200 if mAge == 61 & momMarried & !missing(momMarried)
replace `availAssets' = `availAssets' - 68100 if mAge == 62 & momMarried & !missing(momMarried)
replace `availAssets' = `availAssets' - 70400 if mAge == 63 & momMarried & !missing(momMarried)
replace `availAssets' = `availAssets' - 72400 if mAge == 64 & momMarried & !missing(momMarried)
replace `availAssets' = `availAssets' - 74800 if mAge >= 65 & !missing(mAge) & momMarried & !missing(momMarried)
replace `availAssets' = . if missing(mAge)
	
//Mother unmarried
replace `availAssets' = `availAssets' - 0 if mAge <= 25 & !momMarried
replace `availAssets' = `availAssets' - 1000 if mAge == 26 & !momMarried
replace `availAssets' = `availAssets' - 2100 if mAge == 27 & !momMarried
replace `availAssets' = `availAssets' - 3100 if mAge == 28 & !momMarried
replace `availAssets' = `availAssets' - 4200 if mAge == 29 & !momMarried
replace `availAssets' = `availAssets' - 5200 if mAge == 30 & !momMarried
replace `availAssets' = `availAssets' - 6300 if mAge == 31 & !momMarried
replace `availAssets' = `availAssets' - 7300 if mAge == 32 & !momMarried
replace `availAssets' = `availAssets' - 8400 if mAge == 33 & !momMarried
replace `availAssets' = `availAssets' - 9400 if mAge == 34 & !momMarried
replace `availAssets' = `availAssets' - 10500 if mAge == 35 & !momMarried
replace `availAssets' = `availAssets' - 11500 if mAge == 36 & !momMarried
replace `availAssets' = `availAssets' - 12600 if mAge == 37 & !momMarried
replace `availAssets' = `availAssets' - 13600 if mAge == 38 & !momMarried
replace `availAssets' = `availAssets' - 14700 if mAge == 39 & !momMarried
replace `availAssets' = `availAssets' - 15700 if mAge == 40 & !momMarried
replace `availAssets' = `availAssets' - 16100 if mAge == 41 & !momMarried
replace `availAssets' = `availAssets' - 16400 if mAge == 42 & !momMarried
replace `availAssets' = `availAssets' - 16800 if mAge == 43 & !momMarried
replace `availAssets' = `availAssets' - 17200 if mAge == 44 & !momMarried
replace `availAssets' = `availAssets' - 17500 if mAge == 45 & !momMarried
replace `availAssets' = `availAssets' - 17900 if mAge == 46 & !momMarried
replace `availAssets' = `availAssets' - 18300 if mAge == 47 & !momMarried
replace `availAssets' = `availAssets' - 18800 if mAge == 48 & !momMarried
replace `availAssets' = `availAssets' - 19200 if mAge == 49 & !momMarried
replace `availAssets' = `availAssets' - 19700 if mAge == 50 & !momMarried
replace `availAssets' = `availAssets' - 20100 if mAge == 51 & !momMarried
replace `availAssets' = `availAssets' - 20500 if mAge == 52 & !momMarried
replace `availAssets' = `availAssets' - 21000 if mAge == 53 & !momMarried
replace `availAssets' = `availAssets' - 21600 if mAge == 54 & !momMarried
replace `availAssets' = `availAssets' - 22100 if mAge == 55 & !momMarried
replace `availAssets' = `availAssets' - 22700 if mAge == 56 & !momMarried
replace `availAssets' = `availAssets' - 23200 if mAge == 57 & !momMarried
replace `availAssets' = `availAssets' - 23900 if mAge == 58 & !momMarried
replace `availAssets' = `availAssets' - 24400 if mAge == 59 & !momMarried
replace `availAssets' = `availAssets' - 25100 if mAge == 60 & !momMarried
replace `availAssets' = `availAssets' - 25700 if mAge == 61 & !momMarried
replace `availAssets' = `availAssets' - 26400 if mAge == 62 & !momMarried
replace `availAssets' = `availAssets' - 27200 if mAge == 63 & !momMarried
replace `availAssets' = `availAssets' - 27900 if mAge == 64 & !momMarried
replace `availAssets' = `availAssets' - 28700 if mAge >= 65 & !missing(mAge) & !momMarried
replace `availAssets' = . if missing(mAge)

//If negative, enter zero
replace `availAssets' = max(0, 0.12 * `availAssets')


//Box 5
tempvar resources
gen `resources' = `availInc' + `availAssets'

tempvar grossCont
gen `grossCont' = .
replace `grossCont' = -750 if `resources' < -3409
replace `grossCont' = .22 * `availInc' if inrange(`resources', -3409, 13400)
replace `grossCont' = 2948 + .25 * (`resources' - 13400) if inrange(`resources', 13401, 16800)
replace `grossCont' = 3798 + .29 * (`resources' - 16800) if inrange(`resources', 16801, 20200)
replace `grossCont' = 4784 + .34 * (`resources' - 20200) if inrange(`resources', 20201, 23700)
replace `grossCont' = 5974 + .40 * (`resources' - 23700) if inrange(`resources', 23701, 27100)
replace `grossCont' = 7334 + .47 * (`resources' - 27100) if `resources' >= 27101

replace `grossCont' = max(`grossCont', 0)

gen efc = `grossCont' / sibsInCol

//If stopped at line 3
replace efc = 0 if parInc < 20000

//Need
gen need = tuition - efc
//replace need = 0 if need < 0

//Cap dummies
gen atCap = 0 if !missing(need)
replace atCap = 1 if need >= 4500 & !missing(need)

//Inflation adjust new values
gen adjefc = 100 * efc / cpi
gen adjneed = 100 * need / cpi

//Drops temp variables (somehow not automatic?)
drop __*

save ../Output/Need.dta, replace
