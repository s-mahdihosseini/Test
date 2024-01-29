clear all

set fredkey 5c91656612f67a6ff6d6991a8a72c276

// Ricardo Directory
cd "/Users/reisr/Dropbox/08ras/RA-MarinaSeyed/Gaugust2013/Fig_r"

// Seyed Directory
*cd "D:\Dropbox\Dropbox\Projects\Ricardo\RA-MarinaSeyed\Gaugust2013\Fig_r"
	
///////////////////////////////// Graph style /////////////////////////////////
    * ssc install grstyle
    set scheme s2color
    grstyle init

    grstyle color background white
    // gridlines
    grstyle color major_grid dimgray
    grstyle linewidth major_grid thin
    grstyle yesno draw_major_hgrid yes
    grstyle yesno grid_draw_min yes
    grstyle yesno grid_draw_max yes
    grstyle anglestyle vertical_tick horizontal grstyle color ci_area gs12%50
    // legend
    grstyle clockdir legend_position 6
    grstyle numstyle legend_cols 2
    grstyle linestyle legend none
///////////////////////////////////////////////////////////////////////////////


///// USA

*** Import Data
*load data
import fred DFII10 DFII5 DGS2
tsset daten

keep if daten >= mdy(1, 1, 2010)
gen R_5_5=(((1+DFII10/100)^10/(1+DFII5/100)^5)^(0.2)-1)*100

save USdata, replace


use USdata, clear

keep if daten >= mdy(1, 1, 2017)

line R_5_5 DFII10 daten, title("US") xtitle("Date") ytitle("%") ylabel(-2(0.5)3) name(g1,replace) lp(dash solid) lw(thick thick) tlabel(, format(%tdCY)) legend(pos(11) ring(0) col(2) order(1 "5-year-5-year" 2 "10 year") )
graph export "fig_r_a.png", as(png) replace

outsheet R_5_5 DFII10 daten using figure6us.csv, replace


//line DGS2 R_5_5  daten, xtitle("Date") ytitle("%") title("USA") name(g1,replace) lw(medium) tlabel(, format(%tdCY)) legend(order(1 "2 Year Real Yeild" 2 "5Year-5 Year Real Yeild") )
//graph export "fig_r_a.png", as(png) replace


///// UK

/*load data

import excel "GLC Real daily data_2005 to 2015.xlsx", sheet("3. spot, short end") cellrange(A7) clear

keep A B

rename A date 
rename B Two_Year_UK

save twoyear_pre2015,replace

import excel "GLC Real daily data_2005 to 2015.xlsx", sheet("4. spot curve") cellrange(A7) clear
rename Q Ten_Year_UK
rename G Five_Year_UK
rename A date
keep Ten_Year_UK Five_Year_UK  date

merge 1:1 date using twoyear_pre2015

save UK_2005_2015,replace

import excel "GLC Real daily data_2016 to present.xlsx", sheet("3. spot, short end") cellrange(A7) clear

keep A B

rename A date 
rename B Two_Year_UK

drop if date==.

save twoyear_post2015,replace

import excel "GLC Real daily data_2016 to present.xlsx", sheet("4. spot curve") cellrange(A7) clear
rename Q Ten_Year_UK
rename G Five_Year_UK
rename A date
keep Ten_Year_UK Five_Year_UK  date

merge 1:1 date using twoyear_post2015

append using UK_2005_2015,force 


sort date

drop if Five_Year_UK==.
keep if date >= mdy(1, 1, 2010)
format date %td

gen fiveyfivey_UK=(((1+Ten_Year_UK/100)^10/(1+Five_Year_UK/100)^5)^(0.2)-1)*100

format Two_Year_UK fiveyfivey_UK %9.0f

save UKdata, replace
*/
u UKdata, clear

keep if date >= mdy(1, 1, 2017)


line fiveyfivey_UK Ten_Year_UK date, title("UK") xtitle("Date") ytitle("%") ylabel(-3(1)2) name(g2,replace) lp(dash solid) lw(thick thick) tlabel(, format(%tdCY)) legend(pos(11) ring(0) col(2) order(1 "5-year-5-year" 2 "10 year") )
graph export "fig_r_b.png", as(png) replace

outsheet fiveyfivey_UK Ten_Year_UK date using figure6uk.csv, replace
