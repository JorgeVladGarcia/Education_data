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
***      Objetive: 	to automate the generation of tables for variables of 	 ***
***					interest noncognitive skills							 ***
********************************************************************************
clear all 
global path 	"C:\Users\Vladimir\Dropbox\Aru_Fundacion\6ta_tarea_retornos_ed"
global dta	 	"C:/Users/Vladimir/Dropbox/Aru_Fundacion/6ta_tarea_retornos_ed/dta" 		

global do		"$path\do\" 
global gph 		"$path\gph\" 
global log 		"$path\log\" 
global table 	"$path\table\disaggregation\"
	
********************************************************************************
use $dta/STEPBolivia_working.dta, clear
********************************************************************************

*-------------------------- Non-cognitive Skills ------------------------------*
								
								*** Total ***
* Total
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			[weight=W_FinSPwt],  stat(mean sd) save
			matrix results_total = r(StatTotal)'

* Mujeres
tabstat 	extraversion_av conscientiousness_avg openness_av stability_av /*
*/			agreeableness_av grit_av hostile_av decision_av risk discount /*
*/			earnings_h/*
*/			if m1a_q02==2 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_mujeres = r(StatTotal)'

* Hombres
tabstat		extraversion_av conscientiousness_avg openness_av stability_av /*
*/			agreeableness_av grit_av hostile_av decision_av risk discount /*
*/			earnings_h/*
*/			if m1a_q02==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_hombres = r(StatTotal)'

* Employed
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if emp==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_employed = r(StatTotal)'

* Unemployed 
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if emp==0 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_unemployed = r(StatTotal)'

* Formal
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if informal==0 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_formal = r(StatTotal)'

* Informal
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if informal==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_informal = r(StatTotal)'
			
* Generating excel table containing all information ***
putexcel set $path\table\disaggregation\noncognitive_tables_1_total.xlsx, replace
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
	putexcel E2 = ("D.E.")
	putexcel D3 = matrix(results_mujeres)
		
	putexcel F1 = ("Hombres")
	putexcel F2 = ("Media")
	putexcel G2 = ("D.E.")
	putexcel F3 = matrix(results_hombres)
		
	putexcel H1 = ("Employed")
	putexcel H2 = ("Media")
	putexcel I2 = ("D.E.")
	putexcel H3 = matrix(results_employed)
		
	putexcel J1 = ("Unemployed")
	putexcel J2 = ("Media")
	putexcel K2 = ("D.E.")
	putexcel J3 = matrix(results_unemployed)
	
	putexcel L1 = ("Formal")
	putexcel L2 = ("Media")
	putexcel M2 = ("D.E.")
	putexcel L3 = matrix(results_formal)
	
	putexcel N1 = ("Informal")
	putexcel N2 = ("Media")
	putexcel O2 = ("D.E.")
	putexcel N3 = matrix(results_informal)
	
		putexcel B3:S13 = nformat("number_d2")
		putexcel A1:A13 = halign("right")
		putexcel (A1:A13) = bold("on")
		putexcel (B1:S2) = bold("on")
file $path\table\disaggregation\noncognitive_tables_1_total.xlsx	
		
*--------- generate dummy variables for educational disaggregation -------------*
cap drop primaria
gen primaria = (years_educ<=6)

cap drop secundaria
gen secundaria = (years_educ>6 & years_educ<=12)

cap drop tecnic
gen tecnic = (years_educ>12 & years_educ<=15)

cap drop tecnic_normal
gen tecnic_normal = (years_educ==16)

cap drop licen
gen licen = (years_educ==17)

cap drop post_grad
gen post_grad = (years_educ>=17)
*----------------------------- recoding m1a_q09n ------------------------------*
* replace m1a_q09n=1 if (m1a_q09n=
* m1a_q09n es raro por que en tab salen unos resultados pero el spreadsheet y el codebook tienen diferentes
*------------------------------------------------------------------------------*

						*** primaria ***
* Total 
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if primaria==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_primaria = r(StatTotal)'

* Mujeres
tabstat 	extraversion_av conscientiousness_avg openness_av stability_av /*
*/			agreeableness_av grit_av hostile_av decision_av risk discount /*
*/			earnings_h/*
*/			if m1a_q02==2 & primaria==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_primaria_mujeres = r(StatTotal)'

* Hombres
tabstat 	extraversion_av conscientiousness_avg openness_av stability_av /*
*/			agreeableness_av grit_av hostile_av decision_av risk discount /*
*/			earnings_h/*
*/			if m1a_q02==1 & primaria==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_primaria_hombres = r(StatTotal)'

* Employed
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if primaria==1 & emp==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_primaria_employed = r(StatTotal)'

* Unemployed
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if primaria==1 & emp==0 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_primaria_unemployed = r(StatTotal)'

* Formal
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if primaria==1 & informal==0 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_primaria_formal = r(StatTotal)'

* Informal
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if primaria==1 & informal==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_primaria_informal = r(StatTotal)'

			*** Generating excel table containing all information ***
putexcel set $path\table\disaggregation\noncognitive_tables_2_primaria.xlsx, replace
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
	putexcel B3 = matrix(results_primaria)
		
	putexcel D1 = ("Mujeres")
	putexcel D2 = ("Media")
	putexcel E2 = ("D.E.")
	putexcel D3 = matrix(results_primaria_mujeres)
		
	putexcel F1 = ("Hombres")
	putexcel F2 = ("Media")
	putexcel G2 = ("D.E.")
	putexcel F3 = matrix(results_primaria_hombres)
		
	putexcel H1 = ("Employed")
	putexcel H2 = ("Media")
	putexcel I2 = ("D.E.")
	putexcel H3 = matrix(results_primaria_employed)
		
	putexcel J1 = ("Unemployed")
	putexcel J2 = ("Media")
	putexcel K2 = ("D.E.")
	putexcel J3 = matrix(results_primaria_unemployed)
	
	putexcel L1 = ("Formal")
	putexcel L2 = ("Media")
	putexcel M2 = ("D.E.")
	putexcel L3 = matrix(results_primaria_formal)
	
	putexcel N1 = ("Informal")
	putexcel N2 = ("Media")
	putexcel O2 = ("D.E.")
	putexcel N3 = matrix(results_primaria_informal)
	
		putexcel B3:S13 = nformat("number_d2")
		putexcel A1:A13 = halign("right")
		putexcel (A1:A13) = bold("on")
		putexcel (B1:S2) = bold("on")
file $path\table\disaggregation\noncognitive_tables_2_primaria.xlsx	
		
							*** secundaria ***
* Total							
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if secundaria==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_secundaria = r(StatTotal)'
* Mujeres
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if m1a_q02==2 & secundaria==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_secundaria_mujeres = r(StatTotal)'
* Hombres
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if m1a_q02==1 & secundaria==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_secundaria_hombres = r(StatTotal)'

* Employed 
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if emp==1 & secundaria==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_secundaria_employed = r(StatTotal)'

* Unemployed
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if emp==0 & secundaria==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_secundaria_unemployed = r(StatTotal)'
* Formal
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if secundaria==1 & informal==0 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_secundaria_formal = r(StatTotal)'
* Informal
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if secundaria==1 & informal==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_secundaria_informal = r(StatTotal)'

* Generating excel table containing all information
putexcel set $path\table\disaggregation\noncognitive_tables_3_secundaria.xlsx, replace
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
	putexcel B3 = matrix(results_secundaria)
		
	putexcel D1 = ("Mujeres")
	putexcel D2 = ("Media")
	putexcel E2 = ("D.E.")
	putexcel D3 = matrix(results_secundaria_mujeres)
		
	putexcel F1 = ("Hombres")
	putexcel F2 = ("Media")
	putexcel G2 = ("D.E.")
	putexcel F3 = matrix(results_secundaria_hombres)
		
	putexcel H1 = ("Employed")
	putexcel H2 = ("Media")
	putexcel I2 = ("D.E.")
	putexcel H3 = matrix(results_secundaria_employed)
		
	putexcel J1 = ("Unemployed")
	putexcel J2 = ("Media")
	putexcel K2 = ("D.E.")
	putexcel J3 = matrix(results_secundaria_unemployed)
	
	putexcel L1 = ("Formal")
	putexcel L2 = ("Media")
	putexcel M2 = ("D.E.")
	putexcel L3 = matrix(results_secundaria_formal)
	
	putexcel N1 = ("Informal")
	putexcel N2 = ("Media")
	putexcel O2 = ("D.E.")
	putexcel N3 = matrix(results_secundaria_informal)
	
		putexcel B3:S13 = nformat("number_d2")
		putexcel A1:A13 = halign("right")
		putexcel (A1:A13) = bold("on")
		putexcel (B1:S2) = bold("on")
file $path\table\disaggregation\noncognitive_tables_3_secundaria.xlsx	
	
						*** tecnic ***
* Total						
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if tecnic==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_tecnic = r(StatTotal)'
* Mujeres
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if m1a_q02==2 & tecnic==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_tecnic_mujeres = r(StatTotal)'

* Hombres
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if m1a_q02==1 & tecnic==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_tecnic_hombres = r(StatTotal)'

* Employed
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if emp==1 & tecnic==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_tecnic_employed = r(StatTotal)'

* Unemployed
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if emp==0 & tecnic==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_tecnic_unemployed = r(StatTotal)'

* Formal
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if informal==0 & tecnic==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_tecnic_formal = r(StatTotal)'
* Informal
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if informal==1 & tecnic==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_tecnic_informal = r(StatTotal)'

* Generating excel table containing all information
putexcel set $path\table\disaggregation\noncognitive_tables_4_tecnic.xlsx, replace
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
	putexcel B3 = matrix(results_tecnic)
		
	putexcel D1 = ("Mujeres")
	putexcel D2 = ("Media")
	putexcel E2 = ("D.E.")
	putexcel D3 = matrix(results_tecnic_mujeres)
		
	putexcel F1 = ("Hombres")
	putexcel F2 = ("Media")
	putexcel G2 = ("D.E.")
	putexcel F3 = matrix(results_tecnic_hombres)
		
	putexcel H1 = ("Employed")
	putexcel H2 = ("Media")
	putexcel I2 = ("D.E.")
	putexcel H3 = matrix(results_tecnic_employed)
		
	putexcel J1 = ("Unemployed")
	putexcel J2 = ("Media")
	putexcel K2 = ("D.E.")
	putexcel J3 = matrix(results_tecnic_unemployed)
	
	putexcel L1 = ("Formal")
	putexcel L2 = ("Media")
	putexcel M2 = ("D.E.")
	putexcel L3 = matrix(results_tecnic_formal)
	
	putexcel N1 = ("Informal")
	putexcel N2 = ("Media")
	putexcel O2 = ("D.E.")
	putexcel N3 = matrix(results_tecnic_informal)
	
		putexcel B3:S13 = nformat("number_d2")
		putexcel A1:A13 = halign("right")
		putexcel (A1:A13) = bold("on")
		putexcel (B1:S2) = bold("on")
file $path\table\disaggregation\noncognitive_tables_4_tecnic.xlsx	
						
						*** tecnic_normal ***
* Total
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if tecnic_normal==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_tecnic_normal = r(StatTotal)'
* Mujeres
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if  m1a_q02==2 & tecnic_normal==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_tecnic_normal_mujeres = r(StatTotal)'
* Hombres
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if  m1a_q02==1 & tecnic_normal==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_tecnic_normal_hombres = r(StatTotal)'
* Employed
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if  emp==1 & tecnic_normal==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_tecnic_normal_employed = r(StatTotal)'

* Unemployed
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if  emp==0 & tecnic_normal==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_tecnic_normal_unemployed = r(StatTotal)'
* Formal
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if  informal==0 & tecnic_normal==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_tecnic_normal_formal = r(StatTotal)'

* Informal
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if  informal==1 & tecnic_normal==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_tecnic_normal_informal = r(StatTotal)'

* Generating excel table containing all information
putexcel set $path\table\disaggregation\noncognitive_tables_5_tecnic_normal.xlsx, replace
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
	putexcel B3 = matrix(results_tecnic_normal)
		
	putexcel D1 = ("Mujeres")
	putexcel D2 = ("Media")
	putexcel E2 = ("D.E.")
	putexcel D3 = matrix(results_tecnic_normal_mujeres)
		
	putexcel F1 = ("Hombres")
	putexcel F2 = ("Media")
	putexcel G2 = ("D.E.")
	putexcel F3 = matrix(results_tecnic_normal_hombres)
		
	putexcel H1 = ("Employed")
	putexcel H2 = ("Media")
	putexcel I2 = ("D.E.")
	putexcel H3 = matrix(results_tecnic_normal_employed)
		
	putexcel J1 = ("Unemployed")
	putexcel J2 = ("Media")
	putexcel K2 = ("D.E.")
	putexcel J3 = matrix(results_tecnic_normal_unemployed)
	
	putexcel L1 = ("Formal")
	putexcel L2 = ("Media")
	putexcel M2 = ("D.E.")
	putexcel L3 = matrix(results_tecnic_normal_formal)
	
	putexcel N1 = ("Informal")
	putexcel N2 = ("Media")
	putexcel O2 = ("D.E.")
	putexcel N3 = matrix(results_tecnic_normal_informal)
	
		putexcel B3:S13 = nformat("number_d2")
		putexcel A1:A13 = halign("right")
		putexcel (A1:A13) = bold("on")
		putexcel (B1:S2) = bold("on")
file $path\table\disaggregation\noncognitive_tables_5_tecnic_normal.xlsx
							
							*** licenciatura ***
* Total
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if licen==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_licen=r(StatTotal)'
* Mujeres
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if  m1a_q02==2 & licen==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_licen_mujeres = r(StatTotal)'
* Hombres
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if  m1a_q02==1 & licen==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_licen_hombres = r(StatTotal)'
* Employed
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if  emp==1 & licen==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_licen_employed = r(StatTotal)'
* Unemployed
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if  emp==0 & licen==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_licen_unemployed = r(StatTotal)'
* Formal
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if  informal==0 & licen==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_licen_formal = r(StatTotal)'
* Informal
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if  informal==1 & licen==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_licen_informal = r(StatTotal)'

* Generating excel table containing all information
putexcel set $path\table\disaggregation\noncognitive_tables_6_licen.xlsx, replace
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
	putexcel B3 = matrix(results_licen)
		
	putexcel D1 = ("Mujeres")
	putexcel D2 = ("Media")
	putexcel E2 = ("D.E.")
	putexcel D3 = matrix(results_licen_mujeres)
		
	putexcel F1 = ("Hombres")
	putexcel F2 = ("Media")
	putexcel G2 = ("D.E.")
	putexcel F3 = matrix(results_licen_hombres)
		
	putexcel H1 = ("Employed")
	putexcel H2 = ("Media")
	putexcel I2 = ("D.E.")
	putexcel H3 = matrix(results_licen_employed)
		
	putexcel J1 = ("Unemployed")
	putexcel J2 = ("Media")
	putexcel K2 = ("D.E.")
	putexcel J3 = matrix(results_licen_unemployed)
	
	putexcel L1 = ("Formal")
	putexcel L2 = ("Media")
	putexcel M2 = ("D.E.")
	putexcel L3 = matrix(results_licen_formal)
	
	putexcel N1 = ("Informal")
	putexcel N2 = ("Media")
	putexcel O2 = ("D.E.")
	putexcel N3 = matrix(results_licen_informal)
	
		putexcel B3:S13 = nformat("number_d2")
		putexcel A1:A13 = halign("right")
		putexcel (A1:A13) = bold("on")
		putexcel (B1:S2) = bold("on")
file $path\table\disaggregation\noncognitive_tables_6_licen.xlsx

								*** post_grad ***
* Total
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if post_grad==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_post_grad = r(StatTotal)'
* Mujeres
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if  m1a_q02==2 & post_grad==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_post_grad_mujeres = r(StatTotal)'
* Hombres
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if  m1a_q02==1 & post_grad==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_post_grad_hombres = r(StatTotal)'
* Employed
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if  emp==1 & tecnic_normal==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_post_grad_employed = r(StatTotal)'

* Unemployed
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if  emp==0 & post_grad==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_post_grad_unemployed = r(StatTotal)'
* Formal
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if  informal==0 & post_grad==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_post_grad_formal = r(StatTotal)'

* Informal
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if  informal==1 & post_grad==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_post_grad_informal = r(StatTotal)'

* Generating excel table containing all information
putexcel set $path\table\disaggregation\noncognitive_tables_7_post_grad.xlsx, replace
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
	putexcel B3 = matrix(results_post_grad)
		
	putexcel D1 = ("Mujeres")
	putexcel D2 = ("Media")
	putexcel E2 = ("D.E.")
	putexcel D3 = matrix(results_post_grad_mujeres)
		
	putexcel F1 = ("Hombres")
	putexcel F2 = ("Media")
	putexcel G2 = ("D.E.")
	putexcel F3 = matrix(results_post_grad_hombres)
		
	putexcel H1 = ("Employed")
	putexcel H2 = ("Media")
	putexcel I2 = ("D.E.")
	putexcel H3 = matrix(results_post_grad_employed)
		
	putexcel J1 = ("Unemployed")
	putexcel J2 = ("Media")
	putexcel K2 = ("D.E.")
	putexcel J3 = matrix(results_post_grad_unemployed)
	
	putexcel L1 = ("Formal")
	putexcel L2 = ("Media")
	putexcel M2 = ("D.E.")
	putexcel L3 = matrix(results_post_grad_formal)
	
	putexcel N1 = ("Informal")
	putexcel N2 = ("Media")
	putexcel O2 = ("D.E.")
	putexcel N3 = matrix(results_post_grad_informal)
	
		putexcel B3:S13 = nformat("number_d2")
		putexcel A1:A13 = halign("right")
		putexcel (A1:A13) = bold("on")
		putexcel (B1:S2) = bold("on")
file $path\table\disaggregation\noncognitive_tables_7_post_grad.xlsx

*------------- generate dummy variables for age disagregation -----------------*
* age 15 - 25: Early adulthood
cap drop early_adult
gen early_adult = (m1a_q04 <= 25)
* age 26 - 35: adulthood
cap drop adult
gen adult = (m1a_q04>=26 & m1a_q04<=35)
* age 36 - 45: late adulthood
cap drop late_adult
gen late_adult = (m1a_q04>=36 & m1a_q04<=45)
* age 46 - 60: early senior
cap drop early_senior
gen early_senior = (m1a_q04>=46 & m1a_q04<=60)
* age 60+ : senior
cap drop senior
gen senior = (m1a_q04>=60)
*------------------------------------------------------------------------------*
						
						*** early adulthood ***
* Total
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if early_adult==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_early_adult = r(StatTotal)'

* Mujeres
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if m1a_q02==2 & early_adult==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_early_adult_mujeres = r(StatTotal)'

* Hombres
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if m1a_q02==1 & early_adult==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_early_adult_hombres = r(StatTotal)'

* Employed
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if emp==1 & early_adult==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_early_adult_employed = r(StatTotal)'

* Unemployed
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if emp==0 & early_adult==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_early_adult_unemployed = r(StatTotal)'			
* Formal
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if informal==0 & early_adult==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_early_adult_formal = r(StatTotal)'
* Informal
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if informal==1 & early_adult==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_early_adult_informal = r(StatTotal)'


* Generating excel table containing all information
putexcel set $path\table\disaggregation\noncognitive_tables_8_early_adult.xlsx, replace
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
	putexcel B3 = matrix(results_early_adult)
		
	putexcel D1 = ("Mujeres")
	putexcel D2 = ("Media")
	putexcel E2 = ("D.E.")
	putexcel D3 = matrix(results_early_adult_mujeres)
		
	putexcel F1 = ("Hombres")
	putexcel F2 = ("Media")
	putexcel G2 = ("D.E.")
	putexcel F3 = matrix(results_early_adult_hombres)
		
	putexcel H1 = ("Employed")
	putexcel H2 = ("Media")
	putexcel I2 = ("D.E.")
	putexcel H3 = matrix(results_early_adult_employed)
		
	putexcel J1 = ("Unemployed")
	putexcel J2 = ("Media")
	putexcel K2 = ("D.E.")
	putexcel J3 = matrix(results_early_adult_unemployed)
	
	putexcel L1 = ("Formal")
	putexcel L2 = ("Media")
	putexcel M2 = ("D.E.")
	putexcel L3 = matrix(results_early_adult_formal)
	
	putexcel N1 = ("Informal")
	putexcel N2 = ("Media")
	putexcel O2 = ("D.E.")
	putexcel N3 = matrix(results_early_adult_informal)
	
		putexcel B3:S13 = nformat("number_d2")
		putexcel A1:A13 = halign("right")
		putexcel (A1:A13) = bold("on")
		putexcel (B1:S2) = bold("on")
file $path\table\disaggregation\noncognitive_tables_8_early_adult.xlsx	
							
							*** adulthood ***
* Total
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if adult==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_adult = r(StatTotal)'

* Mujeres
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if m1a_q02==2 & adult==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_adult_mujeres = r(StatTotal)'

* Hombres
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if m1a_q02==1 & adult==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_adult_hombres = r(StatTotal)'

* Employed
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if emp==1 & adult==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_adult_employed = r(StatTotal)'

* Unemployed
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if emp==0 & adult==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_adult_unemployed = r(StatTotal)'
* Formal
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if informal==0 & adult==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_adult_informal = r(StatTotal)'
* Informal
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if informal==1 & adult==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_adult_formal = r(StatTotal)'
			
* Generating excel table containing all information
putexcel set $path\table\disaggregation\noncognitive_tables_9_adult.xlsx, replace
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
	putexcel B3 = matrix(results_adult)
		
	putexcel D1 = ("Mujeres")
	putexcel D2 = ("Media")
	putexcel E2 = ("D.E.")
	putexcel D3 = matrix(results_adult_mujeres)
		
	putexcel F1 = ("Hombres")
	putexcel F2 = ("Media")
	putexcel G2 = ("D.E.")
	putexcel F3 = matrix(results_adult_hombres)
		
	putexcel H1 = ("Employed")
	putexcel H2 = ("Media")
	putexcel I2 = ("D.E.")
	putexcel H3 = matrix(results_adult_employed)
		
	putexcel J1 = ("Unemployed")
	putexcel J2 = ("Media")
	putexcel K2 = ("D.E.")
	putexcel J3 = matrix(results_adult_unemployed)
	
	putexcel L1 = ("Formal")
	putexcel L2 = ("Media")
	putexcel M2 = ("D.E.")
	putexcel L3 = matrix(results_adult_formal)
	
	putexcel N1 = ("Informal")
	putexcel N2 = ("Media")
	putexcel O2 = ("D.E.")
	putexcel N3 = matrix(results_adult_informal)
	
		putexcel B3:S13 = nformat("number_d2")
		putexcel A1:A13 = halign("right")
		putexcel (A1:A13) = bold("on")
		putexcel (B1:S2) = bold("on")
file $path\table\disaggregation\noncognitive_tables_9_adult.xlsx	
						
						*** late adulthood ***
* Total
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if late_adult==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_late_adult = r(StatTotal)'

* Mujeres
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if m1a_q02==2 & late_adult==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_late_adult_mujeres = r(StatTotal)'

* Hombres
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if m1a_q02==1 & late_adult==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_late_adult_hombres = r(StatTotal)'

* Employed
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if emp==1 & adult==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_late_adult_employed = r(StatTotal)'

* Unemployed
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if emp==0 & adult==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_late_adult_unemployed = r(StatTotal)'
* Formal
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if informal==0 & adult==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_late_adult_formal = r(StatTotal)'
* Informal
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if informal==1 & adult==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_late_adult_informal = r(StatTotal)'
			
* Generating excel table containing all information
putexcel set $path\table\disaggregation\noncognitive_tables_10_late_adult.xlsx, replace
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
	putexcel B3 = matrix(results_late_adult)
		
	putexcel D1 = ("Mujeres")
	putexcel D2 = ("Media")
	putexcel E2 = ("D.E.")
	putexcel D3 = matrix(results_late_adult_mujeres)
		
	putexcel F1 = ("Hombres")
	putexcel F2 = ("Media")
	putexcel G2 = ("D.E.")
	putexcel F3 = matrix(results_late_adult_hombres)
		
	putexcel H1 = ("Employed")
	putexcel H2 = ("Media")
	putexcel I2 = ("D.E.")
	putexcel H3 = matrix(results_late_adult_employed)
		
	putexcel J1 = ("Unemployed")
	putexcel J2 = ("Media")
	putexcel K2 = ("D.E.")
	putexcel J3 = matrix(results_late_adult_unemployed)
	
	putexcel L1 = ("Formal")
	putexcel L2 = ("Media")
	putexcel M2 = ("D.E.")
	putexcel L3 = matrix(results_late_adult_formal)
	
	putexcel N1 = ("Informal")
	putexcel N2 = ("Media")
	putexcel O2 = ("D.E.")
	putexcel N3 = matrix(results_late_adult_informal)
	
		putexcel B3:S13 = nformat("number_d2")
		putexcel A1:A13 = halign("right")
		putexcel (A1:A13) = bold("on")
		putexcel (B1:S2) = bold("on")
file $path\table\disaggregation\noncognitive_tables_10_late_adult.xlsx	
							
							*** early senior ***
* Total
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if early_senior==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_early_senior = r(StatTotal)'

* Mujeres
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if m1a_q02==2 & early_senior==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_early_senior_mujeres = r(StatTotal)'

* Hombres
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if m1a_q02==1 & early_senior==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_early_senior_hombres = r(StatTotal)'

* Employed
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if emp==1 & early_senior==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_early_senior_employed = r(StatTotal)'

* Unemployed
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if emp==0 & early_senior==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_early_senior_unemployed = r(StatTotal)'
* Formal
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if informal==0 & early_senior==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_early_senior_informal = r(StatTotal)'
* Informal
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if informal==1 & early_senior==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_early_senior_formal = r(StatTotal)'
			
* Generating excel table containing all information
putexcel set $path\table\disaggregation\noncognitive_tables_11_early_senior.xlsx, replace
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
	putexcel B3 = matrix(results_early_senior)
		
	putexcel D1 = ("Mujeres")
	putexcel D2 = ("Media")
	putexcel E2 = ("D.E.")
	putexcel D3 = matrix(results_early_senior_mujeres)
		
	putexcel F1 = ("Hombres")
	putexcel F2 = ("Media")
	putexcel G2 = ("D.E.")
	putexcel F3 = matrix(results_early_senior_hombres)
		
	putexcel H1 = ("Employed")
	putexcel H2 = ("Media")
	putexcel I2 = ("D.E.")
	putexcel H3 = matrix(results_early_senior_employed)
		
	putexcel J1 = ("Unemployed")
	putexcel J2 = ("Media")
	putexcel K2 = ("D.E.")
	putexcel J3 = matrix(results_early_senior_unemployed)
	
	putexcel L1 = ("Formal")
	putexcel L2 = ("Media")
	putexcel M2 = ("D.E.")
	putexcel L3 = matrix(results_early_senior_formal)
	
	putexcel N1 = ("Informal")
	putexcel N2 = ("Media")
	putexcel O2 = ("D.E.")
	putexcel N3 = matrix(results_early_senior_informal)
	
		putexcel B3:S13 = nformat("number_d2")
		putexcel A1:A13 = halign("right")
		putexcel (A1:A13) = bold("on")
		putexcel (B1:S2) = bold("on")
file $path\table\disaggregation\noncognitive_tables_11_early_senior.xlsx	

							*** senior ***
* Total
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if senior==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_senior = r(StatTotal)'

* Mujeres
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if m1a_q02==2 & senior==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_senior_mujeres = r(StatTotal)'

* Hombres
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if m1a_q02==1 & senior==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_senior_hombres = r(StatTotal)'

* Employed
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if emp==1 & senior==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_senior_employed = r(StatTotal)'

* Unemployed
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if emp==0 & senior==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_senior_unemployed = r(StatTotal)'
* Formal
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if informal==0 & senior==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_senior_formal = r(StatTotal)'
* Informal
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if informal==1 & senior==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_senior_informal = r(StatTotal)'

* Generating excel table containing all information
putexcel set $path\table\disaggregation\noncognitive_tables_12_senior.xlsx, replace
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
	putexcel B3 = matrix(results_senior)
		
	putexcel D1 = ("Mujeres")
	putexcel D2 = ("Media")
	putexcel E2 = ("D.E.")
	putexcel D3 = matrix(results_senior_mujeres)
		
	putexcel F1 = ("Hombres")
	putexcel F2 = ("Media")
	putexcel G2 = ("D.E.")
	putexcel F3 = matrix(results_senior_hombres)
		
	putexcel H1 = ("Employed")
	putexcel H2 = ("Media")
	putexcel I2 = ("D.E.")
	putexcel H3 = matrix(results_senior_employed)
		
	putexcel J1 = ("Unemployed")
	putexcel J2 = ("Media")
	putexcel K2 = ("D.E.")
	putexcel J3 = matrix(results_senior_unemployed)
	
	putexcel L1 = ("Formal")
	putexcel L2 = ("Media")
	putexcel M2 = ("D.E.")
	putexcel L3 = matrix(results_senior_formal)
	
	putexcel N1 = ("Informal")
	putexcel N2 = ("Media")
	putexcel O2 = ("D.E.")
	putexcel N3 = matrix(results_senior_informal)
	
		putexcel B3:S13 = nformat("number_d2")
		putexcel A1:A13 = halign("right")
		putexcel (A1:A13) = bold("on")
		putexcel (B1:S2) = bold("on")
file $path\table\disaggregation\noncognitive_tables_12_senior.xlsx	


//////////////////// WE ARE DONE HERE ///////////////////////
							*** late senior ***
* Total
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if late_senior==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_late_senior = r(StatTotal)'

* Mujeres
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if m1a_q02==2 & late_senior==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_late_senior_mujeres = r(StatTotal)'

* Hombres
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if m1a_q02==1 & late_senior==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_late_senior_hombres = r(StatTotal)'

* Employed
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if emp==1 & late_senior==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_late_senior_employed = r(StatTotal)'

* Unemployed
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if emp==0 & late_senior==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_late_senior_unemployed = r(StatTotal)'
* Formal
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if informal==0 & late_senior==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_late_senior_formal = r(StatTotal)'
* Informal
tabstat		extraversion_av conscientiousness_avg openness_av stability_av/*
*/			agreeableness_av grit_av hostile_av decision_av risk discount/*
*/			earnings_h/*
*/			if informal==0 & late_senior==1 [weight=W_FinSPwt],  stat(mean sd) save
			matrix results_late_senior_informal = r(StatTotal)'
* Generating excel table containing all information
putexcel set $path\table\disaggregation\noncognitive_tables_late_senior.xlsx, replace
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
	putexcel B3 = matrix(results_late_senior)
		
	putexcel D1 = ("Mujeres")
	putexcel D2 = ("Media")
	putexcel E2 = ("D.E.")
	putexcel D3 = matrix(results_late_senior_mujeres)
		
	putexcel F1 = ("Hombres")
	putexcel F2 = ("Media")
	putexcel G2 = ("D.E.")
	putexcel F3 = matrix(results_late_senior_hombres)
		
	putexcel H1 = ("Employed")
	putexcel H2 = ("Media")
	putexcel I2 = ("D.E.")
	putexcel H3 = matrix(results_late_senior_employed)
		
	putexcel J1 = ("Unemployed")
	putexcel J2 = ("Media")
	putexcel K2 = ("D.E.")
	putexcel J3 = matrix(results_late_senior_unemployed)
	
	putexcel L1 = ("Formal")
	putexcel L2 = ("Media")
	putexcel M2 = ("D.E.")
	putexcel L3 = matrix(results_late_senior_formal)
	
	putexcel N1 = ("Informal")
	putexcel N2 = ("Media")
	putexcel O2 = ("D.E.")
	putexcel N3 = matrix(results_late_senior_informal)
	
		putexcel B3:S13 = nformat("number_d2")
		putexcel A1:A13 = halign("right")
		putexcel (A1:A13) = bold("on")
		putexcel (B1:S2) = bold("on")
file $path\table\disaggregation\noncognitive_tables_late_senior.xlsx	

*///////////
*/ variables del entorno del hogar: educaion del padre, numero de ninos menores a 12 anos, 
/* 
electricidad ->  m1b_q12 
electricity yes (if coming from a power grid) == 2,3
electricity no (if not coming from a pwoer grid) == 4, 8, 19

agua: distribucion por red publica o no -->  m1b_q08
water yes (if water comes from a pipe) == 1:3
water no (if not coming from water pipe) == 4:18 AND 19

saneamiento: desague -> red de alcantarillado, pozo ciego etc 
saneamiento yes (if connected to piped sewer system) == 1
sanamiento no (if not connected to piped sewer system) == 2:4 and 19

combustible: GLP, gas natural, electricidad
combustible yes (if elextricity, lpg, natural gas) == 1:3
combustible no (if wood, other, don't know) exclude missing values == 6,19,99,49

materiales de construccion: crear dummy con mejores materiales 
	material of walls
	good walls if brick, cement block, concrete == 1
	not good walls if (stone, brick earth, wood, other) eliminate missing values
 
	material of roof
	good roof if calamine/metal sheeting, concrete slab, tile (other policarbonato y shingle)
	not good if roof straw/cane/palm leaf, other(carpas de lona, maderas)
	
	material of floor
	good floor if (machimbre, wood, concrete, tiles, carpet)
	not good floor if (earthen floor, brick, other)
		* buscar privacion a un servicio, solo toma cero si es que tienen acceso a todos los servicios 

		
		
		numero de cuartos por hogar / npers
*/
