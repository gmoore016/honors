//Available Income Calc
tempvar availInc
tempvar availAssets
gen `availAssets' = max(0, 0.12 * (assets - homeVal))
gen `availInc' = parInc + `availAssets'
gen efc = `availInc' / sibsInCollege

//Need
gen need = tuition - efc
//replace need = 0 if need < 0

//Cap dummies
gen atCap = 0 if !missing(need)
replace atCap = 1 if year >= 8 & need >= 5500 & !missing(need)
replace atCap = 0 if year < 8 & need >= 4500 & !missing(need)

