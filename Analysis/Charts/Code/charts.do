use ../../NeedCalc/Output/Need.dta, clear

set scheme s2mono

//General distribution of majors
graph pie, over(majType) plabel(_all percent) graphregion(color(white))
graph export ../Output/majDist.pdf, replace

replace adjparinc = adjparinc / 1000

//Student income distribution
hist adjparinc, freq graphregion(color(white)) ///
	xtitle("Parental Income in Year	of Graduation (Thousands of Year 2000 Dollars)")
graph export ../Output/parIncDist.pdf, replace 

replace adjloan = adjloan / 1000

//Debt distribution
hist adjloan if adjloan, freq graphregion(color(white)) ///
	xtitle("Debt When Graduating (Thousands of Year 2000 Dollars)")
graph export ../Output/loanDist.pdf, replace

//Scatter plot of need vs. loans
twoway (scatter loan need if need > 0 & polImpact == 0 & need < 10000, m(O)) ///
	(scatter loan need if need > 0 & polImpact > 0 & !missing(polImpact) & need < 10000, m(T)), ///
	xline(4500)

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
graph export ../Output/LoanNeedPolBinscatter.pdf, replace

//Need vs. Loans by cohort
twoway scatter adjloan adjneed if adjloan & !cohort & adjloan < 30 & adjneed > -50, ///
	msymbol(O) graphregion(color(white)) xtitle("Need (Thousands of Year 2000 Dollars)") ///
	ytitle("Loans (Thousands of Year 2000 Dollars") || ///
	scatter adjloan adjneed if adjloan & cohort & adjloan < 30 & adjneed > -50, ///
	msymbol(T) legend(label(1 "Year < 2007") label(2 "Year >= 2008")) xline(4.5) ///
	note("Omits those with loans > $30,000 or need < -$50,000" ///
	"Vertical line represents pre-HERA subsidized loan cap")
graph export ../Output/LoansvsNeed.pdf, replace
