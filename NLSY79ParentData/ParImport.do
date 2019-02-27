import delimited parInc.csv, clear case(preserve)


//Names family income variables
rename R7006500 parInc0
rename R7703700 parInc2
rename R8496100 parInc4
rename T0987800 parInc6
rename T2210000 parInc8
rename T3107800 parInc10
rename T4112300 parInc12 
rename T5022600 parInc14 

rename R0000100 mid

//Names family variable assets
//Bases missing years on last recorded assets
//Top 2% of values topcoded each year by average of obscured values
rename R6940103 assets0
gen assets2 = assets0
rename R8378703 assets4
gen assets6 = assets4
rename T2142702 assets8
gen assets10 = assets8
rename T4045802 assets12
gen assets14 = assets12

keep parInc* assets* mid

reshape long parInc assets, i(mid) j(year)
replace parInc = . if parInc < 0
replace assets = . if inlist(assets, -1, -2, -3, -4, -5)
sort mid year
