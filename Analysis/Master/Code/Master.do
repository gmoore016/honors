capture log close
log using ../Output/master.smcl, replace

set more off

//Import data from parent file (NLSY 79)
cd ../../NLSY79ParentData/Code
do ParImport

//Import data from children file (NLSY 79 CYA)
cd ../../NLSYChild79Data/Code
do Import

//Need many:one due to siblings
//Assertion guarantees all children have parental incomes
//Drop those women without children in college
merge m:1 mid year using ../../NLSY79ParentData/Output/ParData.dta, assert(match using) nogen keep(match)

//Saves merged file as input for need calculations, then outputs file
//with completed need calcs
cd ../../NeedCalc/Code
save ../Input/Merged.dta, replace
do NeedCalc

cd ../../Regressions/Code
do regs

/*
cd ../../Tables/Code
do tables
*/

cd ../../Charts/Code
do charts

cd ../../Master/Code
save ../Output/Master.dta, replace
