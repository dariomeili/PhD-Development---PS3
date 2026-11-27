
version 13
set more off
clear all

cd "C:\Users\edwar\Dropbox (MIT)\14.771_fall2021\Problem Sets 2021\ps3"

** Dataset 1

import delimited "pset_771_3_2021_d1.csv", clear

eststo clear

eststo: reg food_exp z_1, robust
	local Fstat : di %3.2f `=round(e(F),0.01)'
	estadd local Fstat = `Fstat'
	summ food_exp if z_1 == 0
	local mn : di %3.2f `=round(r(mean),0.01)'
	estadd local mn = `mn'

eststo: reg cal_int z_1, robust
	local Fstat : di %3.2f `=round(e(F),0.01)'
	estadd local Fstat = `Fstat'
	summ cal_int if z_1 == 0
	local mn : di %3.2f `=round(r(mean),0.01)'
	estadd local mn = `mn'

esttab using "data1.tex", se ar2 /// 
	scalars("N Observations"  "mn Mean Dep Var in Control" "Fstat F-stat") ///
	label keep(z_1) note(EHW robust standard errors in parentheses. Stars suppressed.) nostar ///
	mtitles("Food Exp" "Cal Intake") ///
	title(First stage of Z1 instrument) replace
	

** Dataset 2

import delimited "pset_771_3_2021_d2.csv", clear

eststo clear

eststo: reg rice_exp z_2, robust
	local Fstat : di %3.2f `=round(e(F),0.01)'
	estadd local Fstat = `Fstat'
	summ rice_exp if z_2 == 0
	local mn : di %3.2f `=round(r(mean),0.01)'
	estadd local mn = `mn'

eststo: reg cal_int z_2, robust
	local Fstat : di %3.2f `=round(e(F),0.01)'
	estadd local Fstat = `Fstat'
	summ cal_int if z_2 == 0
	local mn : di %3.2f `=round(r(mean),0.01)'
	estadd local mn = `mn'

esttab using "data2.tex", se ar2 /// 
	scalars("N Observations"  "mn Mean Dep Var in Control" "Fstat F-stat") ///
	label keep(z_2) note(EHW robust standard errors in parentheses. Stars suppressed.) nostar ///
	mtitles("Rice Exp" "Cal Intake") ///
	title(First stage of Z2 instrument) replace

* Check expenditure shares on rice and other goods	
	
gen rice_share = rice_exp/food_exp

eststo clear

eststo: reg other_food_exp z_2, robust
	local Fstat : di %3.2f `=round(e(F),0.01)'
	estadd local Fstat = `Fstat'
	summ other_food_exp if z_2 == 0
	local mn : di %3.2f `=round(r(mean),0.01)'
	estadd local mn = `mn'

eststo: reg rice_share z_2, robust
	local Fstat : di %3.2f `=round(e(F),0.01)'
	estadd local Fstat = `Fstat'
	summ rice_share if z_2 == 0
	local mn : di %3.2f `=round(r(mean),0.01)'
	estadd local mn = `mn'

esttab using "data3.tex", se ar2 /// 
	scalars("N Observations"  "mn Mean Dep Var in Control") ///
	label keep(z_2) note(EHW robust standard errors in parentheses. Stars suppressed.) nostar ///
	mtitles("Non-Rice Exp" "Rice Share") ///
	title(Effects of Z2 on expenditure patterns) replace

** Dataset 3

import delimited "pset_771_3_2021_d3.csv", clear

eststo clear

eststo: reg prod z_3, robust
	local Fstat : di %3.2f `=round(e(F),0.01)'
	estadd local Fstat = `Fstat'
	summ prod if z_3 == 0
	local mn : di %3.2f `=round(r(mean),0.01)'
	estadd local mn = `mn'

esttab using "data4.tex", se ar2 /// 
	scalars("N Observations"  "mn Mean Dep Var in Control") ///
	label keep(z_3) note(EHW robust standard errors in parentheses. Stars suppressed.) nostar ///
	mtitles("Productivity") ///
	title(ITT Estimates) replace

eststo clear

lab var cal_int "Caloric Intake"

eststo: ivreg2 prod (cal_int = z_3), robust	
	local Fstat : di %3.2f `=round(e(cdf),0.01)'
	estadd local Fstat = `Fstat'
	summ prod if z_3 == 0
	local mn : di %3.2f `=round(r(mean),0.01)'
	estadd local mn = `mn'

esttab using "data5.tex", se ar2 /// 
	scalars("N Observations"  "mn Mean Dep Var in Control" "Fstat First stage Fstat") ///
	label keep(cal_int) note(EHW robust standard errors in parentheses. Stars suppressed.) nostar ///
	mtitles("Productivity")  ///
	title(IV Estimate) replace	
	
eststo clear

eststo: reg cal_int z_3, robust 
	local Fstat : di %3.2f `=round(e(F),0.01)'
	estadd local Fstat = `Fstat'
	summ prod if z_3 == 0
	local mn : di %3.2f `=round(r(mean),0.01)'
	estadd local mn = `mn'

esttab using "data6.tex", se ar2 /// 
	scalars("N Observations"  "mn Mean Dep Var in Control" "Fstat Fstat") ///
	label keep(z_3) note(EHW robust standard errors in parentheses. Stars suppressed.) nostar ///
	mtitles("Calories")  ///
	title(First Stage) replace		

* AR test	
weakiv ivreg2 prod (cal_int = z), robust	
	
* Lee et al (2021) confidence intervals
ivreg2 prod (cal_int = z), robust 
di _b[cal_int]-1.96*_se[cal_int]*1.363
di _b[cal_int]+1.96*_se[cal_int]*1.363
	
	
	
	
	