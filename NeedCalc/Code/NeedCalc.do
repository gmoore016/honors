use ../Input/Merged.dta, clear
//Available Income Calc

//Preliminary stats:

//Household is composed of:
//Child and mother, plus siblings, plus spouse
gen hhSize = 2 + sibs + momMarried

//Box 1: Just parInc

//Box 2: Income Allowances
tempvar incAllowance
gen `incAllowance' = 0

//Social security allowance
replace `incAllowance' = `incAllowance' + .0765 * parInc if parInc < 94200
replace `incAllowance' = `incAllowance' + 7206.3 + 0.145 * (parInc - 94200) if parInc >= 94200

//Income protection (line 12), aka table A3
//Assumes parents are not also in college
if hhSize == 2{
	replace `incAllowance' = `incAllowance' + 15000
}
else if hhSize == 3{
	if sibsInCollege == 0{
		replace `incAllowance' = `incAllowance' + 18680
	}
	else if sibsInCollege == 1{
		replace `incAllowance' = `incAllowance' + 16130
	}
}
else if hhSize == 4{
	if sibsInCollege == 0{
		replace `incAllowance' = `incAllowance' + 23070
	}
	else if sibsInCollege == 1{
		replace `incAllowance' = `incAllowance' + 20510
	}
	else if sibsInCollege == 2{
		replace `incAllowance' = `incAllowance' + 17950
	}
}
else if hhSize == 5{
	if sibsInCollege == 0{
		replace `incAllowance' = `incAllowance' + 27220
	}
	else if sibsInCollege == 1{
		replace `incAllowance' = `incAllowance' + 24660
	}
	else if sibsInCollege == 2{
		replace `incAllowance' = `incAllowance' + 22100
	}
	else if sibsInCollege == 3{
		replace `incAllowance' = `incAllowance' + 19540
	}
	else if sibsInCollege == 4{
		replace `incAllowance' = `incAllowance' + 16980
	}
}
else if hhSize >= 6{
	if sibsInCollege == 0{
		replace `incAllowance' = `incAllowance' + 31840
	}
	else if sibsInCollege == 1{
		replace `incAllowance' = `incAllowance' + 29280
	}
	else if sibsInCollege == 2{
		replace `incAllowance' = `incAllowance' + 26720
	}
	else if sibsInCollege == 3{
		replace `incAllowance' = `incAllowance' + 24160
	}
	else if sibsInCollege == 4{
		replace `incAllowance' = `incAllowance' + 21600
	}
	else if sibsInCollege == 5{
		replace `incAllowance' = `incAllowance' + 21600 - 2550
	}
	else if sibsInCollege >= 6{
		replace `incAllowance' = 21600 - (sibsInCollege - 6) * 2550
	}
	`incAllowance' = `incAllowance' + (hhSize - 6) * 3590
}

//Single-parent deducation (line 13)
replace `incAllowance' = `incAllowance' + min(3200, .35 * parInc) if !momMarried


//Box 3
tempvar availInc
gen `availInc' = parInc - `incAllowance'


//Box 4
tempvar availAssets
gen `availAssets' = max(0, 0.12 * (assets - homeVal))


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

gen efc = `grossCont' / sibsInColl

//If stopped at line 3
replace efc = 0 if parInc < 20000

//Need
gen need = tuition - efc
//replace need = 0 if need < 0

//Cap dummies
gen atCap = 0 if !missing(need)
replace atCap = 1 if need >= 5500 & !missing(need)

save ../Output/Need.dta, replace
