{smcl}
{* *! version 2.0  Aug 2024}{...}
{viewerjumpto "Syntax" "genderit##syntax"}{...}
{viewerjumpto "Description" "genderit##description"}{...}
{viewerjumpto "Options" "genderit##options"}{...}
{viewerjumpto "Examples" "genderit##examples"}{...}
{viewerjumpto "Installation" "genderit##install"}{...}
{viewerjumpto "References" "genderit##references"}{...}
{marker Top}{...}
{title:Title}

{p2colset 5 18 20 2}{...}
{p2col :Genderit {hline 2}} Attributes gender based on given names and countries{p_end}
{p2colreset}{...}

{marker syntax}{...}
{title:Syntax}

{p 5 15}
{cmd:genderit} {it:NameVariable CodeVariable}
[{it:, options}]
{p_end}

{p 5 15}
{it: where NameVariable is a str variable containing given names and CodeVariable is a str2 variable containing ISO2 country codes}
{p_end}


{synoptset 20 tabbed}{...}
{synoptline}
{syntab :}
{synopthdr}
{synoptline}
{synopt :{opt c:lean}}
Adds clean versions of {it:NameVariable} to increase attribution. 
Namely, (1) normalizes cases and remove double spaces, 
(2) removes punctuation marks, and 
(3) removes non latin characters.
{it:genderit} attempts to attribute gender based on these three and the original raw variable.
{p_end}

{synopt :{opt b:inarystats}}
Recomputes probabilities scores considering only F & M categories.
{p_end}

{synopt :{opt n:amesplit}}
Splits {it:NameVariable} and attempts to attribute the separated given names.
It can be combined with {it:clean}. 
{it:genderit} attempts to attribute gender based on the separated names only after attempting the original variable.
{p_end}


{synopt :{opt a:ttribthreshold(real .6)}}
In addition to probabilities by gender, {it:genderit} computes {it:gender} a final result based on a given threshold.
For instance any observation with an probF >= {it:attribthreshold} will be labeled as F. 
Default is .6. 
If used with {it:clean} an additional variable {it:genderbin}.
{p_end}

{synoptline}

{marker description}{...}
{title:Description}

{pstd}
{cmd:genderit} attributes gender based on given names and countries for each observation.
It returns a label variable ({it:gender}) containing the most likely gender. 
It also reports the likelihood of all genders ({it:probF, probM and probU}), which range from 0 to 1.
All these variables may also be reported in binary mode (i.e. ignoring the unknow or unisex likelihods).
{p_end}

{pstd}
It relies on the World Gender Name Dictionary (WGND 2.0) as reported in 
{browse "https://www.wipo.int/publications/en/details.jsp?id=4554&plang=EN":Lax-Martinez {it:et al.} (2021)}
and method reported in 
{browse "https://www.wipo.int/publications/en/details.jsp?id=4125&plang=EN":Lax-Martinez {it:et al.} (2016)}.
{p_end}

{pstd}
It requires to install the WGND before utilisation. See next section for details.
{p_end}

{pstd}
Genderit is faster when {search gtools:gtools} is installed.
{p_end}

{synoptline}

{marker examples}{...}
{title:Examples:}

{phang2}{cmd:. genderit} {it:mynames mycode}

{phang2}{cmd:. genderit} {it:mynames mycode , clean}

{phang2}{cmd:. genderit} {it:mynames mycode , clean binary}

{synoptline}

{marker install}{...}
{title:Installation}

{pstd}
To install {it:genderit} from GitHub: 
{p_end}

{phang2}. {net "from https://raw.githubusercontent.com/IES-platform/r4r_gender/master/genderit/STATA/":net from "https://raw.githubusercontent.com/IES-platform/r4r_gender/master/genderit/STATA/"}

{phang2}. {net install genderit:net install genderit}


{pstd}
To install the WGND run the command {it:genderit_install_wgnd}, after installing {it:genderit}:
{p_end}


{phang2}. {stata genderit_install_wgnd:genderit_install_wgnd} {it: [, REPlace Source(wipo2)]}

{synoptset 25 tabbed}{...}
{synoptline}
{synopthdr: install wgnd options}
{synoptline}

{synopt :{opt rep:lace}}
Replaces any WGND dictionary existing. 
If ommitted, by default, {it:genderit_install_wgnd} skips preexisting WGND files already installed.
{p_end}

{synopt :{opt s:ource(sourcename)}}
Default is {it:s(wipo2)}. Available sources are: {break}
- wipo2 (WGND 2.0 hosted at WIPO) {break}
- harvard2 (WGND 2.0 hosted at Harvard Dataverse) {break}
- harvard1 (WGND 1.0 hosted at Harvard Dataverse) {break}
- wipo1 (WGND 1.0 hosted at WIPO). {break}

{p_end}

{synoptline}

{marker references}{...}
{title:References}

{pstd}
Gema Lax Martínez, Helena Saenz de Juano-i-Ribes, Deyun Yin, Bruno Le Feuvre, 
Intan Hamdan-Livramento, Kaori Saito, Julio Raffo 
Expanding the World Gender-Name Dictionary: WGND 2.0 
Economic Research Working Paper No. 64, 2021.
{browse "www.wipo.int/publications/en/details.jsp?id=4554&plang=EN"}.
{p_end}

{pstd}
Gema Lax Martínez, Julio Raffo, Kaori Saito 
Identifying the gender of PCT inventors
Economic Research Working Paper No. 33, 2016.
{browse "www.wipo.int/publications/en/details.jsp?id=4125&plang=EN"}.
{p_end}
