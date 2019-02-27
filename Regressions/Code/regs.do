//Calculates log of loans
gen lloan = ln(loan)

//Dummies for each major
gen busMaj = maj == 7
gen artMaj = maj == 15
gen eduMaj = maj == 12
gen  csMaj = maj == 17



//Linear estimator
reg loan year cohort parInc i.race i.sex i.region
reg lloan year cohort parInc i.race i.sex i.region 


gen year2 = year * year
gen parInc2 = parInc * parInc

//First stage
tobit loan polImpact i.year fallSemester parInc parInc2 i.race i.sex i.region if !missing(recloan) & year >= 6, ll

//Get predicted tobit values
predict loanHat if !missing(recloan) & !missing(loan), ystar(0, .)


//Tobit with tailored impact
tobit loan intDate polImpact parInc i.race i.sex i.region if !missing(recloan), ll



//Creates dummies for each type of major
gen humMajType = majType == 0
gen stemMajType = majType == 1
gen ssMajType = majType == 2
gen profMajType = majType == 3
gen busMajType = majType == 4

//Use fitted tobit values as an instrument
ivprobit busMajType year i.race i.sex i.region parInc (loan = loanHat) if !missing(recloan)
ivprobit stemMajType year i.race i.sex i.region parInc (loan = loanHat) if !missing(recloan)
ivprobit ssMajType year i.race i.sex i.region parInc (loan = loanHat) if !missing(recloan)
ivprobit profMajType year i.race i.sex i.region parInc (loan = loanHat) if !missing(recloan)
ivprobit humMajType year i.race i.sex i.region parInc (loan = loanHat) if !missing(recloan)
