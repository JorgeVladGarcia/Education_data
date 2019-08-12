********************************************************************************
********************************************************************************
***               This code is property of FUNDACION ARU                     ***
********************************************************************************
********************************************************************************
***      Author1 : Vladimir Garcia 
***      Author2 : 
***      Comments: 
********************************************************************************
***      Program : 
***      Version : 01, 8/27/2018              
***      Objetive: to automate the generation of tables for variables of interest	
********************************************************************************
clear all 
global path 	"C:\Users\Vladimir\Dropbox\Aru_Fundacion\6ta_tarea_retornos_ed"
global dta	 	"C:/Users/Vladimir/Dropbox/Aru_Fundacion/6ta_tarea_retornos_ed/dta" 		

global do		"$path\do\" 
global gph 		"$path\gph\" 
global log 		"$path\log\" 
global table 	"$path\table\"
	
	
********************************************************************************
use $dta/STEPBolivia_working.dta, clear
*------------------- Non-cognitive Skills -----------------------*
* Total
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			[weight=W_FinSPwt],  stat(mean sd) save
			matrix results_total = r(StatTotal)'

* mujeres
tabstat 	extraversion_av conscientiousness_avg openness_av stability_av /*
*/			agreeableness_av grit_av hostile_av decision_av risk discount /*
*/			earnings_h/*
*/			if m1a_q02==2 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_mujeres = r(StatTotal)'

* hombres
tabstat		extraversion_av conscientiousness_avg openness_av stability_av /*
*/			agreeableness_av grit_av hostile_av decision_av risk discount /*
*/			earnings_h/*
*/			if m1a_q02==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_hombres = r(StatTotal)'

* employed
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if emp==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_employed = r(StatTotal)'

* unemployed 
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if emp==0 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_unemployed = r(StatTotal)'

*--------- generate dummy variables for educational disagregation -------------*

cap drop less_hs // includes non, prekindergarten, kindergarten and early and late primary education
gen less_hs = (m1a_q09==1 | m1a_q09==2 | m1a_q09==3 | m1a_q09==4)

cap drop high_school //includes only primary education
gen high_school = (m1a_q09==5)

cap drop some_highered //includes pre college courses and technical higher institutes
gen some_highered = (m1a_q09==6)

cap drop higher_ed // includes technical careers, bachelor's, master and phds
gen higher_ed =  (m1a_q09==7 | m1a_q09==8)
*------------------------------------------------------------------------------*

* highest educational level - less than high school
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if less_hs==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_less_hs = r(StatTotal)'
	
* highest educational level - high school (secondary)
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if high_school==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_hs = r(StatTotal)'

* highest educational level - pre college, technical higher
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if some_highered==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_some_highered = r(StatTotal)'

* highest educational level - technical career, bachelor's degree, ma + phd
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if higher_ed==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_highered = r(StatTotal)'

*------------- Generating excel table containing all information --------------*
putexcel set $path\table\noncognitive_tables_automated_formatted.xlsx, replace
	putexcel A2 = ("Variable")
	putexcel A3 = ("Extraversion_av")
	putexcel A4 = ("Conscientiousness_av")
	putexcel A5 = ("Oppenness_av")
	putexcel A6 = ("Stability_av")
	putexcel A7 = ("Agreeableness_av")
	putexcel A8 = ("Grit_av")
	putexcel A9 = ("Hostile_av")
	putexcel A10 = ("Decision_av")
	putexcel A11 = ("Risk")
	putexcel A12 = ("Discount")
	putexcel A13 = ("Earnings_h")

	putexcel B1 = ("Total")
	putexcel B2 = ("Media")
	putexcel C2 = ("D.E.")
	putexcel B3 = matrix(results_total)
		
	putexcel D1 = ("Mujeres")
	putexcel D2 = ("Media")
	putexcel E2 = ("D.E")
	putexcel D3 = matrix(results_mujeres)
		
	putexcel F1 = ("Hombres")
	putexcel F2 = ("Media")
	putexcel G2 = ("D.E")
	putexcel F3 = matrix(results_hombres)
		
	putexcel H1 = ("Employed")
	putexcel H2 = ("Media")
	putexcel I2 = ("D.E")
	putexcel H3 = matrix(results_employed)
		
	putexcel J1 = ("Unemployed")
	putexcel J2 = ("Media")
	putexcel K2 = ("D.E")
	putexcel J3 = matrix(results_unemployed)
		
	putexcel L1 = ("Less than high school")
	putexcel L2 = ("Media")
	putexcel M2 = ("D.E")
	putexcel L3 = matrix(results_less_hs)
		
	putexcel N1 = ("High school")
	putexcel N2 = ("Media")
	putexcel O2 = ("D.E")
	putexcel N3 = matrix(results_hs)
		
	putexcel P1 = ("Some Higher Education")
	putexcel P2 = ("Media")
	putexcel Q2 = ("D.E")
	putexcel P3 = matrix(results_some_highered)
		
	putexcel R1 = ("Higher Education")
	putexcel R2 = ("Media")
	putexcel S2 = ("D.E")
	putexcel R3 = matrix(results_highered)
		putexcel B3:S13 = nformat("number_d2")
		putexcel A1:A13 = halign("right")
		putexcel (A1:A13) = bold("on")
		putexcel (B1:S2) = bold("on")
file $path\table\noncognitive_tables_automated_formatted.xlsx


