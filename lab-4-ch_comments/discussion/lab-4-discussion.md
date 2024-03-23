Lab Discussion 4 - Criminal Justice Lab
================

  - [Overview](#overview)
      - [Goals](#goals)
  - [General Questions](#general-questions)
  - [Lab 4 Exercises](#lab-4-exercises)
      - [1. Installing Packages and Bringing in
        Data](#installing-packages-and-bringing-in-data)
      - [2. Cleaning up the dataset](#cleaning-up-the-dataset)
      - [3. Examining trends over time](#examining-trends-over-time)
      - [4. Creating smaller datasets (cleaning steps removed - used
        group\_by and created an indicator for the
        policy)](#creating-smaller-datasets-cleaning-steps-removed---used-group_by-and-created-an-indicator-for-the-policy)
      - [5. Ttests](#ttests)
      - [6. Linear Regression](#linear-regression)
      - [7. Adding Controls](#adding-controls)
  - [Problem Set Questions](#problem-set-questions)

<br>

<hr>

<br>

# Overview

## Goals

Our discussion section is a time for you to 1) ask unresolved questions
from lab, 2) go over variants of the exercises we encouraged you to try
during lab, and 3) answer any clarifying questions related to the
problem set

<br>

# General Questions

Before we get started I wanted to set a little bit of time aside for you
all to ask any questions you may have after the last lab.

# Lab 4 Exercises

## 1\. Installing Packages and Bringing in Data

``` r
#install.packages("tidyverse")
library(lubridate)
```

    ## Warning: package 'lubridate' was built under R version 4.0.2

    ## 
    ## Attaching package: 'lubridate'

    ## The following objects are masked from 'package:base':
    ## 
    ##     date, intersect, setdiff, union

``` r
library(readxl)
```

    ## Warning: package 'readxl' was built under R version 4.0.2

``` r
library(stringr)
library(tidyverse) #metapackage of all tidyverse packages
```

    ## Warning: package 'tidyverse' was built under R version 4.0.2

    ## -- Attaching packages -------------------------------------------------------------------------------- tidyverse 1.3.0 --

    ## v ggplot2 3.3.2     v purrr   0.3.4
    ## v tibble  3.0.1     v dplyr   1.0.0
    ## v tidyr   1.1.0     v forcats 0.5.0
    ## v readr   1.3.1

    ## -- Conflicts ----------------------------------------------------------------------------------- tidyverse_conflicts() --
    ## x lubridate::as.difftime() masks base::as.difftime()
    ## x lubridate::date()        masks base::date()
    ## x dplyr::filter()          masks stats::filter()
    ## x lubridate::intersect()   masks base::intersect()
    ## x dplyr::lag()             masks stats::lag()
    ## x lubridate::setdiff()     masks base::setdiff()
    ## x lubridate::union()       masks base::union()

``` r
library(collapse)
```

    ## Warning: package 'collapse' was built under R version 4.0.2

    ## collapse 1.2.1, see ?`collapse-package` or ?`collapse-documentation`

    ## 
    ## Attaching package: 'collapse'

    ## The following object is masked from 'package:lubridate':
    ## 
    ##     is.Date

    ## The following object is masked from 'package:stats':
    ## 
    ##     D

``` r
require(doBy)
```

    ## Loading required package: doBy

    ## Warning: package 'doBy' was built under R version 4.0.2

    ## 
    ## Attaching package: 'doBy'

    ## The following object is masked from 'package:dplyr':
    ## 
    ##     order_by

``` r
library(visreg)
```

    ## Warning: package 'visreg' was built under R version 4.0.2

``` r
library(tidyverse) #metapackage of all tidyverse packages
library(crosswalkr) #this is going to help us read in data from a series of years
library(zoo)
```

    ## 
    ## Attaching package: 'zoo'

    ## The following object is masked from 'package:collapse':
    ## 
    ##     is.regular

    ## The following objects are masked from 'package:base':
    ## 
    ##     as.Date, as.Date.numeric

``` r
library(randomForest) #for prediction analysis!
```

    ## randomForest 4.6-14

    ## Type rfNews() to see new features/changes/bug fixes.

    ## 
    ## Attaching package: 'randomForest'

    ## The following object is masked from 'package:dplyr':
    ## 
    ##     combine

    ## The following object is masked from 'package:ggplot2':
    ## 
    ##     margin

``` r
#Bringing in our data
d2013 <- read.csv('./input/Police_Response_to_Resistance_-_2013.csv')
d2014 <- read.csv('./input/Police__2014_Response_to_Resistance.csv')
d2015 <- read.csv('./input/Police__2015_Response_to_Resistance.csv')
d2016 <- read.csv('./input/Police_Response_to_Resistance_-_2016.csv')
d2017 <- read.csv('./input/Police_Response_to_Resistance___2017.csv')
d2018 <- read.csv('./input/Police_Response_to_Resistance_-_2018.csv')
d2019 <- read.csv('./input/Police_Response_to_Resistance___2019.csv')

#load a crosswalk to match up different years into a single table
cw <- read.csv('./input/Crosswalk.csv')

df2013 <- renamefrom(d2013, cw, c2013, VarName)
df2014 <- renamefrom(d2014, cw, c2014, VarName)
df2015 <- renamefrom(d2015, cw, c2015, VarName)
df2016 <- renamefrom(d2016, cw, c2016, VarName)
df2017 <- renamefrom(d2017, cw, c2017, VarName)
df2018 <- renamefrom(d2018, cw, c2018, VarName)
df2019 <- renamefrom(d2019, cw, c2019, VarName)

#rbind() stacks the datasets together so that we have one dataset where each row is a different day/police response.
df <- rbind(df2013, df2014, df2015, df2016, df2017, df2018, df2019) 
```

``` r
#Alternative Method 1 - reduces lines of code by 1 but uses our dplyr syntax
#df <- rbind(d2013 %>% tbl_df() %>% renamefrom(., cw, c2013, VarName),

 #           d2014 %>% tbl_df() %>% renamefrom(., cw, c2014, VarName),

  #          d2015 %>% tbl_df() %>%vrenamefrom(., cw, c2015, VarName),

   #         d2016 %>% tbl_df() %>%vrenamefrom(., cw, c2016, VarName),

    #        d2017 %>% tbl_df() %>%vrenamefrom(., cw, c2017, VarName),

     #       d2018 %>% tbl_df() %>%vrenamefrom(., cw, c2018, VarName),

      #      d2019 %>% tbl_df() %>%vrenamefrom(., cw, c2019, VarName))


#Alternative Method 2 - bring in all files, you could then loop through these with the code in Alternative Method 1
dataFiles <- lapply(Sys.glob("./input/Police*.csv"), read.csv)
```

## 2\. Cleaning up the dataset

``` r
#Recoding values
df <- df %>%
  mutate(CIT_INJURE = case_when(
    CIT_INJURE %in% c("No", "false") ~ 0,
    CIT_INJURE %in% c("Yes", "true") ~ 1))

df <- df %>%
 filter_at(vars(DIVISION, CitSex, CitRace, CitSex, CitRace), #these variables
           all_vars(!. %in% c("", "O/T", "Null", "Unknown"))) #all do not have values in set defined by c()


#Creating new gender variable
df$cit_female <- ifelse(df$CitSex == "Female", 1, 0)
df$off_female <- ifelse(df$OffSex == "Female", 1, 0)

#Creating new race variable (indicator for black, white, Hispanic, by construction the ommitted group will be all other races)
df$cit_black <- ifelse(df$CitRace == "Black", 1, 0)
df$cit_white <- ifelse(df$CitRace == "White", 1, 0)
df$cit_hispanic <- ifelse(df$CitRace == "Hispanic", 1, 0)

df$off_black <- ifelse(df$OffRace == "Black", 1, 0)
df$off_white <- ifelse(df$OffRace == "White", 1, 0)
df$off_hispanic <- ifelse(df$OffRace == "Hispanic", 1, 0)
 
#Creating indicators for whether race/gender are the same between citizens and officers
df$co_race_b <- df$cit_black == df$off_black 
df$co_race_w <- df$cit_white == df$off_white 
df$co_race_h <- df$cit_hispanic == df$off_hispanic 
df$co_gen_f <- df$cit_female == df$off_female
df <- df %>% mutate_at(vars(starts_with("co_")), as.numeric)

#Turning division into an integer
df$DIVISION_INT <- recode(df$DIVISION, "CENTRAL" = "1", "NORTH CENTRAL" = "2", "NORTHEAST" = "3", "NORTHWEST" = "4", "SOUTH CENTRAL" = "5", "SOUTHEAST" = "6", "SOUTHWEST" = "7", default = NA_character_)
df$DIVISION_INT <- as.numeric(df$DIVISION_INT)
```

``` r
# Now, we'll create a YEAR and a YEAR/MONTH variable by manipulating the OCCURED_D variable
df$day <- substring(df$OCCURRED_D, 4, 5)

df$year <- substring(df$OCCURRED_D, 7, 10) #substring() takes the 7th to 10th characters from OCCURRED_D and places them into a new year variable
df$year <- as.numeric(df$year) #this ensures the new variable is coded as a number

df$month <- substring(df$OCCURRED_D, 1, 2) 
df$month <- as.numeric(df$month)

df$year_month <- as.yearmon(paste(df$year, df$month), "%Y %m") #creating a time variable that is equal to the month/year of the observation

df <- df %>%
  mutate(date = make_date(year, month, day))
```

## 3\. Examining trends over time

``` r
#Plotting citizen injuries by day 
ggplot(df, aes(x = date, y= CIT_INJURE, group = date)) +
  geom_point() +
  labs(x = "Day", y = "Count", title = "Injuries by Day")
```

![](lab-4-discussion_files/figure-gfm/unnamed-chunk-6-1.png)<!-- -->

``` r
#Plotting citizen injuries by day 
df_day <- df %>%
  group_by(date, CIT_INJURE) %>%
  summarise(n = n())  %>%
  mutate(prop = n / sum(n)) %>%
  na.omit() %>%
  filter(CIT_INJURE == 1)
```

    ## `summarise()` regrouping output by 'date' (override with `.groups` argument)

``` r
ggplot(df_day, aes(x = date, y= prop, group = date)) +
  geom_point() +
  labs(x = "Month/Year", y = "Count", title = "Injuries by Day")
```

![](lab-4-discussion_files/figure-gfm/unnamed-chunk-7-1.png)<!-- -->

``` r
#Plotting citizen injuries by month/year 
df_ym <- df %>%
  group_by(year_month, CIT_INJURE) %>%
  summarise(n = n())  %>%
  mutate(prop = n / sum(n)) %>%
  na.omit() %>%
  filter(CIT_INJURE == 1)
```

    ## `summarise()` regrouping output by 'year_month' (override with `.groups` argument)

``` r
ggplot(df_ym, aes(x = year_month, y= prop, group = year_month)) +
  geom_point() +
  labs(x = "Month/Year", y = "Proportion", title = "Injuries by Month/Year")
```

![](lab-4-discussion_files/figure-gfm/unnamed-chunk-8-1.png)<!-- -->

## 4\. Creating smaller datasets (cleaning steps removed - used group\_by and created an indicator for the policy)

``` r
#Year - Month Dataset
df_ym <- read.csv("C:/Users/kcs3a/Desktop/year_month.csv")

df_ym$year_month <- as.yearmon(paste(df_ym$year, df_ym$month), "%Y %m") #creating a time variable that is equal to the month/year of the observation
```

``` r
#Same plot as in the last part of 3
ggplot(df_ym, aes(x = year_month, y= cit_injure, group = year_month)) +
  geom_point() +
  labs(x = "Month/Year", y = "Proportion", title = "Injuries by Month/Year")
```

![](lab-4-discussion_files/figure-gfm/unnamed-chunk-10-1.png)<!-- -->

``` r
#Year - Month Dataset by Citizen Female
df_ymf <- read.csv("C:/Users/kcs3a/Desktop/df_female.csv")

df_ymf$year_month <- as.yearmon(paste(df_ymf$year, df_ymf$month), "%Y %m") #creating a time variable that is equal to the month/year of the observation
```

``` r
ggplot(df_ymf, aes(x = year_month, y= cit_injure, color = factor(cit_female))) +
  geom_point() +
  labs(x = "Month/Year", y = "Proportion", title = "Injuries by Month/Year")
```

![](lab-4-discussion_files/figure-gfm/unnamed-chunk-12-1.png)<!-- -->

## 5\. Ttests

``` r
#Ttest on our initial dataset
df$policy <- (df$year > 2014 & df$month>=8) |  (df$year>2014)

aggregate(df$CIT_INJURE, list(df$policy), mean)
```

    ##   Group.1         x
    ## 1   FALSE 0.2355263
    ## 2    TRUE 0.2621291

``` r
pairwise.t.test(df$CIT_INJURE, df$policy,
                 p.adjust.method = "BH")
```

    ## 
    ##  Pairwise comparisons using t tests with pooled SD 
    ## 
    ## data:  df$CIT_INJURE and df$policy 
    ## 
    ##      FALSE  
    ## TRUE 2.3e-05
    ## 
    ## P value adjustment method: BH

``` r
#Ttest for our year-month dataset
aggregate(df_ym$cit_injure, list(df_ym$policy), mean)
```

    ##   Group.1         x
    ## 1       0 0.2246006
    ## 2       1 0.2646247

``` r
pairwise.t.test(df_ym$cit_injure, df_ym$policy,
                 p.adjust.method = "BH")
```

    ## 
    ##  Pairwise comparisons using t tests with pooled SD 
    ## 
    ## data:  df_ym$cit_injure and df_ym$policy 
    ## 
    ##   0     
    ## 1 0.0087
    ## 
    ## P value adjustment method: BH

``` r
#Ttest for our year-month by female dataset
aggregate(df_ymf$cit_injure, list(df_ymf$policy), mean)
```

    ##   Group.1         x
    ## 1       0 0.1931243
    ## 2       1 0.2403643

``` r
pairwise.t.test(df_ymf$cit_injure, df_ymf$cit_female,
                 p.adjust.method = "BH")
```

    ## 
    ##  Pairwise comparisons using t tests with pooled SD 
    ## 
    ## data:  df_ymf$cit_injure and df_ymf$cit_female 
    ## 
    ##   0      
    ## 1 1.5e-10
    ## 
    ## P value adjustment method: BH

``` r
#What about additional break downs?
aggregate(df_ymf$cit_injure, list(df_ymf$cit_female), mean)
```

    ##   Group.1         x
    ## 1       0 0.2701407
    ## 2       1 0.1892174

``` r
pairwise.t.test(df_ymf$cit_injure, df_ymf$cit_female,
                 p.adjust.method = "BH")
```

    ## 
    ##  Pairwise comparisons using t tests with pooled SD 
    ## 
    ## data:  df_ymf$cit_injure and df_ymf$cit_female 
    ## 
    ##   0      
    ## 1 1.5e-10
    ## 
    ## P value adjustment method: BH

## 6\. Linear Regression

``` r
#Linear regression on our initial dataset
policy <- lm(CIT_INJURE ~ policy, data=df)
summary(policy)
```

    ## 
    ## Call:
    ## lm(formula = CIT_INJURE ~ policy, data = df)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -0.2621 -0.2621 -0.2355  0.7379  0.7645 
    ## 
    ## Coefficients:
    ##             Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept) 0.235526   0.004980  47.296  < 2e-16 ***
    ## policyTRUE  0.026603   0.006283   4.234  2.3e-05 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.4341 on 20439 degrees of freedom
    ## Multiple R-squared:  0.0008764,  Adjusted R-squared:  0.0008275 
    ## F-statistic: 17.93 on 1 and 20439 DF,  p-value: 2.304e-05

``` r
visreg(policy, "policy", type="contrast")
```

![](lab-4-discussion_files/figure-gfm/unnamed-chunk-21-1.png)<!-- -->

``` r
#Linear regression on our year-month dataset
policy_ym <- lm(cit_injure ~ policy, data=df_ym)
summary(policy_ym)
```

    ## 
    ## Call:
    ## lm(formula = cit_injure ~ policy, data = df_ym)
    ## 
    ## Residuals:
    ##       Min        1Q    Median        3Q       Max 
    ## -0.110779 -0.041392 -0.002252  0.031505  0.144264 
    ## 
    ## Coefficients:
    ##             Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)  0.22460    0.01299  17.289  < 2e-16 ***
    ## policy       0.04002    0.01488   2.689  0.00867 ** 
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.0581 on 82 degrees of freedom
    ## Multiple R-squared:  0.08105,    Adjusted R-squared:  0.06984 
    ## F-statistic: 7.232 on 1 and 82 DF,  p-value: 0.008672

``` r
visreg(policy_ym, "policy", type="contrast")
```

![](lab-4-discussion_files/figure-gfm/unnamed-chunk-22-1.png)<!-- -->

``` r
#Linear regression on our year-month by female dataset
policy_ymf <- lm(cit_injure ~ policy, data=df_ymf)
summary(policy_ymf)
```

    ## 
    ## Call:
    ## lm(formula = cit_injure ~ policy, data = df_ymf)
    ## 
    ## Residuals:
    ##       Min        1Q    Median        3Q       Max 
    ## -0.240364 -0.049983 -0.002143  0.053753  0.244484 
    ## 
    ## Coefficients:
    ##             Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)  0.19312    0.01372   14.08  < 2e-16 ***
    ## policy       0.04724    0.01559    3.03  0.00284 ** 
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.08455 on 166 degrees of freedom
    ## Multiple R-squared:  0.0524, Adjusted R-squared:  0.04669 
    ## F-statistic: 9.179 on 1 and 166 DF,  p-value: 0.00284

``` r
visreg(policy_ymf, "policy", type="contrast")
```

![](lab-4-discussion_files/figure-gfm/unnamed-chunk-23-1.png)<!-- -->

But why are there differences in our estimates when we aggregate our
data differently? This is due to differences in covariation between our
independent and dependent variables. Essentially each of our variables
has a certain amount of variation (see the graphs above that show all of
the variation with our variables of interest over time). The variation
between certain variables can be correlated (these correlations can be
weak or strong). Depending on the way we aggregate our data, we are
providing different number of obervations and are thereby reducing our
sample size and changing the way we are measuring our variables. This
then creates different covariations.

The biggest take away is make sure that your data makes sense for the
questions you want to answer\! In the case of crime, we don’t really
expect a lot to change day to day. The literature tells us there are
seasonal changes, so we want to aggregate up to the month. This is also
true for different topics like unemployment claims. Think about what
your outcome is and how you want to talk about it.

## 7\. Adding Controls

``` r
#Additional Linear Regressions on our Year by Month Dataset
female <- lm(cit_injure ~ cit_female, data=df_ym)
print(female)
```

    ## 
    ## Call:
    ## lm(formula = cit_injure ~ cit_female, data = df_ym)
    ## 
    ## Coefficients:
    ## (Intercept)   cit_female  
    ##      0.2266       0.1575

``` r
visreg(female, "cit_female", type="contrast")
```

![](lab-4-discussion_files/figure-gfm/unnamed-chunk-24-1.png)<!-- -->

``` r
female_y <- lm(cit_injure ~ cit_female + year, data=df_ym)
print(female_y)
```

    ## 
    ## Call:
    ## lm(formula = cit_injure ~ cit_female + year, data = df_ym)
    ## 
    ## Coefficients:
    ## (Intercept)   cit_female         year  
    ##  -12.284919     0.207757     0.006202

``` r
visreg(female_y, "cit_female", type="contrast")
```

![](lab-4-discussion_files/figure-gfm/unnamed-chunk-25-1.png)<!-- -->

``` r
visreg(female_y, "year", type="contrast")
```

![](lab-4-discussion_files/figure-gfm/unnamed-chunk-25-2.png)<!-- -->

``` r
female_yc <- lm(cit_injure ~ cit_female + co_gen_f + year, data=df_ym)
print(female_yc)
```

    ## 
    ## Call:
    ## lm(formula = cit_injure ~ cit_female + co_gen_f + year, data = df_ym)
    ## 
    ## Coefficients:
    ## (Intercept)   cit_female     co_gen_f         year  
    ##  -12.473937     0.383014     0.280504     0.006172

# Problem Set Questions

I want to leave a little bit of time to walk through the problem set
exercises at a high level.
