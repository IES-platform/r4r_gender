# World Gender-Name Dictionary (WGND)

This repository describes how we consolidated our world gender-name dictionary (WGND). 

## WGND 2.0

Access the data on any of these links:
 - [ies-r4r-public](https://ies-r4r-public.s3.eu-central-1.amazonaws.com/wgnd/wgnd_2_0.zip)
 - [Harvard Dataverse](coming soon)

## WGND 1.1

Access the data here in GitHub:
 - [wgnd_v1.1.csv](https://github.com/IES-platform/r4us/blob/81ce7946b5e1714d27f4637a3d50d723ccd8e88d/code/gender/wgnd/dictionary_source_v1.1.csv)
 - [wgndlang_v1.1.csv](https://github.com/IES-platform/r4us/blob/81ce7946b5e1714d27f4637a3d50d723ccd8e88d/code/gender/wgnd/code_langcode_code_v1.1.csv)
 
 or here:
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




