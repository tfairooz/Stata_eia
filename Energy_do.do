import excel "/Users/tahsinfairooz/Desktop/Szabo_IO/Assignment_5 /Energy_data/HS861 1990-2009.xlsx", sheet("1990-2009") firstrow
save 1990, replace
clear
import excel "/Users/tahsinfairooz/Desktop/Szabo_IO/Assignment_5 /Energy_data/2010-2021.xlsx", sheet("2010-2021") firstrow
save 2021, replace 

**To get the compiled dataset from 1990-2021
sysuse 1990, clear
append using 2021
save final, replace 

*** after importing run from here ** 

clear
sysuse final

** Reg states reg=1 de-reg=0
gen reg=.
replace reg=1 if STATE=="MN" 
replace reg=1 if STATE=="AL"  

replace reg=1 if STATE=="AR" & Year>=2003
replace reg=0 if STATE=="AR" & Year<2003

replace reg=1 if STATE=="WV"
replace reg=1 if STATE=="CO"
replace reg=1 if STATE=="KS"
replace reg=1 if STATE=="KY"
replace reg=1 if STATE=="OK"
replace reg=1 if STATE=="NV"
replace reg=1 if STATE=="NC"
replace reg=1 if STATE=="ID" 
replace reg=1 if STATE=="TN"
replace reg=1 if STATE=="ND"
replace reg=1 if STATE=="WA"
replace reg=1 if STATE=="SD"
replace reg=1 if STATE=="MT"
replace reg=1 if STATE=="IA"
replace reg=1 if STATE=="MS"
replace reg=1 if STATE=="HI"  
replace reg=1 if STATE=="MO"
replace reg=1 if STATE=="UT"

replace reg=0 if STATE=="AZ" 
replace reg=1 if STATE=="AZ" & Year==2004

replace reg=1 if STATE=="AZ" 
replace reg=1 if STATE=="GA" 
replace reg=1 if STATE=="AK"
replace reg=1 if STATE=="IN"
replace reg=1 if STATE=="NM"
replace reg=1 if STATE=="SC"
replace reg=1 if STATE=="FL" 
replace reg=1 if STATE=="NE"
replace reg=1 if STATE=="WY"
replace reg=1 if STATE=="VT"
replace reg=1 if STATE=="WI"
replace reg=1 if STATE=="LA"

replace reg=0 if STATE=="IL" & Year>=1997  
replace reg=1 if STATE=="IL" & Year<1997

replace reg=1 if STATE=="OR" & Year<1997  
replace reg=0 if STATE=="OR" & Year>=1997


replace reg=0 if STATE=="NJ" & Year>=1999 
replace reg=1 if STATE=="NJ" & Year<1999


replace reg=0 if STATE=="TX" & Year>=2002
replace reg=1 if STATE=="TX" & Year<2002
replace reg=0 if STATE=="RI" & Year>=1996
replace reg=1 if STATE=="RI" & Year<1996

replace reg=0 if STATE=="MA" & Year >=1998  
replace reg=1 if STATE=="MA" & Year <1998
replace reg=0 if STATE=="OH" & Year>=1996  
replace reg=1 if STATE=="OH" & Year<1996

replace reg=1 if STATE=="MI" & Year<1998  
replace reg=0 if STATE=="MI" & Year>=1998

replace reg=0 if STATE=="DE" & Year>=1999  
replace reg=1 if STATE=="DE" & Year<1999

replace reg=0 if STATE=="ME" & Year>=2000 
replace reg=1 if STATE=="ME" & Year<2000

replace reg=0 if STATE=="VA" & Year>=2007
replace reg=1 if STATE=="VA" & Year<2007

replace reg=0 if STATE=="PA" & Year>=1996
replace reg=1 if STATE=="PA" & Year<1996

replace reg=0 if STATE=="NH" & Year>=1998   
replace reg=1 if STATE=="NH" & Year<1998

replace reg=1 if STATE=="NY" & Year<1997  
replace reg=0 if STATE=="NY" & Year>=1997
replace reg=0 if STATE=="CA"  

replace reg=0 if STATE=="DC" & Year>=2001
replace reg=1 if STATE=="DC" & Year<2001

replace reg=0 if STATE=="CT" & Year>=1998  
replace reg=1 if STATE=="CT" & Year<1998

replace reg=1 if STATE=="MD" & Year<1999  
replace reg=0 if STATE=="MD" & Year>=1999

** creating average price for each year
sort Year 
** fo regulated States
by Year: egen avg_price=mean(Price) if reg==1
label variable avg_price "Regulated Markets"
by Year: egen avg_price2=mean(Price) if reg==0
label variable avg_price2 "De-Regulated Markets"

** to visualize 
line avg_price avg_price2 Year


clear 
