********************************************************************************
********************************************************************************
***               This code is property of FUNDACION ARU                     ***
********************************************************************************
********************************************************************************
***      Author1 : Vladimir Garcia											 ***
********************************************************************************
***      Program : 															 ***
***      Version : 01, 8/28/2018              								 ***
***      Objetive: 	to generate a database with different variables of 		 ***
***					interest to analyze returns on education 				 ***
********************************************************************************
clear all 
global path 	"C:/Users/Vladimir/Desktop/_aru/_6ta tarea(retorons ed)"
global dta	 	"C:/Users/Vladimir/Desktop/_aru/_6ta tarea(retorons ed)/dta" 		

global do		"$path\do\" 
global gph 		"$path\gph\" 
global log 		"$path\log\" 
global table 	"$path\table\disaggregation\"

	
********************************************************************************
use "$dta/STEPBolivia_working.dta", clear
********************************************************************************

*----------------------------Non-cognitive skills -----------------------------*
								*** Total ***
								
*------ Total 
** Mean
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_mean_tot
egen `var'_mean_tot = mean(`var')

cap drop `var'_sd_tot
egen `var'_sd_tot = sd(`var')
}
*------ Mujeres
** Mean
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_mean_muj
egen `var'_mean_muj = mean(`var') if m1a_q02==2

cap drop `var'_sd_muj
egen `var'_sd_muj = sd(`var') if m1a_q02==2
}
*------ Hombres
** Mean
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_mean_homb
egen `var'_mean_homb = mean(`var') if m1a_q02==1

cap drop `var'_sd_homb
egen `var'_sd_homb = sd(`var') if m1a_q02==1
}
*----- Employed
** Mean
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_mean_emp
egen `var'_mean_emp = mean(`var') if emp==1

cap drop `var'_sd_emp
egen `var'_sd_emp = sd(`var') if emp==1
}
*----- Unemployed
** Mean and standard deviation
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_mean_unemp
egen `var'_mean_unemp = mean(`var') if emp==0

cap drop `var'_sd_unemp
egen `var'_sd_unemp = sd(`var') if emp==0
}
*----- Formal
** Mean and standard deviation
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_mean_f
egen `var'_mean_f = mean(`var') if informal==0

cap drop `var'_sd_f
egen `var'_sd_f = sd(`var') if informal==0
}

*----- Informal
** Mean and standard deviation
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_mean_i
egen `var'_mean_i = mean(`var') if informal==1

cap drop `var'_sd_i
egen `var'_sd_i = sd(`var') if informal==1
}
** Label variables
/*label variable extraversion_av_mean_tot "Mean of extraversion total pop."
label variable extraversion_av_sd_tot "S.D. of extraversion total pop."
label variable conscientiousness_avg_mean_tot "Mean of conscientiousness total pop."
label variable conscientiousness_avg_sd_tot "S.D. of conscienctiousness total pop."
label variable openness_av_mean_tot "Mean of openness total pop."
label variable openness_av_sd_tot "S.D. of openness total pop."
label variable stability_av_mean_tot "Mean of stability total pop."
label variable stability_av_sd_tot "S.D. of stability total pop."
label variable agreeableness_av_mean_tot "Mean of agreeableness total pop."
label variable agreeableness_av_sd_tot "S.D. of agreeableness total pop."
label variable grit_av_mean_tot "Mean of grit total pop."
label variable grit_av_sd_tot "S.D. of grit total pop."
label variable hostile_av_mean_tot "Mean of hostile total pop."
label variable hostile_av_sd_tot "SD hostile total pop."
label variable decision_av_mean_tot "Mean decision total pop."
label variable decision_av_sd_tot "SD decision total pop."
label variable risk_mean_tot "Mean risk total pop."
label variable risk_sd_tot "SD risk total pop."
label variable discount_mean_tot "Mean discount total pop."
label variable discount_sd_tot "SD discount total pop."
label variable earnings_h_mean_tot "Mean earnings total pop."
label variable earnings_h_sd_tot "SD earnings total pop."
label variable extraversion_av_mean_muj "Mean extraversion mujeres."
label variable extraversion_av_sd_muj "SD extraversion mujeres"
label variable conscientiousness_avg_mean_muj "Mean conscient. mujeres"
label variable conscientiousness_avg_sd_muj "SD conscient. mujeres"
label variable openness_av_mean_muj "Mean openness mujeres"
label variable openness_av_sd_muj "SD openness mujers"
label variable stability_av_mean_muj "Mean stability mujers"
label variable stability_av_sd_muj "SD stability mujers"
label variable agreeableness_av_mean_muj "
label variable agreeableness_av_sd_muj
label variable grit_av_mean_muj
label variable grit_av_sd_muj  
label variable hostile_av_mean_muj
label variable hostile_av_sd_muj
label variable decision_av_mean_muj
label variable decision_av_sd_muj
label variable risk_mean_muj   
label variable risk_sd_muj     
label variable discount_mean_muj
label variable discount_sd_muj 
label variable earnings_h_mean_muj
label variable earnings_h_sd_muj
label variable extraversion_av_mean_homb
label variable extraversion_av_sd_homb
label variable conscientiousness_avg_mean_homb
label variable conscientiousness_avg_sd_homb
label variable openness_av_mean_homb
label variable openness_av_sd_homb
label variable stability_av_mean_homb
label variable stability_av_sd_homb
label variable agreeableness_av_mean_homb
label variable agreeableness_av_sd_homb
label variable grit_av_mean_homb
label variable grit_av_sd_homb 
label variable hostile_av_mean_homb
label variable hostile_av_sd_homb
label variable decision_av_mean_homb
label variable decision_av_sd_homb
label variable risk_mean_homb  
label variable risk_sd_homb    
label variable discount_mean_homb
label variable discount_sd_homb
label variable earnings_h_mean_homb
label variable earnings_h_sd_homb
label variable extraversion_av_mean_emp
label variable extraversion_av_sd_emp
label variable conscientiousness_avg_mean_emp
label variable conscientiousness_avg_sd_emp
label variable openness_av_mean_emp
label variable openness_av_sd_emp
label variable stability_av_mean_emp
label variable stability_av_sd_emp
label variable agreeableness_av_mean_emp
label variable agreeableness_av_sd_emp
label variable grit_av_mean_emp
label variable grit_av_sd_emp  
label variable hostile_av_mean_emp
label variable hostile_av_sd_emp
label variable decision_av_mean_emp
label variable decision_av_sd_emp
label variable risk_mean_emp   
label variable risk_sd_emp     
label variable discount_mean_emp
label variable discount_sd_emp 
label variable earnings_h_mean_emp
label variable earnings_h_sd_emp
label variable extraversion_av_mean_unemp
label variable extraversion_av_sd_unemp
label variable conscientiousness_avg_mean_unemp
label variable conscientiousness_avg_sd_unemp
label variable openness_av_mean_unemp
label variable openness_av_sd_unemp
label variable stability_av_mean_unemp
label variable stability_av_sd_unemp
label variable agreeableness_av_mean_unemp
label variable agreeableness_av_sd_unemp
label variable grit_av_mean_unemp
label variable grit_av_sd_unemp
label variable hostile_av_mean_unemp
label variable hostile_av_sd_unemp
label variable decision_av_mean_unemp
label variable decision_av_sd_unemp
label variable risk_mean_unemp 
label variable risk_sd_unemp   
label variable discount_mean_unemp
label variable discount_sd_unemp
label variable earnings_h_mean_unemp
label earnings_h_sd_unemp
label extraversion_av_mean_f
label extraversion_av_sd_f
label conscientiousness_avg_mean_f
label conscientiousness_avg_sd_f
label openness_av_mean_f
label openness_av_sd_f
label stability_av_mean_f
label stability_av_sd_f
label agreeableness_av_mean_f
label agreeableness_av_sd_f
label grit_av_mean_f  
label grit_av_sd_f    
label hostile_av_mean_f
label hostile_av_sd_f 
label decision_av_mean_f
label decision_av_sd_f
label risk_mean_f     
label risk_sd_f       
label discount_mean_f 
label discount_sd_f   
label earnings_h_mean_f
label earnings_h_sd_f 
label extraversion_av_mean_i
label extraversion_av_sd_i
label conscientiousness_avg_mean_i
label conscientiousness_avg_sd_i
label openness_av_mean_i
label openness_av_sd_i
label stability_av_mean_i
label stability_av_sd_i
label agreeableness_av_mean_i
label agreeableness_av_sd_i
label grit_av_mean_i  
label grit_av_sd_i    
label hostile_av_mean_i
label hostile_av_sd_i                
label decision_av_mean_i
label decision_av_sd_i
label risk_mean_i     
label risk_sd_i       
label discount_mean_i 
label discount_sd_i  
label earnings_h_mean_i
label earnings_h_sd_i */

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
*------------------------------------------------------------------------------*
							*** Primaria ***
*----- Total
** Mean and standard deviation
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_mean_prim
egen `var'_mean_prim = mean(`var') if primaria==1

cap drop `var'_sd_prim
egen `var'_sd_prim = sd(`var') if primaria==1
}
*------ Mujeres
** Mean and standard deviation
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_p_muj
egen `var'_m_p_muj = mean(`var') if primaria==1 & m1a_q02==2 

cap drop `var'_sd_p_muj
egen `var'_sd_p_muj = sd(`var') if primaria==1 & m1a_q02==2 
}
*------ Hombres
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_p_h
egen `var'_m_p_h = mean(`var') if primaria==1 & m1a_q02==1

cap drop `var'_sd_p_h
egen `var'_sd_p_h = sd(`var') if primaria==1 & m1a_q02==1 
}
*------ Employed
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_p_e
egen `var'_m_prim_e = mean(`var') if primaria==1 & emp==1

cap drop `var'_sd_p_e
egen `var'_sd_p_e = sd(`var') if primaria==1 & emp==1 
}
*----- Unemployed
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_p_u
egen `var'_m_p_u = mean(`var') if primaria==1 & emp==0

cap drop `var'_sd_p_u
egen `var'_sd_p_u = sd(`var') if primaria==1 & emp==0 
}
*----- Formal
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_p_f
egen `var'_m_p_f = mean(`var') if primaria==1 & informal==0

cap drop `var'_sd_p_f
egen `var'_sd_p_f = sd(`var') if primaria==1 & informal==0 
}
*----- Informal
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_p_i
egen `var'_m_p_i = mean(`var') if primaria==1 & informal==1

cap drop `var'_sd_p_i
egen `var'_sd_p_i = sd(`var') if primaria==1 & informal==1
}
							
							*** Técnico ***
*------ Total
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_mean_tec
egen `var'_mean_tec = mean(`var') if tecnic==1

cap drop `var'_sd_tec
egen `var'_sd_tec = sd(`var') if tecnic==1
}
*------ Mujeres
** Mean and standard deviation
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_mean_tec_m
egen `var'_mean_tec_m = mean(`var') if tecnic==1 & m1a_q02==2 

cap drop `var'_sd_tec_m
egen `var'_sd_tec_m = sd(`var') if tecnic==1 & m1a_q02==2 
}
*------ Hombres
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_mean_tec_h
egen `var'_mean_tec_h = mean(`var') if tecnic==1 & m1a_q02==1

cap drop `var'_sd_tec_h
egen `var'_sd_tec_h = sd(`var') if tecnic==1 & m1a_q02==1 
}
*------ Employed
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_tec_emp
egen `var'_m_tec_emp = mean(`var') if tecnic==1 & emp==1

cap drop `var'_sd_tec_e
egen `var'_sd_tec_e = sd(`var') if tecnic==1 & emp==1 
}
*----- Unemployed
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_tec_u
egen `var'_m_tec_u = mean(`var') if tecnic==1 & emp==0

cap drop `var'_sd_tec_u
egen `var'_sd_tec_u = sd(`var') if tecnic==1 & emp==0 
}
*----- Formal
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_tec_f
egen `var'_m_tec_f = mean(`var') if tecnic==1 & informal==0

cap drop `var'_sd_tec_f
egen `var'_sd_tec_f = sd(`var') if tecnic==1 & informal==0 
}
*------ Informal
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_tec_i
egen `var'_m_tec_i = mean(`var') if tecnic==1 & informal==1

cap drop `var'_sd_tec_i
egen `var'_sd_tec_i = sd(`var') if tecnic==1 & informal==1
}

						*** Técnicno Normal ***
*------ Total
** Mean and standard deviation
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_mean_tecn
egen `var'_mean_tecn = mean(`var') if tecnic_normal==1

cap drop `var'_sd_tecn
egen `var'_sd_tecn = sd(`var') if tecnic_normal==1
}
*------ Mujeres
** Mean and standard deviation
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_tecn_m
egen `var'_m_tecn_m = mean(`var') if tecnic_normal==1 & m1a_q02==2 

cap drop `var'_sd_tecn_m
egen `var'_sd_tecn_m = sd(`var') if tecnic_normal==1 & m1a_q02==2 
}
*------ Hombres
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_tecn_h
egen `var'_m_tecn_h = mean(`var') if tecnic_normal==1 & m1a_q02==1

cap drop `var'_sd_tecn_h
egen `var'_sd_tecn_h = sd(`var') if tecnic_normal==1 & m1a_q02==1 
}
*------ Employed
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_tecn_emp
egen `var'_m_tecn_emp = mean(`var') if tecnic_normal==1 & emp==1

cap drop `var'_sd_tecn_e
egen `var'_sd_tecn_e = sd(`var') if tecnic_normal==1 & emp==1 
}
*------ Unemployed
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_tecn_u
egen `var'_m_tecn_u = mean(`var') if tecnic_normal==1 & emp==0

cap drop `var'_sd_tecn_u
egen `var'_sd_tecn_u = sd(`var') if tecnic_normal==1 & emp==0 
}
*------ Formal
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_tecn_f
egen `var'_m_tecn_f = mean(`var') if tecnic_normal==1 & informal==0

cap drop `var'_sd_tecn_f
egen `var'_sd_tecn_f = sd(`var') if tecnic_normal==1 & informal==0 
}
*----- Informal
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_tecn_i
egen `var'_m_tecn_i = mean(`var') if tecnic_normal==1 & informal==1

cap drop `var'_sd_tecn_i
egen `var'_sd_tecn_i = sd(`var') if tecnic_normal==1 & informal==1
}
							*** Licenciatura ***
*------ Total
** Mean and standard deviation
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_mean_lic
egen `var'_mean_lic = mean(`var') if licen==1

cap drop `var'_sd_lic
egen `var'_sd_lic = sd(`var') if licen ==1
}
*------ Mujeres
** Mean and standard deviation
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_licen_m
egen `var'_m_licen_m = mean(`var') if licen==1 & m1a_q02==2 

cap drop `var'_sd_licen_m
egen `var'_sd_licen_m = sd(`var') if licen==1 & m1a_q02==2 
}
*------ Hombres
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_licen_h
egen `var'_m_licen_h = mean(`var') if licen==1 & m1a_q02==1

cap drop `var'_sd_licen_h
egen `var'_sd_licen_h = sd(`var') if licen==1 & m1a_q02==1 
}
*------ Employed
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_licen_e
egen `var'_m_licen_e = mean(`var') if licen==1 & emp==1

cap drop `var'_sd_licen_e
egen `var'_sd_licen_e = sd(`var') if licen==1 & emp==1 
}
*------ Unemployed
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_licen_u
egen `var'_m_licen_u = mean(`var') if licen==1 & emp==0

cap drop `var'_sd_licen_u
egen `var'_sd_licen_u = sd(`var') if licen==1 & emp==0 
}
*------ Formal
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_licen_f
egen `var'_m_licen_f = mean(`var') if licen==1 & informal==0

cap drop `var'_sd_licen_f
egen `var'_sd_licen_f = sd(`var') if licen==1 & informal==0 
}
*----- Informal
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_licen_i
egen `var'_m_licen_i = mean(`var') if licen==1 & informal==1

cap drop `var'_sd_licen_i
egen `var'_sd_licen_i = sd(`var') if licen==1 & informal==1
}
							*** Post-grado ***
*------ Total
** Mean and standard deviation
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_mean_pg
egen `var'_mean_pg = mean(`var') if post_grad==1

cap drop `var'_sd_pg
egen `var'_sd_pg = sd(`var') if post_grad==1
}
*------ Mujeres
** Mean and standard deviation
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_pg_m
egen `var'_m_pg_m = mean(`var') if post_grad==1 & m1a_q02==2 

cap drop `var'_sd_pg_m
egen `var'_sd_pg_m = sd(`var') if post_grad==1 & m1a_q02==2 
}
*------ Hombres
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_pg_h
egen `var'_m_pg_h = mean(`var') if post_grad==1 & m1a_q02==1

cap drop `var'_sd_pg_h
egen `var'_sd_pg_h = sd(`var') if post_grad==1 & m1a_q02==1 
}
*------ Employed
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_pg_e
egen `var'_m_pg_e = mean(`var') if post_grad==1 & emp==1

cap drop `var'_sd_pg_e
egen `var'_sd_pg_e = sd(`var') if post_grad==1 & emp==1 
}
*------ Unemployed
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_pg_u
egen `var'_m_pg_u = mean(`var') if post_grad==1 & emp==0

cap drop `var'_sd_pg_u
egen `var'_sd_pg_u = sd(`var') if post_grad==1 & emp==0 
}
*------ Formal
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_pg_f
egen `var'_m_pg_f = mean(`var') if post_grad==1 & informal==0

cap drop `var'_sd_pg_f
egen `var'_sd_pg_f = sd(`var') if post_grad==1 & informal==0 
}
*----- Informal
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_pg_i
egen `var'_m_pg_i = mean(`var') if post_grad==1 & informal==1

cap drop `var'_sd_pg_i
egen `var'_sd_pg_i = sd(`var') if post_grad==1 & informal==1
}
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
						*** Early adulthood ***
*----- Total
** Mean and standard deviation
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_ea
egen `var'_m_ea = mean(`var') if early_adult==1

cap drop `var'_sd_ea
egen `var'_sd_ea = sd(`var') if early_adult==1
}
*------ Mujeres
** Mean and standard deviation
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_ea_m
egen `var'_m_ea_m = mean(`var') if early_adult==1 & m1a_q02==2 

cap drop `var'_sd_ea_m
egen `var'_sd_ea_m = sd(`var') if early_adult==1 & m1a_q02==2 
}
*------ Hombres
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_ea_h
egen `var'_m_ea_h = mean(`var') if early_adult==1 & m1a_q02==1

cap drop `var'_sd_ea_h
egen `var'_sd_ea_h = sd(`var') if early_adult==1 & m1a_q02==1 
}
*------ Employed
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_ea_e
egen `var'_m_ea_e = mean(`var') if early_adult==1 & emp==1

cap drop `var'_sd_ea_e
egen `var'_sd_ea_e = sd(`var') if early_adult==1 & emp==1 
}
*------ Unemployed
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_ea_u
egen `var'_m_ea_u = mean(`var') if early_adult==1 & emp==0

cap drop `var'_sd_ea_u
egen `var'_sd_ea_u = sd(`var') if early_adult==1 & emp==0 
}
*------ Formal
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_ea_f
egen `var'_m_ea_f = mean(`var') if early_adult==1 & informal==0

cap drop `var'_sd_ea_f
egen `var'_sd_ea_f = sd(`var') if early_adult==1 & informal==0 
}
*----- Informal
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_ea_i
egen `var'_m_ea_i = mean(`var') if early_adult==1 & informal==1

cap drop `var'_sd_ea_i
egen `var'_sd_ea_i = sd(`var') if early_adult==1 & informal==1
}
						*** Adulthood ***
*----- Total
** Mean and standard deviation
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_ad
egen `var'_m_ad = mean(`var') if adult==1

cap drop `var'_sd_ad
egen `var'_sd_ad = sd(`var') if adult==1
}
*------ Mujeres
** Mean and standard deviation
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_ad_m
egen `var'_m_ad_m = mean(`var') if adult==1 & m1a_q02==2 

cap drop `var'_sd_ad_m
egen `var'_sd_ad_m = sd(`var') if adult==1 & m1a_q02==2 
}
*------ Hombres
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_ad_h
egen `var'_m_ad_h = mean(`var') if adult==1 & m1a_q02==1

cap drop `var'_sd_ad_h
egen `var'_sd_ad_h = sd(`var') if adult==1 & m1a_q02==1 
}
*------ Employed
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_ad_e
egen `var'_m_ad_e = mean(`var') if adult==1 & emp==1

cap drop `var'_sd_ad_e
egen `var'_sd_ad_e = sd(`var') if adult==1 & emp==1 
}
*------ Unemployed
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_ad_u
egen `var'_m_ad_u = mean(`var') if adult==1 & emp==0

cap drop `var'_sd_ad_u
egen `var'_sd_ad_u = sd(`var') if adult==1 & emp==0 
}
*------ Formal
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_ad_f
egen `var'_m_ad_f = mean(`var') if adult==1 & informal==0

cap drop `var'_sd_ad_f
egen `var'_sd_ad_f = sd(`var') if adult==1 & informal==0 
}
*----- Informal
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_ad_i
egen `var'_m_ad_i = mean(`var') if adult==1 & informal==1

cap drop `var'_sd_ad_i
egen `var'_sd_ad_i = sd(`var') if adult==1 & informal==1
}
						*** Late Adulthood ***
*----- Total
** Mean and standard deviation
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_lad
egen `var'_m_lad = mean(`var') if late_adult==1

cap drop `var'_sd_lad
egen `var'_sd_lad = sd(`var') if late_adult==1
}
*------ Mujeres
** Mean and standard deviation
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_lad_m
egen `var'_m_lad_m = mean(`var') if late_adult==1 & m1a_q02==2 

cap drop `var'_sd_lad_m
egen `var'_sd_lad_m = sd(`var') if late_adult==1 & m1a_q02==2 
}
*------ Hombres
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_lad_h
egen `var'_m_lad_h = mean(`var') if late_adult==1 & m1a_q02==1

cap drop `var'_sd_lad_h
egen `var'_sd_lad_h = sd(`var') if late_adult==1 & m1a_q02==1 
}
*------ Employed
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_lad_e
egen `var'_m_lad_e = mean(`var') if late_adult==1 & emp==1

cap drop `var'_sd_lad_e
egen `var'_sd_lad_e = sd(`var') if late_adult==1 & emp==1 
}
*------ Unemployed
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_lad_u
egen `var'_m_lad_u = mean(`var') if late_adult==1 & emp==0

cap drop `var'_sd_lad_u
egen `var'_sd_lad_u = sd(`var') if late_adult==1 & emp==0 
}
*------ Formal
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_lad_f
egen `var'_m_lad_f = mean(`var') if late_adult==1 & informal==0

cap drop `var'_sd_lad_f
egen `var'_sd_lad_f = sd(`var') if late_adult==1 & informal==0 
}
*----- Informal
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_lad_i
egen `var'_m_lad_i = mean(`var') if late_adult==1 & informal==1

cap drop `var'_sd_lad_i
egen `var'_sd_lad_i = sd(`var') if late_adult==1 & informal==1
}
							*** Early Senior ***
*----- Total
** Mean and standard deviation
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_eas
egen `var'_m_eas = mean(`var') if early_senior==1

cap drop `var'_sd_eas
egen `var'_sd_eas = sd(`var') if early_senior==1
}
*------ Mujeres
** Mean and standard deviation
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_eas_m
egen `var'_m_eas_m = mean(`var') if early_senior==1 & m1a_q02==2 

cap drop `var'_sd_eas_m
egen `var'_sd_eas_m = sd(`var') if early_senior==1 & m1a_q02==2 
}
*------ Hombres
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_eas_h
egen `var'_m_eas_h = mean(`var') if early_senior==1 & m1a_q02==1

cap drop `var'_sd_eas_h
egen `var'_sd_eas_h = sd(`var') if early_senior==1 & m1a_q02==1 
}
*------ Employed
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_eas_e
egen `var'_m_eas_e = mean(`var') if early_senior==1 & emp==1

cap drop `var'_sd_eas_e
egen `var'_sd_eas_e = sd(`var') if early_senior==1 & emp==1 
}
*------ Unemployed
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_eas_u
egen `var'_m_eas_u = mean(`var') if early_senior==1 & emp==0

cap drop `var'_sd_eas_u
egen `var'_sd_eas_u = sd(`var') if early_senior==1 & emp==0 
}
*------ Formal
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_eas_f
egen `var'_m_eas_f = mean(`var') if early_senior==1 & informal==0

cap drop `var'_sd_eas_f
egen `var'_sd_eas_f = sd(`var') if early_senior==1 & informal==0 
}
*----- Informal
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_eas_i
egen `var'_m_eas_i = mean(`var') if early_senior==1 & informal==1

cap drop `var'_sd_eas_i
egen `var'_sd_eas_i = sd(`var') if early_senior==1 & informal==1
}
								*** Senior ***
*----- Total
** Mean and standard deviation
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_sen
egen `var'_m_sen = mean(`var') if senior==1

cap drop `var'_sd_sen
egen `var'_sd_sen = sd(`var') if senior==1
}
*------ Mujeres
** Mean and standard deviation
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_sen_m
egen `var'_m_sen_m = mean(`var') if senior==1 & m1a_q02==2 

cap drop `var'_sd_sen_m
egen `var'_sd_sen_m = sd(`var') if senior==1 & m1a_q02==2 
}
*------ Hombres
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_sen_h
egen `var'_m_sen_h = mean(`var') if senior==1 & m1a_q02==1

cap drop `var'_sd_sen_h
egen `var'_sd_sen_h = sd(`var') if senior==1 & m1a_q02==1 
}
*------ Employed
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_sen_e
egen `var'_m_sen_e = mean(`var') if senior==1 & emp==1

cap drop `var'_sd_sen_e
egen `var'_sd_sen_e = sd(`var') if senior==1 & emp==1 
}
*------ Unemployed
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_sen_u
egen `var'_m_sen_u = mean(`var') if senior==1 & emp==0

cap drop `var'_sd_sen_u
egen `var'_sd_sen_u = sd(`var') if senior==1 & emp==0 
}
*------ Formal
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_sen_f
egen `var'_m_sen_f = mean(`var') if senior==1 & informal==0

cap drop `var'_sd_sen_f
egen `var'_sd_sen_f = sd(`var') if senior==1 & informal==0 
}
*----- Informal
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_sen_i
egen `var'_m_sen_i = mean(`var') if senior==1 & informal==1

cap drop `var'_sd_sen_i
egen `var'_sd_sen_i = sd(`var') if senior==1 & informal==1
}
*----------------------- Generate Class/Wealth Level Dummies ------------------*
cap drop poor
gen poor = (strata==11|strata==12|strata==21|strata==22	|strata==31|strata==31/*
*/			|strata==32|strata==41|strata==42)

cap drop middle
gen middle = (strata==13|strata==23|strata==33|strata==43)

cap drop rich
gen rich = (strata==14|strata==15|strata==24|strata==25|strata==34|strata==35|strata==44|strata==45)
*------------------------------------------------------------------------------*
								*** Poor ***
*----- Total
** Mean and standard deviation
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_por
egen `var'_m_por = mean(`var') if poor==1

cap drop `var'_sd_por
egen `var'_sd_por = sd(`var') if poor==1
}
*------ Mujeres
** Mean and standard deviation
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_por_m
egen `var'_m_por_m = mean(`var') if poor==1 & m1a_q02==2 

cap drop `var'_sd_por_m
egen `var'_sd_por_m = sd(`var') if poor==1 & m1a_q02==2 
}
*------ Hombres
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_por_h
egen `var'_m_por_h = mean(`var') if poor==1 & m1a_q02==1

cap drop `var'_sd_por_h
egen `var'_sd_por_h = sd(`var') if poor==1 & m1a_q02==1 
}
*------ Employed
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_por_e
egen `var'_m_por_e = mean(`var') if poor==1 & emp==1

cap drop `var'_sd_por_e
egen `var'_sd_por_e = sd(`var') if poor==1 & emp==1 
}
*------ Unemployed
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_por_u
egen `var'_m_por_u = mean(`var') if poor==1 & emp==0

cap drop `var'_sd_por_u
egen `var'_sd_por_u = sd(`var') if poor==1 & emp==0 
}
*------ Formal
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_por_f
egen `var'_m_por_f = mean(`var') if poor==1 & informal==0

cap drop `var'_sd_por_f
egen `var'_sd_por_f = sd(`var') if poor==1 & informal==0 
}
*----- Informal
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_por_i
egen `var'_m_por_i = mean(`var') if poor==1 & informal==1

cap drop `var'_sd_por_i
egen `var'_sd_por_i = sd(`var') if poor==1 & informal==1
}
							
							*** Middle ***
*----- Total
** Mean and standard deviation
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_mid
egen `var'_m_mid = mean(`var') if middle==1

cap drop `var'_sd_mid
egen `var'_sd_mid = sd(`var') if middle==1
}
*------ Mujeres
** Mean and standard deviation
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_mid_m
egen `var'_m_mid_m = mean(`var') if middle==1 & m1a_q02==2 

cap drop `var'_sd_mid_m
egen `var'_sd_mid_m = sd(`var') if middle==1 & m1a_q02==2 
}
*------ Hombres
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_mid_h
egen `var'_m_mid_h = mean(`var') if middle==1 & m1a_q02==1

cap drop `var'_sd_mid_h
egen `var'_sd_mid_h = sd(`var') if middle==1 & m1a_q02==1 
}
*------ Employed
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_mid_e
egen `var'_m_mid_e = mean(`var') if middle==1 & emp==1

cap drop `var'_sd_mid_e
egen `var'_sd_mid_e = sd(`var') if middle==1 & emp==1 
}
*------ Unemployed
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_mid_u
egen `var'_m_mid_u = mean(`var') if middle==1 & emp==0

cap drop `var'_sd_mid_u
egen `var'_sd_mid_u = sd(`var') if middle==1 & emp==0 
}
*------ Formal
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_mid_f
egen `var'_m_mid_f = mean(`var') if middle==1 & informal==0

cap drop `var'_sd_mid_f
egen `var'_sd_mid_f = sd(`var') if middle==1 & informal==0 
}
*----- Informal
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_mid_i
egen `var'_m_mid_i = mean(`var') if middle==1 & informal==1

cap drop `var'_sd_mid_i
egen `var'_sd_mid_i = sd(`var') if middle==1 & informal==1
}
							*** Rich ***
*----- Total
** Mean and standard deviation
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_ric
egen `var'_m_ric = mean(`var') if rich==1

cap drop `var'_sd_ric
egen `var'_sd_ric = sd(`var') if rich==1
}
*------ Mujeres
** Mean and standard deviation
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_ric_m
egen `var'_m_ric_m = mean(`var') if rich==1 & m1a_q02==2 

cap drop `var'_sd_ric_m
egen `var'_sd_ric_m = sd(`var') if rich==1 & m1a_q02==2 
}
*------ Hombres
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_ric_h
egen `var'_m_ric_h = mean(`var') if rich==1 & m1a_q02==1

cap drop `var'_sd_ric_h
egen `var'_sd_ric_h = sd(`var') if rich==1 & m1a_q02==1 
}
*------ Employed
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_ric_e
egen `var'_m_ric_e = mean(`var') if rich==1 & emp==1

cap drop `var'_sd_ric_e
egen `var'_sd_ric_e = sd(`var') if rich==1 & emp==1 
}
*------ Unemployed
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_ric_u
egen `var'_m_ric_u = mean(`var') if rich==1 & emp==0

cap drop `var'_sd_ric_u
egen `var'_sd_ric_u = sd(`var') if rich==1 & emp==0 
}
*------ Formal
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_ric_f
egen `var'_m_ric_f = mean(`var') if rich==1 & informal==0

cap drop `var'_sd_ric_f
egen `var'_sd_ric_f = sd(`var') if rich==1 & informal==0 
}
*----- Informal
foreach var of varlist 	extraversion_av conscientiousness_avg openness_av/*
*/						stability_av agreeableness_av grit_av hostile_av/*
*/						decision_av risk discount earnings_h {
cap drop `var'_m_ric_i
egen `var'_m_ric_i = mean(`var') if rich==1 & informal==1

cap drop `var'_sd_ric_i
egen `var'_sd_ric_i = sd(`var') if rich==1 & informal==1
}

*--------------------- Generate Privación a Servicios Dummy -------------------*
* Electricidad (yes if coming from power grid)
cap drop elec_
gen elec_=(m1b_q12==2 | m1b_q12==3)

* Agua (yes if coming from water pipe) --> CONTINUE FROM HERE
cap drop agua_
gen agua_=(m1b_q08==1|m1b_q08==2|m1b_q08==3)

* saneamiento (yes if connected to piped sewere, no otherwise)
cap drop sane_
gen sane_=(m1b_q13==1)

* combustible (yes if electricity, lpg, or natural gas)
cap drop comb_
gen comb_=(m1b_q11==1|m1b_q11==2|m1b_q11==3)

* Materiales
	* Walls (yes if brick, cement block, or concrete, wood)
	cap drop wall_
	gen wall_=(m1b_q02==1)
	
	* Roof (yes if calamine/,etal sheeting, concrete slab, tile, other(policarbonato y shingle)
	cap drop roof_
	gen roof_=(m1b_q03==1|m1b_q03==3|m1b_q03==4|m1b_q03_other=="POLICARBONATO"|m1b_q03_other=="SHINGLE")

	* Floor 
	cap drop floor_
	gen floor_=(m1b_q04==1|m1b_q04==2|m1b_q04==3|m1b_q04==4|m1b_q04==7)
* Privacion a materiales: "if materials are not good = 1, 0 otherwise"
cap drop priv_matrl_
gen priv_matrl_=(wall_==1 & roof_==1 & floor_==1)
recode priv_matrl 1=0 0=1

* Privacion a Servicios
cap drop priv_serv
gen priv_serv=(elec_==1 & agua_==1 & sane_==1 & comb==1)
recode priv_serv 1=0 0=1	
*----------------- Number of rooms per household/number of persons in hh-------*
cap drop room_person
gen room_person = m1b_q06/npers

cap drop person_room
gen person_room = npers/m1b_q06

cap drop room_sl_person
gen room_sl_person = m1b_q07/npers

cap drop person_room_sl
gen person_room_sl = npers/m1b_q07
*------------------- Create Labels -------------------------


*--------------------------- 
save "$path\log\STEPBolivia_working_database.dta", replace
