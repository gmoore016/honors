//Available Income Calc
tempvar availInc availAssets grossCont
gen `availAssets' = max(0, 0.12 * (assets - homeVal))
gen `availInc' = parInc + `availAssets'

gen `grossCont' = .
replace `grossCont' = -750 if `availInc' < -3409
replace `grossCont' = .22 * `availInc' if inrange(`availInc', -3409, 13400)
replace `grossCont' = 2948 + .25 * (`availInc' - 13400) if inrange(`availInc', 13401, 16800)
replace `grossCont' = 3798 + .29 * (`availInc' - 16800) if inrange(`availInc', 16801, 20200)
replace `grossCont' = 4784 + .34 * (`availInc' - 20200) if inrange(`availInc', 20201, 23700)
replace `grossCont' = 5974 + .40 * (`availInc' - 23700) if inrange(`availInc', 23701, 27100)
replace `grossCont' = 7334 + .47 * (`availInc' - 27100) if `availInc' >= 27101

gen efc = `grossCont' / sibsInCollege

//Need
gen need = tuition - efc
//replace need = 0 if need < 0

//Cap dummies
gen atCap = 0 if !missing(need)
replace atCap = 1 if year >= 8 & need >= 5500 & !missing(need)
replace atCap = 0 if year < 8 & need >= 4500 & !missing(need)

