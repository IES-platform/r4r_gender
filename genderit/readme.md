# Install GenderIt in Stata

## 1. Install  _genderit_ ado and related tools

 Run the code below in Stata to install _genderit_ from Github

````
net from "https://raw.githubusercontent.com/IES-platform/r4r_gender/master/genderit/"
net install genderit
````

## 2. Install the WGND dictionaries

Run _genderit_install_wgnd.ado_ in Stata to install the latest WGND dictionary and convert it to Stata.

(Patience, it may take several minutes, but it is only once)
````
genderit_install_wgnd.ado

````

## 3. Start using _genderit_ !!!
