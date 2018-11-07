import delimited parInc.csv, clear case(preserve)


//Code Stata missings
rename R7006500 parInc0
rename R7703700 parInc2
rename R8496100 parInc4
rename T0987800 parInc6
rename T2210000 parInc8
rename T3107800 parInc10
rename R0000100 mid


reshape long parInc, i(mid) j(year)
replace parInc = . if parInc < 0
sort mid year
