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
merge m:1 mid year using `parInc', assert(match using) nogen keep(match)

//keep if parInc < 50000

cd ../NeedCalc/Code
do NeedCalc

cd ../Tables/Code
do tables

cd ../../Regressions/Code
do regs
