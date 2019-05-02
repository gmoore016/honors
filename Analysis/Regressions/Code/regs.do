use ../Input/Need.dta, clear

replace adjloan = adjloan / 1000
replace adjneed = adjneed / 1000
replace adjimp = adjimp / 1000

local tabnotes "Source: author's calculations from NLSY79 CYA sample of college seniors 2000-2012" "Standard errors clustered by mother" "Dollar amounts recorded in thousands of year 2000 dollars"

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
eststo: tobit adjloan c.adjneed##atCap if !polImpact, ll
eststo: tobit adjloan c.adjneed##atCap if polImpact & !missing(polImpact), ll

//Triple difference model
eststo: tobit adjloan atCap##c.adjimp##c.adjneed i.year i.fall i.race i.sex i.region if year < 14, ll vce(cluster mid)
esttab using ../Output/tripdif.tex, nobaselevels booktabs style(tex) ///
	label keep(*atCap* *adjimp* *adjneed*) star(* 0.1 ** 0.05 *** 0.01) ///
	scalars("chi2 $\chi^2$") addn("`tabnotes'" "Loan, need, and credit in thousands of dollars" "Controls for year, semester, race, sex, and region were used, but are excluded here for space." "Extended form of these results including those coefficients is available in the appendix.") replace
test 1.atCap#c.adjimp 1.atCap#c.adjimp#c.adjneed

//Full version for appendix
esttab using ../Output/tripdiffull.tex, nobaselevels booktabs style(tex) ///
	label star(* 0.1 ** 0.05 *** 0.01) scalars("chi2 $\chi^2$") ///
	addn("`tabnotes'" "Loan, need, and credit in thousands of dollars" ) replace
	
eststo clear
//Save predicted values to use as instrument
predict adjloanHat, xb
label variable adjloanHat "Tobit Prediction of Loans"

/*

SECOND STAGES

*/

//Naive approach
eststo: probit serveMaj adjloan adjneed year i.sex i.race i.region, vce(cluster mid)
eststo: probit finMaj adjloan adjneed year i.sex i.race i.region, vce(cluster mid)
eststo: probit lucMaj adjloan adjneed year i.sex i.race i.region, vce(cluster mid)
eststo: probit humMaj adjloan adjneed year i.sex i.race i.region, vce(cluster mid)

esttab using ../Output/naive.tex, nobaselevels booktabs style(tex) ///
	label keep(adj* year) star(* 0.1 ** 0.05 *** 0.01) scalars("chi2 $\chi^2$") ///
	addn("`tabnotes'" "Major type used as dependent variable in column title" "Controls for year, sex, race, and region were used, but are excluded here for space." "Extended form of these results including those coefficients is available in the appendix.") replace
	
esttab using ../Output/naivefull.tex, nobaselevels booktabs style(tex) ///
	label star(* 0.1 ** 0.05 *** 0.01) scalars("chi2 $\chi^2$") ///
	addn("`tabnotes'" "Major type used as dependent variable in column title") replace

//Regression of outcomes on debt using instrument
eststo clear
//Major bins
eststo: ivprobit serveMaj (adjloan = adjloanHat) adjneed year i.sex i.race i.region, vce(cluster mid)
eststo: ivprobit finMaj (adjloan = adjloanHat) adjneed year i.sex i.race i.region, vce(cluster mid)
eststo: ivprobit lucMaj (adjloan = adjloanHat) adjneed year i.sex i.race i.region, vce(cluster mid)
eststo: ivprobit humMaj (adjloan = adjloanHat) adjneed year i.sex i.race i.region, vce(cluster mid)

esttab using ../Output/majChoice.tex, nobaselevels booktabs style(tex) ///
	label keep(adj* year) star(* 0.1 ** 0.05 *** 0.01) scalars("chi2 $\chi^2$") ///
	addn("`tabnotes'" "Major type used as dependent variable in column title" "Controls for year, sex, race, and region were used, but are excluded here for space." "Extended form of these results including those coefficients is available in the appendix.") replace
	
esttab using ../Output/majChoicefull.tex, nobaselevels booktabs style(tex) ///
	label star(* 0.1 ** 0.05 *** 0.01) scalars("chi2 $\chi^2$") ///
	addn("`tabnotes'" "Major type used as dependent variable in column title") replace

eststo clear
	
//Income
eststo: ivregress 2sls adjincin2 (adjloan = adjloanHat) adjneed year i.sex i.race i.region, vce(cluster mid)

eststo: ivprobit midClass (adjloan = adjloanHat) adjneed year i.sex i.race i.region, vce(cluster mid)

eststo: ivprobit highClass (adjloan = adjloanHat) adjneed year i.sex i.race i.region, vce(cluster mid)

esttab using ../Output/income.tex, nobaselevels booktabs style(tex) ///
	label keep(adj* year) star(* 0.1 ** 0.05 *** 0.01) scalars("chi2 $\chi^2$") ///
	addn("`tabnotes'" "Controls for year, sex, race, and region were used, but are excluded here for space." "Extended form of these results including those coefficients is available in the appendix.") replace
	
esttab using ../Output/incomefull.tex, nobaselevels booktabs style(tex) ///
	label star(* 0.1 ** 0.05 *** 0.01) scalars("chi2 $\chi^2$") ///
	addn("`tabnotes'") replace

eststo clear
