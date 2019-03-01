capture log close
log using ../Output/master.smcl, replace

set more off

cd ../../NLSY79ParentData/Code
do ParImport

cd ../../NLSYChild79Data/Code
do Import

//Need many:one due to siblings
//Assertion guarantees all children have parental incomes
//Drop those women without children in college
merge m:1 mid year using ../../NLSY79ParentData/Output/ParData.dta, assert(match using) nogen keep(match)
//keep if parInc < 50000
cd ../../NeedCalc/Code
save ../Input/Merged.dta, replace
do NeedCalc

cd ../../Tables/Code
do tables

cd ../../Regressions/Code
do regs
