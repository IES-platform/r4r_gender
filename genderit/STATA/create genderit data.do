
// Install genderit
net from "https://raw.githubusercontent.com/IES-platform/r4r_gender/master/genderit/STATA/"
net install genderit

// Install WGND dictionaries 
genderit_install_wgnd // WGND 2.0 (default)

// Alternative sources for WGND dictionaries
genderit_install_wgnd , s(wipo2) // WGND 2.0 (default)
genderit_install_wgnd , s(harvard2) // WGND 2.0
genderit_install_wgnd , s(wipo1) // WGND 1.0 (legacy)
genderit_install_wgnd , s(harvard1) // WGND 1.0 (legacy)


// test genderit 
clear 
input str20 name str2 ctry
juan AR
maria MX
jean FR
marie CA
john US
mary GB
joao PT
maria BR
andrea IT
andrea US
andrea ES
edelt DE
edeltraud AT
edelfried CH
end

genderit name ctry, b


