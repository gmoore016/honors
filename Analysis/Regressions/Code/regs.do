use ../../NeedCalc/Output/Need.dta, clear

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
