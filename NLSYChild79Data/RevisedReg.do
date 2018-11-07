do Import

preserve

drop if year == 10
gen treat = year == 8

reg loan year

//ivregress 2sls expInc (loan = year) income demographics

restore, not
