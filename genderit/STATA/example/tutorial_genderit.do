* First, let's install genderit following the instructions here: 
net from "https://raw.githubusercontent.com/IES-platform/r4r_gender/master/genderit/STATA/"
net install genderit
genderit_install_wgnd


* Import the data sample - make sure it is in the same folder as this do-file. 
import delimited "name_country.csv", varnames(1) encoding(UTF-8) 

* Prepare the name variable. Here it is the full name, and we remove unecessary spaces at the beginning and the end of the name, the double spaces in the middle and pass it all in lowercase: 
gen name_clean = itrim(trim(ustrlower(name)))


* Let's have a look at the command specifications: 
help genderit

* First attempt: genderit without further options: 
	genderit name_clean country_code
	drop gender probF probM probU step
	* we drop the variables to run the command again; if you'd like to keep them, 
	* you can just rename them.  

* Second attempt: adding the "clean" option: 
	genderit name_clean country_code, clean
	* (since we already cleaned a bit the name, it doesn't improve substantially
	*the outcome)
	drop gender probF probM probU step

* Third attempt: adding the "namesplit" option: 
	genderit name_clean country_code, namesplit clean
	/* Genderit will first try finding the full name (as before), then split the 
	three first words (separated by spaces) and try them in order of appearance. 
	For instance, for the name "Ulf Fredrik Mikael", genderit will search for "Ulf",
	then "Fredrik", and finally "Mikael". The search will stop immediately after
	finding a match. */

	tab gender

* Fourth attempt: adding "binarystats" option: 
	genderit name_clean country_code, namesplit clean binarystats
	/* this option does not affect the number of names that are found in the 
	dictionary, hence the number of "UNATTRIBUTED" in the "step" variable remain 
	identical. It changes the way probabilities are used to determine the gender. 
	Without this option, each name has three probabilities that sum to 1: one for
	male (probM), one for female (probF), and one for ambiguous (probU). The default
	threshold is .6, so that for each name, if probF is above .6, then gender takes
	value "F", else if probM is above .6 then gender takes value "M", else it takes 
	value "U". 
	Now, with the "binarystats" option, probabilities are computed differently, 
	with just "M" and "F" summing to 1. Accordingly, the command will produce three 
	more variables: probMbin, probFbin, and genderbin. 
	*/
	tab gender
	tab genderbin

* Fifth attempt: specifying a different threshold for gender assignement: 
	genderit name_clean country_code, namesplit clean binarystats attribthreshold(.8)
	* OR genderit name_clean country_code, c n b a(.8)
	* again, changing the threshold should not affect matches, but only gender and
	* genderbin.
	
	tab gender
	tabstat probF probM probU, s(sum)
	tabstat probFbin  probMbin , s(sum)

* alternatively, compute gender counts by summing the probabilities of each gender:
graph bar (sum) probFbin probMbin, percentages stack legend( label(1 "Women") label(2 "Men"))
















