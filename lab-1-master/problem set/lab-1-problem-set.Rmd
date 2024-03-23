---
title: "Lab 1 Problem Set"
output:
  github_document:
    toc: true
    toc_depth: 2
---

<br>
<hr>
<br>

# Submission Instructions:

Download the lab-one-problem-set.rmd file from GitHub and code your answers in that file. Rename the file netid_ps1 and save as a .rmd. Upload your problem set through the Assignments tab in Canvas by July 16th at 12PM. Remember that in an R Markdown file writing in the white space will be read as text, so you write responses to your questions in the white space.

# Part A: Reviewing the basics

The dataset we are working for this assignment is composed of a series of outcomes for black females, black males, white females, and white males by United States county. You will be asked to import and view the data, as well as run a series of summary statistics to examine relationships between these variables. Every variable will take two forms: `outcome_race_gender_n`, which provides the number of observations in that category, and `outcome_race_gender_mean`, which is the average of that outcome for that specific group. 

NOTE: the use of black/white, male/female is NOT inclusive of all of races and genders. We limit the analysis to only these groups because of sample size limitations and current limitations in the collection of data. Additionally, we thank Opportunity Insights for access to their class materials and datasets, which this assignment is based on.

Variables:

| Variable | Description |
| ----------- | ----------- |
| `kfr` | Mean percentile rank (relative to other children born in the same year) in the national distribution of household income measured as mean earnings in 2014-15. |
| `married` | Fraction of children who file their federal income tax return as “married filing jointly” or “married filing separate” in 2015 |
| `has_dad` | Fraction of children who have a male claimer in the year they are linked to parents |
| `has_mom` | Fraction of children who have a female claimer in the year they are linked to parents |
| `two_par` | Fraction of children claimed by two people in the year they are linked to parents |
| `teenbrth` | Fraction of women who grew up in the given tract who ever claimed a child who was born when they were between the ages of 13 and 19 as a dependent at any point |
| `working` | Fraction of children with positive W-2 earnings in 2015 |
| `proginc` | Fraction of children who receive public assistance income (among children who received the ACS at age 30+) |
| `coll` | Fraction of children who have a four year college degree (among children who received ACS or 2000 Census long form at age 25+) |
| `grad` | Fraction of children who have a graduate degree (among children who received the ACS or the 2000 long form at age 30+) |
| `kfr_top01` | Probability of reaching the top 1% of the national household income distribution (among children born in the same year) in 2014-15 |
| `lpov_nbh` | Fraction children who grew up in a given tract and end up living in a tract with a poverty rate of less than 10% (according to tract-level Census 2000 data) in adulthood. Tracts where children live as adults are defined as the tract of the last non-missing address observed on tax returns |
| `staytract` | Fraction of individuals who live in one of their childhood Census tracts in adulthood |
| `staycz` | Fraction of children who live in one of their childhood commuting zones in adulthood |
| `stayhome` | Fraction of children who live at the same address as their parents in 2015 |

## 1. Import `county_outcomes.csv`. You should have 154 variables and 2,819 observations

```{r}
setwd("C:/Users/Zhanqiu/Desktop/Cornell/lab-1-master")
data <- read.csv("county_outcomes.csv")
```

## 2. View your data by running at least 2 functions. Write 3-5 things you looked for to check your dataset to make sure it is ready for analysis
```{r}
head(data)
tail(data)
class(data)
```

1. The data are all numerical
2. There is NA value which should be considered in following analysis
3. The size of the data is correct(154 variables and 2,819 observations)
4. data is in data.frame class

## 3. Compare mean income ranks between black females and white females for all counties in the United States (use `kfr_black_female_mean` and `kfr_white_female_mean`). Write 1-2 sentences summarizing your finding. HINT: your dataset represents the United States. Therefore, when we ask you to compare the mean for all counties in the United States, we're asking you to find the average for the entire dataset without subsetting.)

```{r}
mean_black <- mean(data$kfr_black_female_mean,na.rm = TRUE)
mean_white <- mean(data$kfr_white_female_mean,na.rm = TRUE)
```
The mean for female white American is about 0.554, while the mean for female black American is about 0.375. The white female has higher income ranks than black female.

## 4. Run a correlation between any two outcomes you would like (e.g. `kfr_black_male_mean` and `coll_black_male_mean`). Test for significance. Write 1-2 sentences summarizing your finding.

```{r}
cor.test(data$kfr_black_male_mean,data$coll_black_male_mean,method="pearson")
```
The p-value is very small, which mean the data is correlated
The cor is about 0.51, which is moderate positive correlation, which means the black male children with four year college degree could earn more

## 5. Next, run another correlation on the same outcome for a different group (e.g., black females). Write 1-2 sentences comparing your finding here to what you found in question 4.

```{r}
cor.test(data$kfr_black_female_mean,data$coll_black_female_mean,method="pearson")
```
The p-value is very small, which mean the data is correlated
The cor is about 0.64, higher than in #4, which is strongly positive correlation, which means the salary of black female is more relied on there college degree

## 6. Generate a new variable that is the national average of `kfr_white_female_mean` and call it `kfr_white_female_us_mean`. Store the new variable in the dataset. 

```{r}
data$kfr_white_female_us_mean <- mean(data$kfr_white_female_mean,na.rm = TRUE)
```

## 7. Create an indicator variable that evaluates whether the mean income rank for white women in a county (hint: recall that every observation or row is a unique county) is below or above the United States average (hint: use what you created in question 6). Write 1-2 sentences explaining your findings.

```{r}
data$inc <- (data$kfr_white_female_mean > data$kfr_white_female_us_mean)
```
The value with true inc is higher than the nation average, the false is lower

## 8. Summarize your new variable by reporting how many observations are equal to 0 or 1 (i.e., how many counties are below or above the national average).

```{r}
aboveinc <- sum(data$inc,na.rm = TRUE)
belowinc <- length(data$inc)-aboveinc
```
the aboveinc is the number of counties with income above the nation average value, belowinc is the number below the average

## 9. Merge `cty_covariates.csv` with `county_outcomes.csv`

Please answer:
* What variable did you merge on? 
* How did you determine whether your merge was successful

```{r}
setwd("C:/Users/Zhanqiu/Desktop/Cornell/lab-1-master")
a <- read.csv("cty_covariates.csv")
b <- read.csv("county_outcomes.csv")
merged <- merge(a, b, all=TRUE)
```
The variable merged is a and b, where a is Neighborhood Characteristics by County, b is the Outcomes by County, Race, Gender and Parental Income Percentile
The number of entries is 3221, which is equal to the largest number of a and b
The number of columns is two number less than the sum of a and b, which is the column of state and county 

<br>
<hr>
<br>

# Part B: Analyzing the Opportunity Insights data

Now we are going to ask you to use your new data skills to answer some higher order questions. You can do this! Read the questions and think about how to apply the tools you've learned to answer them. Please use the "county_outcomes.csv" for this section. You will have the opportunity to use your merged dataset in section 3, if you would like to.

## 1. Using what you've learned, examine differences in outcomes (e.g., household income, fraction working) by group (e.g, female/male or black/white) and explain your findings in 3-4 sentences. 

HINT: you can examine whatever differences you would like, such as differences in mean, etc. 

```{r}
sbfm <- mean(data$stayhome_black_female_mean,na.rm = TRUE)
swfm <- mean(data$stayhome_white_female_mean,na.rm = TRUE)
difference <- swfm-sbfm
```
The average fraction of stayhome_black_female is about 0.16
The average fraction of stayhome_white_female is about 0.09
Larger fraction of black female stay home comparing with white female

## 2. How does the probability of reaching the top 1% of the national household income distribution (`kfr_top01`) differ by gender in a county of your choice. How does this compare to the national average? Explain your findings in 3-4 sentences. 

HINT: To answer this you will need to create two new variables that add 1) `black_female` and `white_female` together and 2) `black_male` and `white_male`. You will also need to think about how to subset your data to limit to a single county.

```{r}
w_m <- mean(c(data$kfr_top01_black_female_mean,data$kfr_top01_white_female_mean,data$kfr_top01_black_male_mean,data$kfr_top01_white_male_mean),na.rm = TRUE)
cty_bf <- subset(data$kfr_top01_black_female_mean,data$county==1)
cty_wf <- subset(data$kfr_top01_white_female_mean,data$county==1)
cty_bm <- subset(data$kfr_top01_black_male_mean,data$county==1)
cty_wm <- subset(data$kfr_top01_white_male_mean,data$county==1)
cty_fm <- mean(c(cty_bf,cty_wf),na.rm = TRUE)
cty_mm <- mean(c(cty_bm,cty_wm),na.rm = TRUE)

```

In county 1,the average probability for female is 0.009, while for male is 0.006.
Female is more likely to reach the top 1%of the national household income in county 1.
The world average probability is 0.006, which is close to the one of male in county 1, lower than the one of female in county 1

## 3. Next, repeat question 2 but looking now for patterns by race. Explain what you find in 3-4 sentences?

```{r}
cty_b <- mean(c(cty_bf,cty_bm),na.rm = TRUE)
cty_w <- mean(c(cty_wm,cty_wf),na.rm = TRUE)
```
In county 1,the average probability for black is 0.0006, while for white is 0.01203
The income is highly unequal where the black earn much less the world average and the white earns much more the world average

<br>
<hr>
<br>

# Part C: Sketching out your project

## 1. Limiting your answer to either race or gender, are there any other outcomes that might help explain the relationship you explored in Section B Question 2 or 3 (e.g., do you think `kfr_top01_gender` or `kfr_top01_race` are correlated with other outcomes)? Read over all of the variables in the dataset and provide an intuitive explanation for why you think another outcome could be correlated or related to upward mobility by race or gender. Don't run any code for this question; just think about the relationship. Please explain your hypothesis in 3-4 sentences.  

It may correspond to the Fraction of children who have a four year college degree. The higher the fraction is, higher the education level in that group of people. The education will enhance their productivity and become more competitive in the labor market. Therefore, they will have the chance to get the jobs with higher salary and higher probability to become the top %1 of the national household income distribution

## 2.	Using the hypothesis you developed in Section C Question 1, provide correlational evidence to test your hypothesis. You are welcome to use outside data that are not included in `country_outcomes.csv`, but this is not required. The goal of this question is to understand what might explain the variation in upward mobility for certain groups of children.

```{r}
coll_bf <- subset(data$coll_black_female_mean,data$county==1)
coll_wf <- subset(data$coll_white_female_mean,data$county==1)
coll_bm <- subset(data$coll_black_male_mean,data$county==1)
coll_wm <- subset(data$coll_white_male_mean,data$county==1)
cor.test(as.numeric(c(coll_bf,coll_wf),na.rm=T),as.numeric(c(cty_bf,cty_wf),na.rm=T))
```
The p-value is very small, there is a correlation between the education level and the upward mobility. cor value is about 0.79, which means there is a strong positive relation. Therefore, the education plays an important role in the upward mobility for the female in county 1.

## 3.	Please consider the county you chose to examine in Section B and think about the mayor of that county. Identify one or two key lessons or takeaways that you might discuss with them about the determinants of economic opportunity (or the potential factors that are associated with individuals probability of reaching the top 1% of the national household income distribution). Mention any important caveats to your conclusions or any additional analyses you might want to conduct to prove your findings.   
The education plays an important role in the economic opportunity as the female who receive college education has the larger probability of reaching the top 1% of the national household income distribution. Therefore, we could enhance the education level in our county to increase the income of our residents. Moreover, as some poor parents don't have enough money, their children may can't go to college and probably become poorer according to this relationship, forming a vicious cycle. We should provide special financial help, such as scholarship and compulsory education to improve the class mobility in the society, reaching the equality in the society.
