Investigating the Effects of Student Debt on Career Outcomes: An Empirical Approach
An Honors Paper for the Department of Economics
By Gideon Moore

This folder contains all data and code used in the creation of my honors project.

For version history, see https://github.com/gmoore016/honors.

To recreate my project from start to finish, set the working directory to Master/Code/ and run Master.do

Details on each module are available in the do file comments.
To give a brief rundown of each module, in order:

Master: calls all other modules and merges data when necessary. Saves final data file to Master/Output/.
	Log of process also generated in Master/Output/.

NLSY79ParentData: imports data from the original NLSY survey from CSV into DTA

NLSYChild79Data: imports data from NLSY79 cYA survey from CSV into DTA

InfAdj: adjusts all figures for inflation using year 2000 dollars

NeedCalc: uses the Free Application for Federal Student Aid (or FAFSA) formula to calculate
	each student's need for college, and thus their subsidized loan offer

Regressions: using the compiled data, run necessary regressions and output results using esttab

Tables: creates non-regression tables

Charts: creates charts


