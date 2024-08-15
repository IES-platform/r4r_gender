*! 0.2 J.D. Raffo 2024-08-14
* Gender It Install WGND (v.0.2)
* ======================
* To Do
***********************************
* Add choices for sources
* add confirmation of existing file to speed up
* add replace existing file option 
*********************************************************

cap program drop genderit_install_wgnd
program genderit_install_wgnd
 version 14
 syntax [, REPlace Source(string)]
 
 n display "(This may take some time depending on CPU and internet connection speed)" _newline 
 if ("`replace'"=="replace") {
 	n display "Replace option selected: Overriding any existing WGND files." _newline 
 }
 
*********************************************************
* definitions
*********************************************************
* WNGD target files
 loc wgndnamecodelangexp2 `"`c(sysdir_plus)'g/genderit_wgnd-name-code-langexp.dta"'
 loc wgndnamecode2 "`c(sysdir_plus)'g/genderit_wgnd-name-code.dta"
 loc wgndnamelangcode2 "`c(sysdir_plus)'g/genderit_wgnd-name-langcode.dta"
 loc wgndnamenocode2 "`c(sysdir_plus)'g/genderit_wgnd-name-nocode.dta"
 
 
************************************************
* SOURCES:
* wipo2 = WGND 2.0 @ WIPO TIND 
* harvard2 = WGND 2.0 @ Harvard DATAVERSE
* harvard1 = WGND 1.0 @ Harvard DATAVERSE 
* wipo1  = WGND 1.0 @ WIPO WP 33 (old zip)
*********************************************** 
// default source = wipo2 = WGND 2.0 WIPO @ TIND 
if ("`source'"=="" ) loc source="wipo2"  

n display "Fetching WGND from `source'" _newline 

*********************************************** 
* wipo2 = WGND 2.0 @ WIPO TIND  
*********************************************** 
if ("`source'"=="wipo2") { // WIPO TIND (new default) 2.0
 loc wgndnamecode1 "https://tind.wipo.int/record/49408/files/wgnd_2_0_name-gender-code.csv?ln=en"
 loc wgndnamecodelangexp1 "https://tind.wipo.int/record/49408/files/wgnd_2_0_name-gender-code_langexp.csv?ln=en"
 loc wgndnamelangcode1 "https://tind.wipo.int/record/49408/files/wgnd_2_0_name-gender-langcode.csv?ln=en"
 loc wgndnamenocode1 "https://tind.wipo.int/record/49408/files/wgnd_2_0_name-gender_nocode.csv?ln=en"
 loc diclist wgndnamenocode wgndnamecode wgndnamelangcode wgndnamecodelangexp

 qui foreach x of loc diclist {
  cap confirm file "``x'2'" // check if file exists
  if (_rc!=0 | "`replace'"=="replace") {
	n display "fetching `x' at ``x'1'"
	import delimited "``x'1'", clear varn(1)
	n display "Done! Preparing data for save ..."
	replace gender="U" if gender=="?"
	cap gen wgt=1 // alternative for no wgt var
	cap ren langcode code // alternative for langcode 
	cap reshape wide wgt, i(name code) j(gender) string
	if _rc!=0 {
		cap reshape wide wgt, i(name) j(gender) string // alternative for nocode
		if _rc!=0 {
			n display "Fetched data ill-formed. Check the source."
		}
	}
	ren wgt* gender*
	mvencode gender*, mv(0) override
	compress
	n display "Done! Saving `x' at STATA PLUS folder: ``x'2' ..."
	save "``x'2'", replace
	n display "Saved!" _newline 
  }
  else {
 	n display "`x' found in STATA PLUS folder. Skipping it, use replace option to override" _newline
  }
 }
}
*********************************************** 
* harvard2 = WGND 2.0 @ Harvard DATAVERSE
*********************************************** 
else if ("`source'"=="harvard2" ) { // Harvard Dataverse 2.0
 loc wgndnamecode1 "https://dataverse.harvard.edu/api/access/datafile/4750348"
 loc wgndnamecodelangexp1 "https://dataverse.harvard.edu/api/access/datafile/4750350"
 loc wgndnamelangcode1 "https://dataverse.harvard.edu/api/access/datafile/4750353"
 loc wgndnamenocode1 "https://dataverse.harvard.edu/api/access/datafile/4750351"
 loc diclist wgndnamenocode wgndnamecode wgndnamelangcode wgndnamecodelangexp

 qui foreach x of loc diclist {
  cap confirm file "``x'2'" // check if file exists
  if (_rc!=0 | "`replace'"=="replace") {
	n display "fetching `x' at ``x'1'"
	import delimited "``x'1'", clear varn(1)
	n display "Done! Preparing data for save ..."
	replace gender="U" if gender=="?"
	cap gen wgt=1 // alternative for no wgt var
	cap ren langcode code // alternative for langcode 
	cap reshape wide wgt, i(name code) j(gender) string
	if _rc!=0 {
		cap reshape wide wgt, i(name) j(gender) string // alternative for nocode
		if _rc!=0 {
			n display "Fetched data ill-formed. Check the source."
		}
	}
	ren wgt* gender*
	mvencode gender*, mv(0) override
	compress
	n display "Done! Saving `x' at STATA PLUS folder: ``x'2' ..."
	save "``x'2'", replace
	n display "Saved!" _newline 
  }
  else {
 	n display "`x' found in STATA PLUS folder. Skipping it, use replace option to override" _newline
  }
 }
}
*********************************************** 
* harvard1 = WGND 1.0 @ Harvard DATAVERSE
*********************************************** 
else if ("`source'"=="harvard1" ) { // Harvard Dataverse 1.0
 loc wgndnamecode1 "https://dataverse.harvard.edu/api/access/datafile/:persistentId?persistentId=doi:10.7910/DVN/YPRQH8/QF0XTJ"
 loc wgndnamecodelangexp1 "https://dataverse.harvard.edu/api/access/datafile/:persistentId?persistentId=doi:10.7910/DVN/YPRQH8/PPCZGQ"
 loc wgndnamelangcode1 "" // no namelangcode
 loc wgndnamenocode1 "https://dataverse.harvard.edu/api/access/datafile/:persistentId?persistentId=doi:10.7910/DVN/YPRQH8/2C9CUM"
 loc diclist wgndnamenocode wgndnamecode wgndnamecodelangexp // no namelangcode

 qui foreach x of loc diclist {
  cap confirm file "``x'2'" // check if file exists
  if (_rc!=0 | "`replace'"=="replace") {
	n display "fetching `x' at ``x'1'"
	import delimited "``x'1'", clear varn(1)
	n display "Done! Preparing data for save ..."
	replace gender="U" if gender=="?"
	replace name=ustrlower(name)
	cap gen wgt=1 // alternative for no wgt var
	cap ren langcode code // alternative for langcode 
	cap reshape wide wgt, i(name code) j(gender) string
	if _rc!=0 {
		cap reshape wide wgt, i(name) j(gender) string // alternative for nocode
		if _rc!=0 {
			n display "Fetched data ill-formed. Check the source."
		}
	}
	ren wgt* gender*
	mvencode gender*, mv(0) override
	compress
	n display "Done! Saving `x' at STATA PLUS folder: ``x'2' ..."
	save "``x'2'", replace
	n display "Saved!" _newline 
  }
  else {
 	n display "`x' found in STATA PLUS folder. Skipping it, use replace option to override" _newline
  }
 }
}
*********************************************** 
* wipo1  = WGND 1.0 @ WIPO WP 33 (old zip)
*********************************************** 
else if ("`source'"=="wipo1") { // WIPO WP 1.0
// ZIP file name/link
 loc wgnd_zip "https://www.wipo.int/edocs/pubdocs/en/wipo_pub_econstat_wp_33-tech1.zip"
 
 loc wgndnamecode1 "wgnd_ctry.csv"
 loc wgndnamecodelangexp1 "wgnd_langctry.csv"
 loc wgndnamelangcode1 "" // no namelangcode
 loc wgndnamenocode1 "wgnd_noctry.csv"
 loc diclist wgndnamenocode wgndnamecode wgndnamecodelangexp // no namelangcode

 // get ZIP file
 display "fetching WGND..."
 copy "`wgnd_zip'" "wgnd.zip", replace
 display "Done!"
 display "Inflating..."
 unzipfile "wgnd.zip", replace
 display "Done!"
 
 // prepare files
 qui foreach x of loc diclist {
  cap confirm file "``x'2'" // check if file exists
  if (_rc!=0 | "`replace'"=="replace") {
	n display "fetching `x' at ``x'1'"
	import delimited "``x'1'", clear varn(1)
	n display "Done! Preparing data for save ..."
	replace gender="U" if gender=="?"
	replace name=ustrlower(name)
	cap gen wgt=1 // alternative for no wgt var
	cap ren langcode code // alternative for langcode 
	cap reshape wide wgt, i(name code) j(gender) string
	if _rc!=0 {
		cap reshape wide wgt, i(name) j(gender) string // alternative for nocode
		if _rc!=0 {
			n display "Fetched data ill-formed. Check the source."
		}
	}
	ren wgt* gender*
	mvencode gender*, mv(0) override
	compress
	n display "Done! Saving `x' at STATA PLUS folder: ``x'2' ..."
	save "``x'2'", replace
	n display "Saved!" _newline 
  }
  else {
 	n display "`x' found in STATA PLUS folder. Skipping it, use replace option to override" _newline
  }
 }
 // clean-up
 display "Cleaning-up..."
 erase `"`wgndnamecode1'"' 
 erase `"`wgndnamecodelangexp1'"' 
 // erase `"`wgndnamelangcode1'"'
 erase `"`wgndnamenocode1'"' 
 erase "wgnd_source.csv" 
 erase "wgnd.zip"
 display "Done!"
}
qui clear  
end
