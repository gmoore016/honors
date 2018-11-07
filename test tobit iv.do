*test_tobit_iv_method
cap log close
cd "C:\Users\gmoor\Desktop\honors"
log using test_tobit_iv_method.log, replace
clear
set seed 1234
set obs 2000000
gen x=uniform()
gen z=uniform()
gen e=rnormal()
gen debtlatent=3+4*z+ rnormal() +.8*e // adding e makes debt endogenous in the y1 model.  rnormal() adds an uncorrelated error.
gen debtpos=debtlatent>7
gen debtobs= debtpos*debtlatent

gen y1=1 + 2*debtobs + 2*x + e if debtpos==1
replace y1=1 +  2*x + e if debtpos==0

sum

* reg below is biased for debtobs
reg y1 x debtobs

reg debtobs z
predict debthat

ivreg y1 x (debtobs=z)
reg y1 x debthat   // this should be same as iv above

tobit debtobs z, ll(0)
predict debttobit

reg y1 x debttobit	// using the fitted value directly

ivreg y1 x (debtobs=debttobit)  //using the fitted value as an instrument--this is harmless's method


sum debt*
log close
