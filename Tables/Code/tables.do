/*
Makes tables
*/

//Creates table in Stata window
tabulate year, sum(loan)
//Writes table to loanStats.tex
quietly tabout year using ../Output/loanStats.tex, ///
	style(tex) ///Forces tex output
	sum c(mean loan sd loan count loan) ///Marks as summary table (two-way)
	replace //Replaces previous version

//Creates table in Stata window
tabulate sex race
quietly tabout sex race using ../Output/raceStats.tex, ///
	sum c(mean recloan mean loan sd loan count loan) ///
	style(tex) replace

//Distribution of income
hist parInc, freq graphregion(color(white))
graph export ../Output/parIncHist.eps, replace
graph export ../Output/parIncHist.png, replace

//Student debt
hist loan if recloan & !missing(recloan), freq graphregion(color(white))
graph export ../Output/loanHist.eps, replace
graph export ../Output/loanHist.png, replace

//Student debt
tabulate region
quietly tabout region using ../Output/regionStats.tex, ///
	style(tex) replace 

//Major frequency
graph pie, over(majType) plabel(_all sum) graphregion(color(white))
graph export ../Output/majPie.png, replace

//Debt distribution by major
graph box loan if recloan & !missing(recloan), over(majType) graphregion(color(white))
graph export ../Output/DebtbyMajType.png, replace
graph box loan if recloan & !missing(recloan), over(majType) noout graphregion(color(white))
graph export ../Output/DebtbyMajTypeNoOut.png, replace
