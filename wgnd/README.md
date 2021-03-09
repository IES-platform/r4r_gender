# World Gender-Name Dictionary (WGND)

 The dictionary was created for our Working Paper N°33: [Identifying the gender of PCT inventors](https://www.wipo.int/publications/en/details.jsp?id=4125&plang=EN).

We believe the WGND is a valuable contribution to the gender studies community, although there is always room for further improvement. We intend to update the dictionary to increase even more its international coverage. 

The first challenge we faced in order to attribute gender was to get a gender-name dictionary with worldwide coverage. For this reason, we compiled 13 different sources of gender-name dictionaries, which combined, cover 173 different countries. 

Most of the sources used for this study come from national public institutions.

## Contents

### Data

- `wgnd_source.csv`: Country level names with gender based on each data source. 

    Columns: Name, Country, Gender (Source 1), Gender (Source 2)...

- `wgnd_ctry.csv`: Country level gendered names with **no conflicts between sources**. 

    Columns: Name, Country, Gender.

- `wgnd_noctry.csv`: Gendered names with **no conflicts between countries**. 

    Columns: Name, Gender.

> Note: Additional columns `gchar12`, `gchar1`, `gchar2` serve for identifying gender in asian ideograms.


### Methodology

- Data Cleansing. Available in [Stata]().

### Visualizations

- To do.

## Releases

- [1.0](). Date. Description.

## Contributing on this project

1. Take a look at the [current issues](https://github.com/IES-platform/prj_gender/issues) to see if you can contribute on any of them. 

2. If your contribution is new, proceed to [create an issue](https://github.com/IES-platform/prj_gender/issues/new). Try to follow our templates.

    - Bug report. *Help us fix whats broken*.
    - Feature request. *Suggest ideas and improvements for the project*.

3. When you are done, create a pull request following the pull request template. 

