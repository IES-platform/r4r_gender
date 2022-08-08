{smcl}
{* *! version 0.1  Aug 2022}{...}
{vieweralsosee "[D] merge" "mansection D merge"}{...}
{vieweralsosee "[D] append" "help append"}{...}
{vieweralsosee "[D] joinby" "help joinby"}{...}
{viewerjumpto "Syntax" "genderit##syntax"}{...}
{viewerjumpto "Description" "genderit##description"}{...}
{viewerjumpto "Options" "genderit##options"}{...}
{viewerjumpto "Examples" "matchit##examples"}{...}
{viewerjumpto "Remarks" "matchit##remarks"}{...}
{viewerjumpto "Tips" "genderit##tips"}{...}
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
{synopt :{opt C:lean}}
Adds clean versions of {it:NameVariable} to increase attribution. 
Namely, (1) normalizes cases and remove double spaces, 
(2) removes punctuation marks, and 
(3) removes non latin characters.
{it:genderit} attempts to attribute gender based on these three and the original raw variable.
{p_end}

{synopt :{opt B:inarystats}}
Recomputes probabilities scores considering only F & M categories.
{p_end}

{synopt :{opt N:amesplit}}
Splits {it:NameVariable} and attempts to attribute the separated given names.
It can be combined with {it:clean}. 
{it:genderit} attempts to attribute gender based on the separated names only after attempting the original variable.
{p_end}


{synopt :{opt A:ttribthreshold(real .6)}}
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
It relies on the World Gender Name Dictionary (WGND 2.0) as reported in Lax-MArtinez et al (2021).
See {it:https://www.wipo.int/publications/en/details.jsp?id=4554&plang=EN}.
{p_end}

{synoptline}

{marker examples}{...}
{title:Examples:}

{phang2}{cmd:. genderit} {it:mynames mycode}

{phang2}{cmd:. genderit} {it:mynames mycode , clean}

{phang2}{cmd:. genderit} {it:mynames mycode , clean binary}

{synoptline}

{marker references}{...}
{title:References}

{pstd}
Gema Lax Martínez, Helena Saenz de Juano-i-Ribes, Deyun Yin, Bruno Le Feuvre, Intan Hamdan-Livramento, Kaori Saito, Julio Raffo 
Expanding the World Gender-Name Dictionary: WGND 2.0 
Economic Research Working Paper No. 64, 2021
{p_end}

{pstd}
Gema Lax Martínez, Julio Raffo, Kaori Saito 
Identifying the gender of PCT inventors
Economic Research Working Paper No. 33, 2016