# World Gender-Name Dictionary (WGND)

This repository describes how we consolidated our world gender-name dictionary (WGND).

## WGND 2.0

Access the data on any of these links:
 - GitHub repository (coming soon in Git LFS or some similar solution to share big data in GitHub, for the moment we beg for your patience and use the links below)
 - [ies-r4r-public](https://ies-r4r-public.s3.eu-central-1.amazonaws.com/wgnd/wgnd_2_0.zip)
 - [Harvard Dataverse](https://dataverse.harvard.edu/dataverse/WGND)

Similar to the previous version, the WGND 2.0 contains six separate files:  

 1.	WGND 2.0 source contains 5,016,972 unique name-code-gender-src observations. This is the base file referring to the information from each specific group of sources detailed below.
 Whenever available, the file includes the frequencies for each name-code-gender per source.**_Not available in Github_**

 2.	WGND 2.0 name-gender-code contains 4,970,296 unique name-code-gender observations. It refers primarily to the unique combinations of name-code pairs. However, the inclusion of gender frequencies results in 633,201 name-code duplicated pairs, due to more than one gender found for the pair name-code. The resulting dataset contains 4,148,968 unique names, covering 195 countries and territories. **_Not available in Github_**

 3. WGND 2.0 name-gender (_i.e._ No code) contains 3,491,141 unique name observations. This file is based on WGND 2.0 name-gender-code but it omits all known conflicting names across sources, geography and gender. **_Not available in Github_**

 4.	WGND 2.0 name-gender-langcode contains 21,831,043 unique name-gender-langcode observations. It refers to the transformation of the non-conflicting name-code pairs in WGND 2.0 name-gender-code to all territories speaking the same language. The transformation uses the WGND 2.0 code-langcode list. Conflicting name-gender within each language are ignored. The resulting dataset contains 3,505,319 names covering 94 different languages.**_Not available in Github_**

 5.	WGND 2.0 name-gender-code (Language expansion) contains 26,043,223 unique name-code-gender observations. It refers to the expansion of the non-conflicting name-code pairs to all countries and territories speaking the same languages. The expansion is based in propagating the results in WGND 2.0 name-gender-langcode to all known places speaking those languages using the WGND 2.0 code-langcode list. The resulting dataset contains 3,505,319 unique names, covering 191 countries and territories.**_Not available in Github_**

 6.	WGND 2.0 code-langcode contains 261 unique code-langcode observations. It permits the conversion from 193 different countries or territories (code) to 96 different “macrolanguages” (langcode).


 Variables contained in these files are as follows:

 -	name: Given name (lowercase utf8 string). It may be single (“Mary”) or composed (“Jean-Marc”), it may contain symbols such as accentuated chars (e.g. "ó") or name separators (e.g. “-”).

 -	code: Country or territory code (two uppercase chars), using the ISO 3166-1 alpha-2 standard.

 -	langcode: Language code (two lowercase chars), using the ISO 639-1 2-digit standard. The langcodes are imputed using the country or territory codes from each original source and the WGND 2.0 code-langcode list.

 -	wgt: Weight (ranging from 0 to 1) equal to the proportion of frequencies of each name-code-gender observation. The sum of wgt for the same name and code should equal one within the same source (although some small discrepancies may arise due to rounding errors).   

 -	nobs: Number of observations (ranging from 1 to ∞+) reflecting the frequency of name and gender in a given country or territory. These often refer census or population registration data, but not always. In some sources, the number represents more than one-year aggregations.

 -	src: Source grouping (string) as follows:

		- AM_gov (Armenia): National Statistical Service of the Republic of Armenia
		- AU_gov (Australia): Governments of New South Wales, Western Australia and South Australia.
		- AZ_web (Azerbaijan): Azerbaijan International, Cutebaby names, etc.
		- BE_gov (Belgium): Statistics Belgium (Stat Bel)
		- BG_gov (Republic of Bulgaria): National Statistical Institute
		- BR_web (Brazil): iHeartBrazil
		- CA_gov (Canada): Governments of Alberta, British Columbia and Ontario
		- CH_gov (Switzerland): Office Fédéral de la Statistique
		- CN_web (China): Multiple websites: Wikipedia, xh.5156edu.com, We Have Kids, Baby Names, Baby Names Direct, Behind the Name, Top 100 Baby Names Search, etc.
		- CZ_gov (Czech Republic): Czech Republic Statistical Office
		- DK_gov (Denmark): Denmark Stat (DST)
		- ES_gov (Spain): Spain’s National Institute of Statistics (INE)
		- FR_gov (France): INSEE
		- GB_gov (United Kingdom): Office for National Statistics of United Kingdom (ONS), National Records of Scotland, and Northern Ireland Statistics and Research Agency
		- HU_web (Hungary): University of Debrecen, Department of Hungarian Linguistics
		- IE_gov (Ireland): Central Statistics Office (CSO)
		- IN_web (India): Multiple websites: Wikipedia, Baby Names Direct, Indian Hindu Names.com, etc.
		- INT_gov (International): WIPO assemblies and seminar lists of names, WIPO colleagues, etc.
		- INT_web (International): Multiple websites: Wikipedia, Behind the name, Equivalent Given Names (Kankula and Phillips, 2011), EURONEWS, Michael J (2008), Vornamen Verzeichnis - Deutsch & International, etc.
		- JP_web (Japan): Multiple websites: World of Baby Names, Thought Co, etc.
		- KR_gov (Republic of Korea): Korean Name Statistics, Electronic Family Relationship System
		- ME_gov (Montenegro): Statistical Office of Montenegro
		- MK_gov (Republic of North Macedonia): National Statistical Office
		- NO_gov (Norway): Statistics Norway
		- NZ_gov (New Zealand): Te Tari Taiwhenua / Department of Internal Affairs
		- PH_gov (The Philippines): National Statistics Office, Gender and Development Committee (GCOM)  
		- RS_gov (Serbia): Statistical Office of the Republic of Serbia
		- RU_web (Russian Federation): Multiple websites: Wikipedia, Master Russian, etc.
		- SE_gov (Sweden): Statistics Sweden (SCB)
		- SI_gov (Slovenia): Statistical Office (RS)
		- TR_gov (Turkey): Turkish Statistical Institute  
		- UA_web (Ukraine): Multiple websites: Wikipedia, Proud of Ukraine, etc.
		- US_gov (United States): Social Security Administration (SSA)
		- US_web (United States): Multiple websites: Wikipedia, Tang et al. (2011), etc.


## WGND 1.1

Access the data here:
 - [ies-r4r-public](https://ies-r4r-public.s3.eu-central-1.amazonaws.com/wgnd/wgnd_1_1.zip)

This version is basically the version 1.0 adapted for Github sharing and tools to be build upon.

## WGND 1.0

Access the data on any of these links:
 - [ies-r4r-public](https://ies-r4r-public.s3.eu-central-1.amazonaws.com/wgnd/wgnd_1_0.zip)
 - [https://www.wipo.int/edocs/pubdocs/en/wipo_pub_econstat_wp_33-tech1.zip](https://www.wipo.int/edocs/pubdocs/en/wipo_pub_econstat_wp_33-tech1.zip)
 - [Harvard Dataverse](https://doi.org/10.7910/DVN/YPRQH8)

From the raw sources below we consolidated the first public World Gender-Name Dictionary (WGND 1.0), which compiled the information from 14 different sources covering 173 different countries.
Whenever available, we have used the country reported by the source; and, if not available, we have used the origin of the source.
We also applied name gender semantics – based on honorific titles in English, French and Spanish – in order to attribute the gender to the list of participants in the Assemblies of the Member States of WIPO information (i.e. WIPO.dta in WGND 0.1).

These 14 sources totaled 319724 observations, which pair names and countries. Out of these, 174410 (54.55%) are attributed to female names and 123343 (54.55%) to male ones. The remaining 21971 (6.87%) have been regrouped as unisex or ambiguous cases. However, there is an approximately 9.29 overlap between sources, which reduces the final list of unique name-country pairs to 290020. It is worth noting that sources may conflict about the gender of certain names. However, we found only 2252 cases (.78%) of all name-country pairs with conflicting gender across sources. We also observe a certain redundancy of names across countries, as only 185924 (64.11%) names are unique in our data. Out of these, 8882 (4.78%) names have conflicting gender across countries. Nevertheless, such divergence is to be expected due to different customs in different languages – e.g. “ANDREA” being a male name in Italian but a female name in Spanish. Please note that the few listed names having only one character or a combination of separate single characters were ignored.

We provide four different versions of our WGND dictionary: *WGND_source*, *WGND_country*, *WGND_langcountry* and *WGND_nocountry*. All four versions of the WGND share the following common traits:

 - The column *name* includes all available names.
 - In the case of Romanized names, we have capitalized, removed any punctuation marks and replaced any accentuated characters by the non-accentuated version in the list. Instead, we left the non-Romanized names unchanged.
 - The column *name* include composite names, such as “MARIA TERESA” or “JESSE JAMES”.
 - The column *gender* refers to expected gender for each name-country pair (or any country in the case of WGND_nocountry).
 - The column *gender* is coded as female (“F”), male (“M”) and unknown (“?”).
 - The unknown (“?”) groups ambiguous and unisex names.
 - In the case of names in original Chinese or Korean characters, column *gchar1*, *gchar2* and *gchar12* inform if the gender information refers respectively to a first character, a second one or both (see Yu et al, 2014).
 - The column *code* refers to the country or region 2-digit code as referred in the original sources. This column is omitted in the case of *WGND_nocountry*.
 - The file *WGND_source* includes 14 variables (headed by *src_*) detailing the gender specified by each original source.

We provide all versions of the WGND on our website. The large amount of sources that comprises our dictionary allows users to get reliable results in the attribution of gender for a wide range of countries and nationalities. Moreover, users of the dictionary are able to choose the most relevant sources for the purposes of their studies.


1. *WGND_source*:

Contains all information from the original sources, including the conflicting cases, in one file.
Each pair of name and country is unique and gender is displayed by source in separate columns, such as:

```
name,code,gender,src_Albertagvt,src_INE,src_INSEE,src_Michael2007,src_Statistics_Denmark,src_Tang2011,src_UK_National_St,src_US_Census,src_US_SSA,src_WIPO,src_WIPO_manual,src_Wikipedia,src_Yu_et_al,src_statsweden,gchar12,gchar1,gchar2,gender_concordance
AARON,US,M,,,,M,,M,,B,M,,,,,,,,,
```

2. *WGND_country*:

Given that there is low conflicting gender attribution across sources, we also provide a version where only the most frequent name-gender pairs across sources is reported.

3. *WGND_langcountry*:

Given that there is relatively low conflicting gender attribution across countries, we also provide an additional version of our WGND final dictionary based on languages. In a nutshell, we expand the name-country pairs based on common language for 12 frequent languages, namely: Arabic, Dutch, English, French, German, Italian, Japanese, Korean, Portuguese, Russian, Spanish, and Chinese. These expand results for 108 different countries, while the other ones are kept without expansion. The resulting dataset contains 6,277,039 unique name-country pairs.

4. *WGND_nocountry*:

A second expansion is a dataset containing the unique 177,042 names which were non-conflicting across sources and countries.


## WGND 1.0 (raw sources)

The raw data for each source can be found here in Stata format: [s3://ies-rawdata-bucket/wgnd/wgnd_sources/sources_1.0/](s3://ies-rawdata-bucket/wgnd/wgnd_sources/sources_1.0/)

This version contains only the original gender-name information compiled from 14 different sources.
Most of these sources come from national public institutions or previous gender studies.
These sources were used for constructing the WGND 1.0, as decribed in Working Paper N°33:
[Identifying the gender of PCT inventors](https://www.wipo.int/publications/en/details.jsp?id=4125&plang=EN).

_**List of sources used:**_

|source | Freq. | Percent | Cum. |
|-------|-------|---------|------|
|US_SSA | 91,320 | 28.56 | 28.56 |
|Albertagvt | 87,528 | 27.38 | 55.94 |
|Michael2007 | 72,670 | 22.73 | 78.67 |
|UK_National_St | 34,204 | 10.70 | 89.37 |
|Tang2011 | 21,512 | 6.73 | 96.09 |
|US_Census | 5,164 | 1.62 | 97.71 |
|WIPO_manual | 2,439 | 0.76 | 98.47 |
|Wikipedia | 2,358 | 0.74 | 99.21 |
|WIPO | 980 | 0.31 | 99.52 |
|statsweden | 965 | 0.30 | 99.82 |
|INE | 200 | 0.06 | 99.88 |
|INSEE | 183 | 0.06 | 99.94 |
|Yu_et_al | 155 | 0.05 | 99.99 |
|Statistics_Denmark | 46 | 0.01 | 100.00 |
|Total | 319,724 | 100.00 |  |

*Notes: Some observations were dropped due to text cleaning or duplications;
(a) Alberta gov., UK ONS, Wikipedia, Stats Sweden, INE, and INSEE accessed in
December, 2015; (b) Denmark Statistics accessed in May, 2016; (c) WIPO
(Manual check) is an ad-hoc list.*
