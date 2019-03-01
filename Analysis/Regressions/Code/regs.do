use ../../NeedCalc/Output/Need.dta, clear

//Linear time trend
tobit loan atCap##c.polImpact need intDate i.fall i.race i.sex i.region if inrange(year, 8, 12), ll

//Dummied time trend
tobit loan atCap##c.polImpact need i.year i.fall i.race i.sex i.region if inrange(year, 8, 12), ll
