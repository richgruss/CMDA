PEW RESEARCH CENTER SURVEY, Social Trends Reports
Feb 8-March 7, 2006
National Sample: N=2,250

PLEASE NOTE: 

The WEIGHT variable is the weighting variable intended for use on all questions.


**PST306 Created Variables in SPSS syntax.

*Q9CNT.
COUNT Q9cnt=Q9A TO Q9O (1).
VAR LABEL Q9cnt "Count of Yes responses for Q9 series - Activities in past 12 months".
formats q9cnt (f2.0).
fre q9cnt.

*MINORS.
compute minors=0.
if HH2=1 and range(HH1,2,98) minors=1.
if HH1=1 minors=2.
if HH2=2 and MARITAL=1 and range(HH1,3,98) minors=3.
if HH2=2 and MARITAL=1 and HH1=2 minors=4.
if HH2=2 and range(MARITAL,2,7) and range(HH1,3,98) minors=5.
if HH2=2 and range(MARITAL,2,7) and HH1=2 minors=6.
if range(HH2,3,98) and hh1>hh2 minors=7.
if range(HH2,3,98) and hh1=hh2 minors=8.
if HH1=99 or HH2=99 or MARITAL=9 minors=9.
var labels minors "Households with minors - combined hh1/hh2/MARITAL".
value labels minors 1 "Single adult hh w/ minors" 2 "Single adult hh w/o minors" 3 "2 Adult hh married w/ minors" 4 "2 Adult hh married w/o minors"
5 "2 Adult hh unmarried w/ minors" 6 "2 Adult hh unmarried w/o minors" 7 "3+ Adult hh w/ minors" 8 "3+ Adult hh w/o minors" 9 "Dk/ref.".
fre minors.

*HH.
compute hh=0.
if hh1=1 or hh2=1 hh=1.
if hh2=2 hh=2.
if hh2=3 hh=3.
if hh2=4 hh=4.
if range(hh2,5,98) hh=5.
if hh1=99 or hh2=99 hh=9.
var labels hh "Number of adults in household - combined HH1/HH2".
value labels hh 1 "Respondent only adult" 2 "Two adults" 3 "Three adults" 4 "Four" 5 "Five or more" 9 "DK/Ref.".
fre hh.

*GEN.
compute gen=0.
if USBORN1A=2 and USBORN2=2 gen=1.
if any(USBORN1A,1,3,4) and USBORN2=2 gen=2.
if any(USBORN1A,1,3,4) and USBORN2=1 gen=3.
if USBORN1A=2 AND USBORN2=1 gen=4.
if USBORN1A=9 or USBORN2=9 gen=9.
var labels gen "Generation based on USBORN series".
value labels gen 1 "1st Generation" 2 "2nd Generation" 3 "3rd Generation or more" 4 "Other" 9 "DK/Ref.".
fre gen.


*BMI.
FRE Q45FT.
FRE Q45IN.
FRE Q44.

COMPUTE HEIGHT=(Q45FT*12)+Q45IN.
FRE HEIGHT.
LIST VAR Q45FT Q45IN HEIGHT /CASES BY 20.

IF (Q45FT=999 OR Q45IN=999) HEIGHT=999.
RECODE HEIGHT (999=SYSMIS).
FRE HEIGHT.

TEMP.
SELECT IF (HEIGHT>=75).
LIST VAR Q45FT Q45IN HEIGHT.

COMPUTE BMI=(Q44/HEIGHT/HEIGHT)*703.
IF (Q44=999) BMI=999.
RECODE BMI (999=SYSMIS).
FORMATS BMI (F6.4).
FRE BMI.

TEMP.
SELECT IF (BMI>=50).
LIST VAR psraid sex Q45FT Q45IN HEIGHT Q42 Q43 Q44 q46.

COMPUTE BMISCALE=0.
IF (RANGE(BMI,0,18.5999)) BMISCALE=1.
IF (RANGE(BMI,18.6,24.9999)) BMISCALE=2.
IF (RANGE(BMI,25,29.9999)) BMISCALE=3.
IF (RANGE(BMI,30,116)) BMISCALE=4.
IF q44=999 or q45in=999 or q45ft=999 BMISCALE=9.
recode bmiscale (0=sysmis).
VALUE LABELS
BMISCALE 1 "Underweight" 2 "Normal" 3 "Overweight" 4 "Obese" 9 "Don't know/Refused".
FRE BMISCALE.


*IDEALDIF.
FRE q44 q46.
recode q44 (999=0)(else=copy) into q44rec.
variable labels q44rec "Recoded Q44 for BMI scale".
recode q46 (999=0)(else=copy) into q46rec.
variable labels q46rec "Recoded Q46 for BMI scale".
fre q44rec q46rec.

compute idealdif=q44rec-q46rec.
variable labels idealdif "Ideal Weight Difference".
fre idealdif.

if q44=999 or q46=999 idealdif=999.

list respid q44 q46 idealdif/cases by 20.


*IDEALREC.
recode idealdif (0=0)(-500 thru -21=1)(-20 thru -11=2)(-10 thru -1=3)(1 thru 10=4)(11 thru 20=5)(21 thru 50=6)(51 thru 998=7) (999=9) into idealrec.
variable labels idealrec "Recoded Ideal Weight Difference".
value labels idealrec 0 "At ideal weight" 1 "More than 20 lbs. under iw" 2 "11 to 20 lbs. under iw" 3 "1 to 10 lbs. under iw" 4 "1 to 10 lbs. over iw"
5 "11 to 20 lbs. over iw" 6 "21 to 50 lbs. over iw" 7 "More than 50 lbs. over iw" 9 "Undesignated".
fre idealrec.

*Q13REC.
recode q13 (0 thru 4=1)(5 thru 24=2)(25 thru 99=3)(100 thru 499=4)(500 thru 99998=5)(99999=9) into q13rec.
variable labels q13rec "Recoded Q13 - largest amount of money won".
value labels q13rec 1 "Less than $5" 2 "$5 to $24" 3 "$25 to $99" 4 "$100 to $499" 5 "$500 or more" 9 "DK/Ref.".
fre q13rec.

*Q14REC.
recode q14 (0 thru 4=1)(5 thru 24=2)(25 thru 99=3)(100 thru 499=4)(500 thru 99998=5)(99999=9) into q14rec.
variable labels q14rec "Recoded Q14 - largest amount of money lost".
value labels q14rec 1 "Less than $5" 2 "$5 to $24" 3 "$25 to $99" 4 "$100 to $499" 5 "$500 or more" 9 "DK/Ref.".
fre q14rec.

*Q44REC2.
recode q44 (0 thru 124=1)(125 thru 149=2)(150 thru 174=3)(175 thru 199=4)(200 thru 998=5)(999=9) into q44rec2.
variable labels q44rec2 "Recoded Q44 for tabs - Current Weight".
value labels q44rec2 1 "124 lbs. or less" 2 "125-149 lbs." 3 "150-174 lbs." 4 "175-199 lbs." 5 "200 lbs. or more" 9 "DK/Ref.".
fre q44rec2.

*Q46REC2.
recode q46 (0 thru 124=1)(125 thru 149=2)(150 thru 174=3)(175 thru 199=4)(200 thru 998=5)(999=9) into q46rec2.
variable labels q46rec2 "Recoded Q46 for tabs - Ideal Weight".
value labels q46rec2 1 "124 lbs. or less" 2 "125-149 lbs." 3 "150-174 lbs." 4 "175-199 lbs." 5 "200 lbs. or more" 9 "DK/Ref.".
fre q46rec2.


****Add Index Vars for movie analysis.

**creating index of movie viewing services***************************************************.

**Step 1 create summary variable of cable or satellite vs broadcast HH. 
if cab2 =1 or cab4=1  cable=1.
if CAB2=2 AND CAB4=2  cable=2.
if cab2=9 and cab4=9  cable=9.
var label cable 'CAB2 and CAB4 combined'.
value label cable 1'Cable or Satellite' 2'Broadcast'.
fre cable cab2 cab4.
cro cab2 by cab4.

***Step 2 count total number of home movie options. 
***ADD cab7 Tivo question.
fre cable cab5 cab6  cab7 tv2.
count homefilm2 = cable, cab5, cab6,  cab7, tv2 (1).
fre homefilm2.
var label homefilm2 'Count index with TiVo of number home viewing services'.
value label homefilm2 0'Broadcast only' 5'5 home viewing services'.
fre homefilm2.
cro homefilm2 by cable.


****creating index of movie watching frequency across home modes***************************************.
***this index includes all respondents with a valid answer to any of the 3 questions. 
***No respondents had DK on all three items. 
cro q81 by q82/cel tot.
cro q81 by q82 by q83/cel tot.
cro q81 by q82 /cel count.

fre q81 q82 q83.
missing values q81 q82 q83 (7,9).
compute watch2 = min (q81, q82, q83).
fre watch2.
var label watch2 'Frequency of Home Movie Viewing Any Source Q81, Q82, Q83'.
value label watch2 1'weekly or more' 2'every few weeks' 3'once a month' 4'every few months' 5'less often' 6'Hardly ever or never'.
missing values q81 q82 q83 ().
if (q81=9) and (q82=9) and (q83=9)  watch2=9.
fre watch2.


****Create a subtotal on frequency for DVD and Pay per View modes of movie watching on 5-3-06*********. 
fre q82 q83.
missing values q82 q83 (7,9).
compute watchpay = min ( q82, q83).
fre watchpay.
var label watchpay 'Frequency of Home Movie Viewing DVD or Pay per View Q82, Q83'.
value label watchpay 1'weekly or more' 2'every few weeks' 3'once a month' 4'every few months' 5'less often' 6'Hardly ever or never'.
missing values q82 q83 ().
if  any (q82,7,9) and any (q83,7,9)  watchpay=9.
fre watchpay.


*****Create a total frequency of movie watching across any mode including theater 5-4-06***********.
*combine Q79F1 and Q80F2 forms. 
 if form=1  theater=q79f1. 
 if form=2  theater=q80f2. 
value lables theater 1'Once a week or more' 2'Once every few weeks' 3'Once a month' 4'Once every few months' 5'Less often' 6'Hardly ever or never' 9'DK'.
var label theater 'Q79F1 or Q80F2 How often if ever do you go out to the movies?'.
fre theater. 

compute watchtot = min (watch2, theater).
value lables watchtot 1'Once a week or more' 2'Once every few weeks' 3'Once a month' 4'Once every few months' 5'Less often' 6'Hardly ever or never' 9'DK'.
fre watchtot. 


***SPSS syntax for other variables used in report--variables below are not saved in the dataset.
***Estimating Number of Movies Views at Home Per Month by DVD or PayperView****.
compute buyhome=9.
if watchpay=1  buyhome=6.
if watchpay=2  buyhome=2.
if watchpay=3  buyhome=1.
if watchpay=4  buyhome=.5.
if watchpay GE 5  buyhome=0.
var label buyhome 'Estimated Number of Movies Viewed Per Month on DVD or Pay-per-View'.
fre buyhome. 
desc buyhome.

***Estimating Number of Movies Viewed Per Month at Theater****.
compute buyaway=9.
if theater=1  buyaway=6.
if theater=2  buyaway=2.
if theater=3  buyaway=1.
if theater=4  buyaway=.5.
if theater GE 5  buyaway=0.
var label buyaway'Estimated Number of Movies Viewed Per Month at Theater'.
fre buyaway. 
desc buyaway.


