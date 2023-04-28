# Install GenderIt in Stata

## 1. Install  _genderit_ ado and related tools

 Run the code below in Stata to install _genderit_ from Github

````
net from "https://raw.githubusercontent.com/IES-platform/r4r_gender/master/genderit/STATA/"
net install genderit
````

## 2. Install the WGND dictionaries

Run _genderit_install_wgnd.ado_ in Stata to install the latest WGND dictionary and convert it to Stata.

(Patience, it may take several minutes, but it is only once)
````
genderit_install_wgnd

````

## 3. Start using _genderit_ !!!

- See an example here: [tutorial_genderit.do]example\tutorial_genderit.do)

## 4. Troubleshooting

Sometimes a firewall may prevent STATA from correctly installing _genderit_ or the WGND dictionaries.
Alternatively, you can:

1. Download both _genderit_ and the WGND manually from: [genderit_wgnd_2_0.zip](https://ies-r4r-public.s3.eu-central-1.amazonaws.com/wgnd/dta/genderit_wgnd_2_0_dta.zip)

2. In Stata run `sysdir` and get the path of the PLUS system directory.

3. Save extracted contents of _genderit_wgnd_2_0.zip_ to the path found in (2) within the folder "g" (e.g. C:\ado\plus\g). 
If there is no "g" folder, create it. 

