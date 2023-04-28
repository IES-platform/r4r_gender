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
 loc wgndnamecodelangexp1 `"genderit_wgnd-name-code-langexp.dta"'
 loc wgndnamecode1 "genderit_wgnd-name-code.dta"
 loc wgndnamelangcode1 "genderit_wgnd-name-langcode.dta"
 loc wgndnamenocode1 "genderit_wgnd-name-nocode.dta"
 loc wgndnamecodelangexp2 `"`c(sysdir_plus)'g/genderit_wgnd-name-code-langexp.dta"'
 loc wgndnamecode2 "`c(sysdir_plus)'g/genderit_wgnd-name-code.dta"
 loc wgndnamelangcode2 "`c(sysdir_plus)'g/genderit_wgnd-name-langcode.dta"
 loc wgndnamenocode2 "`c(sysdir_plus)'g/genderit_wgnd-name-nocode.dta"
 
 loc wgnd_zip "https://ies-r4r-public.s3.eu-central-1.amazonaws.com/wgnd/dta/wgnd_2_0.zip"
 
display "fetching WGND..."
copy "`wgnd_zip'" "wgnd.zip", replace
display "Done!"
display "Inflating..."
unzipfile "wgnd.zip"
display "Done!"
display "Moving files to STATA PLUS folder: `c(sysdir_plus)'g/..."
copy `"`wgndnamecode1'"' `"`wgndnamecode2'"', replace
copy `"`wgndnamecodelangexp1'"' `"`wgndnamecodelangexp2'"', replace
copy `"`wgndnamelangcode1'"' `"`wgndnamelangcode2'"', replace
copy `"`wgndnamenocode1'"' `"`wgndnamenocode2'"', replace
display "Done!"
display "Cleaning-up..."
erase `"`wgndnamecode1'"' 
erase `"`wgndnamecodelangexp1'"' 
erase `"`wgndnamelangcode1'"' 
erase `"`wgndnamenocode1'"' 
erase "wgnd.zip"
display "Done!"



end 

