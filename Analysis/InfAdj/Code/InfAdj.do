clear*

//Imports Chained Consumer Price Index for all Urban Consumers
freduse SUUR0000SA0

//Collapses monthly cpis into yearly average
gen year = year(daten)
collapse (mean) cpi = SUUR0000SA0, by(year)

//Reformats year to match existing data
replace year = year - 2000
keep if inrange(year, 0, 14)

//Merges with existing data
//Don't need odd numbered years, so don't keep when _merge == 1
merge 1:m year using ../Input/PreAdj.dta, keep(2 3) nogen

//Adjust variables for inflation
gen adjinc = 100 * inc / cpi
gen adjloan = 100 * loan / cpi
gen adjtuit = 100 * tuition / cpi
gen adjparinc = 100 * parInc / cpi
gen adjimp = 100 * polImpact / cpi

save ../Output/adjData.dta, replace


