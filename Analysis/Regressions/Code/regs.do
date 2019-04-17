use ../Input/Need.dta, clear

/*

FIRST STAGES

*/

//Clear stored regression
eststo clear

//Linear time trend
tobit adjloan atCap##c.adjimp adjneed intDate i.fall i.race i.sex i.region if year < 14, ll vce(cluster mid)

//Dummied time trend
tobit adjloan atCap##c.adjimp adjneed i.year i.fall i.race i.sex i.region if year < 14, ll vce(cluster mid)

//How debt changes with need--increased slope after cap
//Slope steaper after policy change
eststo: tobit adjloan c.adjneed##atCap if polImpact & !missing(polImpact), ll
eststo: tobit adjloan c.adjneed##atCap if !polImpact, ll

//Triple difference model
eststo: tobit adjloan atCap##c.adjimp##c.adjneed i.year i.fall i.race i.sex i.region if year < 14, ll vce(cluster mid)
esttab using ../Output/tripdif.tex, nobaselevels booktabs style(tex) ///
	label keep(*atCap* *adjimp* *adjneed*) star(* 0.1 ** 0.05 *** 0.01) ///
	scalars(chi2) replace
test 1.atCap#c.adjimp 1.atCap#c.adjimp#c.adjneed

//Full version for appendix
esttab using ../Output/tripdiffull.tex, nobaselevels booktabs style(tex) ///
	label star(* 0.1 ** 0.05 *** 0.01) scalars(chi2) replace
	
eststo clear
//Save predicted values to use as instrument
predict adjloanHat, xb

/*

SECOND STAGES

*/

//Naive approach
reg adjincin2 adjloan adjneed year i.sex i.race i.region

//Regression of outcomes on debt using instrument
eststo clear
//Major bins
eststo: ivprobit finMaj (adjloan = adjloanHat) adjneed year i.sex i.race i.region, vce(cluster mid)
eststo: ivprobit lucMaj (adjloan = adjloanHat) adjneed year i.sex i.race i.region, vce(cluster mid)
eststo: ivprobit serveMaj (adjloan = adjloanHat) adjneed year i.sex i.race i.region, vce(cluster mid)
eststo: ivprobit humMaj (adjloan = adjloanHat) adjneed year i.sex i.race i.region, vce(cluster mid)

//Income
eststo: ivregress 2sls adjincin2 (adjloan = adjloanHat) adjneed year i.sex i.race i.region, vce(cluster mid)


esttab using ../Output/stage2.tex, nobaselevels booktabs style(tex) ///
	label keep(adj* year) star(* 0.1 ** 0.05 *** 0.01) scalars(chi2) replace
	
esttab using ../Output/stage2full.tex, nobaselevels booktabs style(tex) ///
	label star(* 0.1 ** 0.05 *** 0.01) scalars(chi2) replace

eststo clear
