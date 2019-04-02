capture log close
log using ../Output/master.smcl, replace

set more off

args makechart

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

//Now adjust for inflation everywhere
cd ../../InfAdj/Code
save ../Input/PreAdj.dta, replace
do InfAdj

//Saves merged file as input for need calculations, then outputs file
//with completed need calcs
//Must calculate need before adjusting for inflation since FAFSA doesn't
//adjust for inflation
cd ../../NeedCalc/Code
save ../Input/Adjusted.dta, replace
do NeedCalc



cd ../../Regressions/Code
save ../Input/Need.dta, replace
do regs

/*
cd ../../Tables/Code
do tables
*/

if "`makechart'" != "-nc"{
	cd ../../Charts/Code
	do charts
}

cd ../../Master/Code
save ../Output/Master.dta, replace

log close
