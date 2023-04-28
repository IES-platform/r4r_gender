*! 1.0 J.D. Raffo 2023-04-28
* Gender It (v.1.0)
* =================
* To Do
***********************************
* add var passing
* add languages
* add choice of steps
* finish ado
*********************************************************

cap program drop genderit
program genderit
 version 14
 syntax varlist (min=2 max=2 str) [, Clean Binarystats Namesplit Attribthreshold(real .6)]

*********************************************************
* definitions
*********************************************************
* WNGD files
 loc wgndnamecodelangexp `"`c(sysdir_plus)'g/genderit_wgnd-name-code-langexp.dta"'
 loc wgndnamecode "`c(sysdir_plus)'g/genderit_wgnd-name-code.dta"
 loc wgndnamelangcode "`c(sysdir_plus)'g/genderit_wgnd-name-langcode.dta"
 loc wgndnamenocode "`c(sysdir_plus)'g/genderit_wgnd-name-nocode.dta"
* cleaning
// loc clean "clean"
 loc cleanregex "[^a-z]"
 loc mycleandegree 3
* normalization of stats 
// loc binarystats = "binarystats"
// loc attribthreshold = .6
di "' 
*********************************************************
* Check if WGND is installed
*********************************************************
 confirm file "`wgndnamecodelangexp'"
 confirm file "`wgndnamecode'"
 confirm file "`wgndnamelangcode'"
 confirm file "`wgndnamenocode'"

*********************************************************
* Check vars & parameters
*********************************************************
* varlist
// loc varlist "myname mycode"
// di "`varlist'"
 tokenize `varlist' 
 loc name `1'
 loc code `2'
 confirm new var genderid
 if (`attribthreshold' <= .5 | `attribthreshold' >=1) {
  display "Attribthreshold has to be ~ (0.5, 1)"
  exit 121
  }
 
 
*********************************************************
* temp parameters & vars
*********************************************************
 tempfile prepfile appendfile
 tempvar myid
*********************************************************
* prepare files 
*********************************************************
 preserve
 // intermediary file -----------------------------
 qui egen genderid=group(`name' `code'), miss  // creates id
 qui save `prepfile', replace 
 // working file -----------------------------
 keep genderid `name' `code' // keeps only needed vars
 
 qui cap gduplicates drop // drops unnecessary data
 if _rc!=0 {
  di "Warning, install {it:gduplicates} from {search gtools: gtools} to make genderit faster"
  qui duplicates drop // drops unnecessary data
}
 
// renames vars in working file
 ren `name' name  
 // if ("`code'"!="") ren `code' code
 ren `code' code
 // clean names
 if ("`clean'"!="") genderit_nameclean name `mycleandegree'
  
 // stats
 loc basenum = _N

*********************************************************
* Iterate
*********************************************************


************** STEP 1-3 names 1-3 & = wgnd_2_1_name-code-gender-wide ******************************
if ("`clean'"=="") genderit_steps name code `wgndnamecode' fullname-ctry `appendfile'
else {
genderit_steps name1 code `wgndnamecode' fullname-ctry `appendfile'
genderit_steps name2 code `wgndnamecode' fullname-ctry `appendfile'
genderit_steps name3 code `wgndnamecode' fullname-ctry `appendfile'
}
qui count
loc curshare = `r(N)'/`basenum'*100
di "Remaining unmatched after fullname-ctry step: `curshare'%"

// describe using `appendfile'

************** STEP 4-6 names 1-3 = wgnd-name-code-langexp.dta ******************************
if ("`clean'"=="") genderit_steps name code `wgndnamecodelangexp' fullname-langexp `appendfile'
else {
genderit_steps name1 code `wgndnamecodelangexp' fullname-langexp `appendfile'
genderit_steps name2 code `wgndnamecodelangexp' fullname-langexp `appendfile'
genderit_steps name3 code `wgndnamecodelangexp' fullname-langexp `appendfile'
}
qui count
loc curshare = `r(N)'/`basenum'*100
di "Remaining unmatched after fullname-ctry (language expansion) step: `curshare'%"

************** STEP 7-9 names 1-3 = wgnd_2_0_name-gender_nocode ******************************
if ("`clean'"=="") genderit_steps name "" `wgndnamenocode' fullname-noctry `appendfile'
else {
genderit_steps name1 "" `wgndnamenocode' fullname-noctry `appendfile'
genderit_steps name2 "" `wgndnamenocode' fullname-noctry `appendfile'
genderit_steps name3 "" `wgndnamenocode' fullname-noctry `appendfile'
}
qui count
loc curshare = `r(N)'/`basenum'*100
di "Remaining unmatched after fullname (no ctry) step: `curshare'%"

// describe using `appendfile'


* Name splitting ****************************************************************************
if ("`namesplit'"!="") {
 if ("`clean'"=="") {
  genderit_namesplit name 
  }
 else genderit_namesplit name1 
	forv x = 1 (1) 4 {
	************** STEP 11-13 names 11-13 & = wgnd_2_1_name-code-gender-wide ******************************
 if ("`clean'"=="") genderit_steps name`x' code `wgndnamecode' name`x'-ctry `appendfile'
 else {
	genderit_steps name1`x' code `wgndnamecode' name`x'-ctry `appendfile'
	qui gen name1`x'2 = ustrto(ustrnormalize(name1`x', "nfd"), "ascii", 2) // name2 = ascii propagation  
	genderit_steps name1`x'2 code `wgndnamecode' name`x'-ctry `appendfile'
	qui gen name1`x'3 = strtrim(stritrim(ustrregexra(name1`x'2, "[^a-z]", " ", 1))) // name3 = ascii clean propagation  
	genderit_steps name1`x'3 code `wgndnamecode' name`x'-ctry `appendfile'
 }	
    qui count
	loc curshare = `r(N)'/`basenum'*100
	di "Remaining unmatched after name`x'-ctry step: `curshare'%"

	************** STEP 14-16 names 11-13 = wgnd-name-code-langexp.dta ******************************
 if ("`clean'"=="") genderit_steps name`x' code `wgndnamecodelangexp' name`x'-langexp `appendfile'
 else {
	genderit_steps name1`x' code `wgndnamecodelangexp' name`x'-langexp `appendfile'
	genderit_steps name1`x'2 code `wgndnamecodelangexp' name`x'-langexp `appendfile'
	genderit_steps name1`x'3 code `wgndnamecodelangexp' name`x'-langexp `appendfile'
}
	qui count
	loc curshare = `r(N)'/`basenum'*100
	di "Remaining unmatched after name`x'-ctry (language expansion) step: `curshare'%"

	************** STEP 17-19 names 11-13 = wgnd_2_0_name-gender_nocode ******************************
 if ("`clean'"=="") genderit_steps name`x' "" `wgndnamenocode' name`x'-noctry `appendfile'
 else {
	genderit_steps name1`x' "" `wgndnamenocode' name`x'-noctry `appendfile'
	genderit_steps name1`x'2 "" `wgndnamenocode' name`x'-noctry `appendfile'
	genderit_steps name1`x'3 "" `wgndnamenocode' name`x'-noctry `appendfile'
}
	qui count
	loc curshare = `r(N)'/`basenum'*100
	di "Remaining unmatched after name`x' (no ctry) step: `curshare'%"
	}

}

* ADD here Step langcode wgnd-name-langcode.dta

**************************************************************************************
*  WRAP-UP STAGE 
**************************************************************************************

 use `appendfile', clear
 qui merge 1:m genderid using `prepfile' , nogen
 qui drop genderid
 order gender* step, last
 qui mvencode gender*, mv(0) override

 ren gender* prob*
 qui gen gender = "" if step==""
 qui replace gender="F" if probF>=`attribthreshold'
 qui replace gender="M" if probM>=`attribthreshold'
 qui replace gender="U" if gender==""
 qui lab var gender "Most likely gender (>=`attribthreshold')"
 qui cap lab var probF "Likelihood of gender being F"
 qui cap lab var probM "Likelihood of gender being M"
 qui cap lab var probU "Likelihood of gender being U"
 qui cap lab var step "Attribution step"
  
// binarystats = "binarystats"
 if ("`binarystats'"!= "") {
  qui gen probFbin=probF+probU/2
  qui gen probMbin=probM+probU/2 
  qui gen genderbin = "" if step==""
  qui replace genderbin="F" if probFbin>=`attribthreshold'
  qui replace genderbin="M" if probMbin>=`attribthreshold' 
  qui lab var genderbin "Most likely gender (>=`attribthreshold', binary)"
  qui cap lab var probFbin "Likelihood of gender being F, binary"
  qui cap lab var probMbin "Likelihood of gender being M, binary" 
 }
  
 order gender* prob* step, last
 qui replace step = "UNATTRIBUTED" if step==""
 ta step, miss
 restore, not
end

**************************************************************************************
* GENDERIT_STEPS 
**************************************************************************************
cap program drop genderit_steps
program define genderit_steps
 args curname curcode dic step curfile
 qui ren `curname' name
 qui merge m:1 name `curcode' using `dic', keep(1 3) 
 qui ren name `curname' 
 preserve
 qui keep if _merge==3
 qui keep genderid gender*
 qui gen step="`step'"
 cap append using `curfile'
 qui save `curfile', replace
 restore  
 qui drop if _merge==3
 keep genderid code name*
end
**************************************************************************************
* GENDERIT_NAMESPLIT
**************************************************************************************
cap program drop genderit_namesplit
program define genderit_namesplit
 args fullname delim looplimit charlimit 
 if ("`delim'"=="") loc delim = " \-"
 if ("`looplimit'"=="") loc looplimit = 4
 if ("`charlimit'"=="") loc charlimit = 4
 loc myregex = "^([^`delim']+)[`delim']"
 forv x = 1 (1) `looplimit' {
  qui gen `fullname'`x' = ustrregexs(`x') if ustrregexm(`fullname', "`myregex'", 1)
  qui replace `fullname'`x' = "" if ustrlen(`fullname'`x')<`charlimit'  
  if (`x'==1) loc myregex = "`myregex'([^`delim']+)"
  else loc myregex = "`myregex'[`delim']([^`delim']+)"
}
qui ren `fullname' `fullname'0
end 
**************************************************************************************
* GENDERIT_NAMECLEAN
**************************************************************************************
cap program drop genderit_nameclean 
program define genderit_nameclean
 args dirtyname cleandegree
 // name1 = lower & trim 
 if (`cleandegree'>=1) qui gen `dirtyname'1 = ustrtrim(stritrim(ustrlower(`dirtyname')))
 // name2 = ascii propagation
 if (`cleandegree'>=2) qui gen `dirtyname'2 = ustrto(ustrnormalize(name1, "nfd"), "ascii", 2)
 // name3 = ascii clean propagation  
 if (`cleandegree'>=3) qui gen `dirtyname'3 = strtrim(stritrim(ustrregexra(name2, "`cleanregex'", " ", 1))) 
 // name0 = original 
 ren `dirtyname' `dirtyname'0
 
end 
