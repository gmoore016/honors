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

//Compares cohort before and after shift
//on various background statistics
tabulate cohort race, row chi2
quietly tabout cohort race using ../Output/raceFit.tex, bt stats(chi2) cells(freq row) ///
	style(tex) replace
	
tabulate cohort sex, row chi2
quietly tabout cohort sex using ../Output/sexFit.tex, bt stats(chi2) cells(freq row) ///
	style(tex) replace
	
tabulate cohort region, row chi2
quietly tabout cohort region using ../Output/regionFit.tex, bt stats(chi2) cells(freq row) ///
	style(tex) replace

eststo clear
