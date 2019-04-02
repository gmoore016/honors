use ../Input/Need.dta, clear

/*

FIRST STAGES

*/

//Linear time trend
tobit loan atCap##c.polImpact need intDate i.fall i.race i.sex i.region if inrange(year, 8, 12), ll

//Dummied time trend
tobit loan atCap##c.polImpact need i.year i.fall i.race i.sex i.region if inrange(year, 8, 12), ll

//How debt changes with need--increased slope after cap
//Slope steaper after policy change
reg loan c.need##atCap if polImpact & !missing(polImpact)
reg loan c.need##atCap if !polImpact

//Triple difference model
tobit loan atCap##c.polImpact##c.need i.year i.fall i.race i.sex i.region if inrange(year, 8, 12), ll

//Save predicted values to use as instrument
predict loanHat, xb



/*

SECOND STAGES

*/

//Naive approach
reg inc loan need i.sex i.race i.region

//Regression of income on debt using instrument
ivregress 2sls inc (loan = loanHat) need i.sex i.race i.region

//Naive approach to major bins
probit majType need i.sex i.race i.region

//Regression of major bin on debt using instrument
ivprobit majType (loan = loanHat) need i.sex i.race i.region, difficult
