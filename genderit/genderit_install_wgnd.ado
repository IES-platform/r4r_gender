*! 0.1 J.D. Raffo 2022-08-07
* Gender It Install WGND (v.0.1)
* ======================
* To Do
***********************************
* add var passing
* add languages
* add choice of steps
* finish ado
*********************************************************

cap program drop genderit_install_wgnd
program genderit_install_wgnd
 version 14

*********************************************************
* definitions
*********************************************************
* WNGD files
 loc wgndnamecodelangexp `"`c(sysdir_plus)'g/genderit_wgnd-name-code-langexp.dta"'
 loc wgndnamecode "`c(sysdir_plus)'g/genderit_wgnd-name-code.dta"
 loc wgndnamelangcode "`c(sysdir_plus)'g/genderit_wgnd-name-langcode.dta"
 loc wgndnamenocode "`c(sysdir_plus)'g/genderit_wgnd-name-nocode.dta"
 
display "fetching WGND..."
copy https://ies-r4r-public.s3.eu-central-1.amazonaws.com/wgnd/wgnd_2_0.zip ///    
    wgnd_2_0.zip  , replace
display "Done!"
display "Inflating..."
unzipfile wgnd_2_0.zip
display "Done!"
display "converting to STATA..."
import delimited wgnd_2_0_name-gender-code.csv , clear
save `wgndnamecode' , replace
import delimited wgnd_2_0_name-gender-code_langexp.csv , clear
save `wgndnamecodelangexp', replace
import delimited wgnd_2_0_name-gender-langcode.csv , clear
save `wgndnamelangcode', replace
import delimited wgnd_2_0_name-gender_nocode.csv , clear
save `wgndnamenocode' , replace
display "Done!"
end 
