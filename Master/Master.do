capture log close
log using master.smcl, replace

set more off

cd ../NLSY79ParentData
do ParImport

tempfile parInc
save `parInc'

cd ../NLSYChild79Data
do Import

//Need many:one due to siblings
//Assertion guarantees all children have parental incomes
//Drop those women without children in college
merge m:1 mid year using `parInc', assert(match using) keep(match) nogen

//Works both with drop and without drop
//without drop is slightly stronger
drop if year == 10

//Calculates log of loans
gen lloan = ln(loan)

//Dummies for each major
gen busMaj = maj == 7
gen artMaj = maj == 15
gen eduMaj = maj == 12
gen  csMaj = maj == 17

//Add birth year as control
//Introduce second stage

//Linear estimator
reg loan year cohort parInc i.race i.sex i.region
reg lloan year cohort parInc i.race i.sex i.region 


ivprobit busMaj year i.race i.sex i.region recloan (loan = year cohort parInc i.race i.sex i.region) if !missing(recloan)

//Tobit estimator
tobit loan year cohort parInc i.race i.sex i.region if !missing(recloan), ll
//Get predicted tobit values
predict loanHat if !missing(recloan) & !missing(loan), ystar(0, .)

reg loan year cohort parInc i.race i.sex i.region


//Use fitted tobit values as an instrument
ivprobit busMaj year i.race i.sex i.region (loan = loanHat) if !missing(recloan)

probit artMaj year loanHat i.race i.sex i.region if !missing(recloan)
probit eduMaj year loanHat i.race i.sex i.region if !missing(recloan)
probit  csMaj year loanHat i.race i.sex i.region if !missing(recloan)
