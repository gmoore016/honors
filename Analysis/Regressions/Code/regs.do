use ../Input/Need.dta, clear

/*

FIRST STAGES

*/

//Linear time trend
tobit adjloan atCap##c.polImpact need intDate i.fall i.race i.sex i.region if inrange(year, 8, 12), ll cluster(mid)

//Dummied time trend
tobit adjloan atCap##c.polImpact need i.year i.fall i.race i.sex i.region if inrange(year, 8, 12), ll cluster(mid)

//How debt changes with need--increased slope after cap
//Slope steaper after policy change
reg adjloan c.need##atCap if polImpact & !missing(polImpact)
reg adjloan c.need##atCap if !polImpact

//Triple difference model
tobit adjloan atCap##c.adjimp##c.adjneed i.year i.fall i.race i.sex i.region if year < 14, ll cluster(mid)

//Save predicted values to use as instrument
predict adjloanHat, xb



/*

SECOND STAGES

*/

//Naive approach
reg adjinc adjloan adjneed i.sex i.race i.region

//Regression of income on debt using instrument
ivregress 2sls adjinc (adjloan = adjloanHat) adjneed year i.sex i.race i.region, cluster(mid)

ivprobit finMaj (adjloan = adjloanHat) adjneed year i.sex i.race i.region, cluster(mid)
ivprobit lucMaj (adjloan = adjloanHat) adjneed year i.sex i.race i.region, cluster(mid)
ivprobit serveMaj (adjloan = adjloanHat) adjneed year i.sex i.race i.region, cluster(mid)
ivprobit humMaj (adjloan = adjloanHat) adjneed year i.sex i.race i.region, cluster(mid)
