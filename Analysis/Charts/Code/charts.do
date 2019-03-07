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
