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
gen adjincin2 = 100 * incin2 / cpi
gen adjloan = 100 * loan / cpi
gen adjtuit = 100 * tuition / cpi
gen adjparinc = 100 * parInc / cpi
gen adjparinc2 = adjparinc * adjparinc
gen adjimp = 100 * polImpact / cpi
gen adjassets = 100 * assets / cpi

egen midCutoff = pctile(adjincin2), p(25)
gen midClass = (adjincin2 >= midCutoff) & !missing(adjincin2)
label variable midClass "$\geq$ 25th Percentile"

egen highCutoff = pctile(adjincin2), p(90)
gen highClass = (adjincin2 >= highCutoff) & !missing(adjincin2)
label variable highClass "$\geq$ 90th Percentile"

label variable adjincin2 "Income 2 years postgrad"
label variable adjloan "Loans"
label variable adjparinc "Parental income"
label variable adjparinc2 "Parental income squared"
label variable adjimp "Extra credit available"
label variable adjassets "Parental assets"

save ../Output/adjData.dta, replace


