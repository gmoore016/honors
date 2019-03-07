use ../../NeedCalc/Output/Need.dta, clear

//General distribution of majors
graph pie, over(majType) plabel(_all percent) graphregion(color(white))
graph export ../Output/majDist.pdf, replace

//Student income distribution
hist parInc, freq graphregion(color(white)) ///
	xtitle("Parental Income in Year	of Graduation")
graph export ../Output/parIncDist.pdf, replace 

//Debt distribution
hist loan if loan, freq graphregion(color(white)) ///
	xtitle("Debt When Graduating")
graph export ../Output/loanDist.pdf, replace

//Loan vs. Time by atCap
capture graph drop loanAtCap
capture graph drop loanNotAtCap
binscatter loan intDate if atCap & !missing(atCap), name(loanAtCap) ///
	title(atCap) nodraw
binscatter loan intDate if !atCap, name(loanNotAtCap) ///
	title(!atCap) nodraw
graph combine loanAtCap loanNotAtCap, ycommon
graph export ../Output/LoanTimeCapBinscatter.pdf, replace

//Loan vs. Need by polImpact
capture graph drop loanNeedPol
capture graph drop loanNeedNotPol
binscatter loan need if polImpact & !missing(polImpact) & ///
	inrange(need, -5000, 30000), name(loanNeedPol) title(Post-Policy) nodraw
binscatter loan need if !polImpact & inrange(need, -5000, 30000), ///
	name(loanNeedNotPol) title(Pre-Policy) nodraw
graph combine loanNeedNotPol loanNeedPol, ycommon
graph export ../Output/LoanTimePolBinscatter.pdf, replace

