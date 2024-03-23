Lab Tutorial 1 - Getting Moving (To Opportunity)
================

  - [Overview](#overview)
      - [Goals](#goals)
      - [Data](#data)
  - [Part A: Fundamentals of R and R
    notebooks](#part-a-fundamentals-of-r-and-r-notebooks)
      - [RStudio](#rstudio)
      - [Your first functions](#your-first-functions)
  - [Part B: Reading in Data](#part-b-reading-in-data)
      - [Example 1. Create a vector](#example-1.-create-a-vector)
      - [Example 2. Creating a matrix using vector as an
        input](#example-2.-creating-a-matrix-using-vector-as-an-input)
      - [Example 3. Reading in a CSV
        file](#example-3.-reading-in-a-csv-file)
  - [Part C: Viewing our Data](#part-c-viewing-our-data)
      - [Example 1: Viewing our data](#example-1-viewing-our-data)
      - [Example 2: Exploring variable length and
        types](#example-2-exploring-variable-length-and-types)
      - [Example 3: Changing variable
        type](#example-3-changing-variable-type)
      - [Example 4: Cleaning our
        dataset](#example-4-cleaning-our-dataset)
      - [Example 5: Merging data](#example-5-merging-data)
      - [Example 6: Subsetting data](#example-6-subsetting-data)
  - [Part D: Summary Statistics](#part-d-summary-statistics)
      - [Example 1. Taking the mean of a
        variable](#example-1.-taking-the-mean-of-a-variable)
      - [Example 2. Creating new
        variabes](#example-2.-creating-new-variabes)
      - [Example 3: Exploring relationships with our new
        variables](#example-3-exploring-relationships-with-our-new-variables)
      - [Example 4: Correlations](#example-4-correlations)

<br>

<hr>

<br>

# Overview

## Goals

In this lab tutorial, we will focus on learning the fundamentals of R
using a subset of the “Moving to Opportunities” datset from the
Opportunity Insights lab. We’ll go over:

1.  Language basics to help you speak like a programmer  
2.  Dataset basics: what is a dataset? how do I use one in R?  
    `read.csv()`  
3.  How to view and summarize your data using functions such as:  
    `head()`  
    `tail()`  
    `mean()`  
    `table()`  
    `cor.test()`  
4.  How to merge datasets  
    `merge()`

## Data

The data for this lab come from Opportunity Insights. We will use two
datasets. The first contains demographic information (e.g., household
income, commute time, fraction earning college degree, etc.) by county,
while the second contains outcomes (e.g., job growth, income percentile,
married, etc.) by county.

# Part A: Fundamentals of R and R notebooks

Here are some basics before we get started:

## RStudio

1.  Create a new RMarkdown notebook and give it an appropriate name like
    “Lab 1”
2.  If you want to write text, you just start typing. When you type text
    like this, R interprets it as Markdown. Markdown is a simple
    language that allows you to create headers, annotate text, and
    generate lists with simple syntax. You can read more on markdown
    [here](https://www.markdownguide.org/cheat-sheet/).
3.  If you want to add a code chunk, use the Insert button in the menu
    bar above and click “Insert” and then “R” (or click Ctrl-Alt-I). You
    will see that a section marked off by apostrophes is added, which
    tells R that this is code to evaluate.

## Your first functions

The first set of code below uses four functions, `intall.packages()`,
`library()`, `list.files()` and `ls()`:

``` 
    a. Functions are your way of telling R what to do. For instance, `library()` tells R to load whatever software package you place inside the parantheses. The area inside the () is populated with one or more arguments. 
    b. Programming functions are based on an input/output idea. We provide a function with some input using _argument(s)_, and it provides us with some output.
    b. Arguments are your way of telling the function exactly what you want to do. So for `library()`, the argument is the package you want installed. But functions are a general programming concept, so in other contexts you could want to tell R to summarize a variable. In that case you would say something like `sum(variable1)`. This tells R to compute the sum of all values in variable 1.
```

``` r
#Installing and loading packages should always be the first code in your notebook
#NOTE: the # allows you to add comments into your code without affecting the ability to run
#To run a section of code, press ctrl-enter or the blue arrow to the right of the code block

#install.packages("tidyverse")
library(tidyverse) #metapackage of all tidyverse packages
```

    ## -- Attaching packages --------------------------------------------------- tidyverse 1.3.0 --

    ## √ ggplot2 3.3.2     √ purrr   0.3.4
    ## √ tibble  3.0.2     √ dplyr   1.0.0
    ## √ tidyr   1.1.0     √ stringr 1.4.0
    ## √ readr   1.3.1     √ forcats 0.5.0

    ## -- Conflicts ------------------------------------------------------ tidyverse_conflicts() --
    ## x dplyr::filter() masks stats::filter()
    ## x dplyr::lag()    masks stats::lag()

``` r
list.files(path = "../input") #this will list all files under the input directory
```

    ## character(0)

``` r
ls() #this will list all objects in our environment
```

    ## character(0)

<br>

# Part B: Reading in Data

In this section we will go over three examples of ways you can bring in
and store data using vectors, matrices, and data frames. These are not
the only ways you can store data (you can also create factors and
arrays), but these will be the three most important for this class.

## Example 1. Create a vector

We can create a vector, which is a combination of multiple values. This
is the most basic *data structure* in R. A vector could contain a series
of numbers (1, 2, 3) or strings (‘hello’, ‘how are you’, ‘hi’).

To create an object, which in this case will be a vector, we need to use
the assignment operator `<-` (which is just the less than sign plus a
minus). We assign values to some object, and then R stores it in memory
for use later. Place whatever values you want the object to take on the
right side of the arrow and the name of the object you’re creating on
the left e.g., `price <- 20`.

You can think of a vector as a single variable. So matrices and
dataframes, which we will see next, are basically a data structure where
we combine a number of *equal length* vectors together.

``` r
#Creating a vector storing values 1 to 10
vector <- 1:10 # returns a vector with the integer sequence from 1 to 10 and assigns this object to vector
print(vector) # look at the object using print() function
```

    ##  [1]  1  2  3  4  5  6  7  8  9 10

``` r
class(vector) # check the class using class() function
```

    ## [1] "integer"

## Example 2. Creating a matrix using vector as an input

Like we stated above matrices are basically a set of equal length
vectors. These are helpful for a variety of reasons, and resemble a
spreadsheet, something you may already be familiar with.

One example of when we might want to use a matrix is if we do a
cross-tabulation. For instance, maybe we want to know how many
females/males are poor/not poor. We could create a 2x2 matrix that would
tell us: column 1, row 1, the number of females that are poor; column 2,
row 1, the number of females that are not poor; column 1, row 2, the
number of males that are poor; column 2, row 2, the number of males that
are not poor. We refer to this as a 2x2 matrix because it has 2 rows and
2 columns (i.e., rows X columns).

``` r
#Creating a matrix from our vector above
my.matrix <- matrix(vector, nrow = 5) #creates a matrix and assigns it to the object called my.matrix
class(my.matrix)
```

    ## [1] "matrix" "array"

``` r
print(my.matrix)
```

    ##      [,1] [,2]
    ## [1,]    1    6
    ## [2,]    2    7
    ## [3,]    3    8
    ## [4,]    4    9
    ## [5,]    5   10

With matrices and data frames, we usually want to define columns so that
they describe a coherent *unit of analysis*. The unit could be a person,
a county, or really anything that we might study in the social world—the
idea is just that one row denotes one thing that we’d like to study.

## Example 3. Reading in a CSV file

A common way of storing data is as comma separated values. In such a
file, each row of the file is a row of data, and we denote each column
of interest by separating values with commas.

When reading in files, always start this section of code by setting your
working directory with `setwd()`. Adding this one line of code makes it
so you don’t have to copy the entire directory every time you want to
read in a file. This will be especially helpful when we start bringing
in multiple files to merge and join together. To find your directory on
a Windows machine, locate the file on your computer, right click, click
“Properties” and copy the “Location.” For a mac, right click the file,
click “Get Info”, and copy “Where”.

Once you set your working directory, you can just type in the file name
in the argument section of the `read.csv()` function anywhere in your R
script. Make sure you place the argument in single quotes. Then when we
call, or run, the function, R will use the path designated in `setwd()`
to locate your .csv file from your computer’s directory, it will then
read in the file placed in the argument, and it will place that file
into the object “data”.

NOTE: For this class, `read.csv()` will be a primary we way we load data
into R. We don’t typically create our own data frames within R from
scratch. Since we will be working with large datasets to deal with big
policy issues, we will load some existing data to get a jump start on
analysis.

``` r
#Creating a dataframe from a csv file
setwd("C:/Users/Zhanqiu/Desktop/Cornell/lab-1-master")
data <- read.csv("cty_covariates.csv") 
class(data) #class is a function with the "argument" data. Class tells us data is a dataframe
```

    ## [1] "data.frame"

If you every run into problems, use R help:

``` r
help.search("csv") # search R help for the string "csv"
```

    ## starting httpd help server ... done

``` r
help(read.csv) # look at the help file for the function read.csv()
?read.csv #equivalent to above
```

<br>

# Part C: Viewing our Data

When bringining in data it is important to run common checks to make
sure the dataset is ready for use. These include:  
1\. Making sure all of the variables are imported correctly, or as you
would expect (e.g., every variable has the correct data associated with
it).  
2\. Ensure your variables are stored as the correct “type”. For
instance, maybe income was stored as a string rather than an integer,
which would make it impossible to run any summary statistics (e.g.,
mean, median, max/min) on the variable. We would need to change the
variable back to an integer using our `as.numeric()` function. But you
might get an error when you do this becuase maybe there is a value in
your string like “not applicable” stored as one of the values. Then you
would have to investigate and “clean” your variable before you could use
it for analysis.  
3\. Examine your data for missing variables. Which variables have
missing values? This will affect how you summarize the data later on.  
4\. Make sure your variables represent the proper values. For instance,
if you have proportion female, you wouldn’t want this to be coded 0 to
1.2. It should be coded 0 to 1, so what is going on?

## Example 1: Viewing our data

We can view the entire dataset by clicking on “data” under Data in the
Environments section of your R Studio interface. Notice when you click
on a dataframe, it will appear in a new tab in your console. You can
move back and forth between your R script and data. You can
alternatively evaluate the first and last 6 observations using the
`head()` and `tail()` functions, respectively, as shown below.

``` r
#Viewing our data
head(data) # head() shows the first 6 observations of our object "data"
```

    ##   state county    cz     czname  hhinc_mean2000 mean_commutetime2000
    ## 1     1      1 11101 Montgomery twenty thousand             28.49060
    ## 2     1      3 11001     Mobile       76064.086             26.50108
    ## 3     1      5 10301    Eufaula       51246.004             24.04751
    ## 4     1      7 10801 Tuscaloosa       55094.492             32.87532
    ## 5     1      9 10700 Birmingham       62749.727             36.18924
    ## 6     1     11  9800     Auburn       41518.551             26.25119
    ##   frac_coll_plus2000 frac_coll_plus2010 foreign_share2010 med_hhinc1990
    ## 1         0.18973459         0.22199036       0.020154603      29718.64
    ## 2         0.23003615         0.26071036       0.037591625      26435.69
    ## 3         0.10744983         0.13349621       0.028143950      19026.75
    ## 4         0.07002571         0.09924053       0.006859188      19696.79
    ## 5         0.09621403         0.12633450       0.047343444      23159.69
    ## 6         0.07616644         0.10972187       0.013493270      14736.08
    ##   med_hhinc2016 poor_share2010 poor_share2000 poor_share1990 share_white2010
    ## 1      54052.80      0.1059177     0.10375097      0.1395835       0.7724616
    ## 2      52003.09      0.1229422     0.09859775      0.1400626       0.8350479
    ## 3      33114.85      0.2506308     0.27296948      0.2562720       0.4675311
    ## 4      39846.45      0.1268499     0.21399727      0.2132011       0.7502073
    ## 5      46361.12      0.1331379     0.11554340      0.1477678       0.8888734
    ## 6      31304.78      0.2804486     0.34550691      0.3760353       0.2191680
    ##   share_black2010 share_hisp2010 share_asian2010 share_black2000
    ## 1      0.18134174     0.02400542     0.007830280      0.16422907
    ## 2      0.09752284     0.04384824     0.005953514      0.09791613
    ## 3      0.47190151     0.05051535     0.003688206      0.46370360
    ## 4      0.22282349     0.01771765     0.000741872      0.22258869
    ## 5      0.01500297     0.08070200     0.001873596      0.01293185
    ## 6      0.70221734     0.07119296     0.001793249      0.73125643
    ##   share_white2000 share_hisp2000 share_asian2000 gsmn_math_g3_2013
    ## 1       0.8043379    0.013819249     0.004298492          2.759864
    ## 2       0.8659056    0.018494057     0.003541086          2.792510
    ## 3       0.5090733    0.016422329     0.002342030          1.600009
    ## 4       0.7608481    0.009978266     0.000767521          1.531674
    ## 5       0.9220281    0.052030329     0.001227109          2.815403
    ## 6       0.2319123    0.028622525     0.001945031          1.039439
    ##   rent_twobed2015 singleparent_share2010 singleparent_share1990
    ## 1        739.3654              0.2833759              0.1655400
    ## 2        816.8452              0.2778664              0.1842143
    ## 3        527.2908              0.4680706              0.2714696
    ## 4        604.2776              0.3201363              0.1886276
    ## 5        567.6959              0.2589052              0.1224555
    ## 6        266.0000              0.5778636              0.4718738
    ##   singleparent_share2000 traveltime15_2010   emp2000 mail_return_rate2010
    ## 1              0.2408110         0.2041625 0.6095865             82.33318
    ## 2              0.2378831         0.2753262 0.5770263             80.03409
    ## 3              0.3932633         0.3760492 0.4532710             74.89907
    ## 4              0.2572943         0.2526830 0.4942406             70.00357
    ## 5              0.1734077         0.1943438 0.5778096             83.10035
    ## 6              0.5960218         0.3921350 0.3746639             47.21169
    ##   ln_wage_growth_hs_grad popdensity2010 popdensity2000
    ## 1            -0.06331379       91.80268       73.46603
    ## 2             0.03009291      114.64751       88.32320
    ## 3             0.18936642       31.02921       32.81807
    ## 4            -0.02007263       36.80634       33.45096
    ## 5             0.09646260       88.90219       79.14806
    ## 6             0.36383346       17.52395       18.69649
    ##   ann_avg_job_growth_2004_2013 job_density_2013
    ## 1                  0.010145103        40.719135
    ## 2                  0.012950056        50.085987
    ## 3                 -0.020755908         9.230672
    ## 4                 -0.004644653        12.875392
    ## 5                 -0.008120399        36.175354
    ## 6                  0.026254078         6.954023

``` r
tail(data) # tail() shows the last 6 observations of our object "data"
```

    ##      state county cz czname hhinc_mean2000 mean_commutetime2000
    ## 3216    72    145 NA                                         NA
    ## 3217    72    147 NA                                         NA
    ## 3218    72    149 NA                                         NA
    ## 3219    72    151 NA                                         NA
    ## 3220    72    153 NA                                         NA
    ## 3221     2    158 NA                                         NA
    ##      frac_coll_plus2000 frac_coll_plus2010 foreign_share2010 med_hhinc1990
    ## 3216                 NA          0.1715236                NA            NA
    ## 3217                 NA          0.1338328                NA            NA
    ## 3218                 NA          0.1595451                NA            NA
    ## 3219                 NA          0.1335113                NA            NA
    ## 3220                 NA          0.1694696                NA            NA
    ## 3221                 NA                 NA                NA            NA
    ##      med_hhinc2016 poor_share2010 poor_share2000 poor_share1990 share_white2010
    ## 3216      19401.10      0.5127536             NA             NA     0.005614964
    ## 3217      18057.43      0.4752558             NA             NA     0.047736801
    ## 3218      19804.77      0.5598798             NA             NA     0.002799831
    ## 3219      16943.69      0.5138917             NA             NA     0.004375214
    ## 3220      15688.49      0.5516703             NA             NA     0.003829413
    ## 3221            NA             NA             NA             NA              NA
    ##      share_black2010 share_hisp2010 share_asian2010 share_black2000
    ## 3216     0.000737488      0.9926419     0.001095058              NA
    ## 3217     0.006773465      0.9434469     0.000645092              NA
    ## 3218     0.000191769      0.9965482     0.000536245              NA
    ## 3219     0.001660473      0.9932790     0.001502333              NA
    ## 3220     0.000380563      0.9949576     0.001049085              NA
    ## 3221              NA             NA              NA              NA
    ##      share_white2000 share_hisp2000 share_asian2000 gsmn_math_g3_2013
    ## 3216              NA             NA              NA                NA
    ## 3217              NA             NA              NA                NA
    ## 3218              NA             NA              NA                NA
    ## 3219              NA             NA              NA                NA
    ## 3220              NA             NA              NA                NA
    ## 3221              NA             NA              NA                NA
    ##      rent_twobed2015 singleparent_share2010 singleparent_share1990
    ## 3216        514.5848              0.3936879                     NA
    ## 3217        454.0000              0.5426471                     NA
    ## 3218        380.0201              0.4833596                     NA
    ## 3219        400.4811              0.4548871                     NA
    ## 3220        272.5690              0.3867666                     NA
    ## 3221              NA                     NA                     NA
    ##      singleparent_share2000 traveltime15_2010 emp2000 mail_return_rate2010
    ## 3216                     NA         0.1834176      NA             69.95574
    ## 3217                     NA         0.5429810      NA             56.82129
    ## 3218                     NA         0.2759751      NA             71.38277
    ## 3219                     NA         0.1648593      NA             67.03735
    ## 3220                     NA         0.3456877      NA             74.00742
    ## 3221                     NA                NA      NA                   NA
    ##      ln_wage_growth_hs_grad popdensity2010 popdensity2000
    ## 3216            -0.19041440      1301.1013              0
    ## 3217                     NA       183.2060              0
    ## 3218             0.07987793       731.6273              0
    ## 3219             0.17430075       687.1502              0
    ## 3220             0.30088389       616.5295              0
    ## 3221                     NA             NA             NA
    ##      ann_avg_job_growth_2004_2013 job_density_2013
    ## 3216                 -0.043592215        266.01242
    ## 3217                  0.016369877         50.99669
    ## 3218                 -0.017515587        180.03761
    ## 3219                 -0.019508818        140.21552
    ## 3220                 -0.044481717        131.37712
    ## 3221                  0.006986185               NA

Scrolling through the data is the first step in ensuring our data was
input correctly. You can click on each variable to sort your data. You
can also look at the `head()` output to determine how each variable is
stored. Think about:  
\* Are variables stored as int or char (see below for more on this).  
\* Do variable values seem to be correct? E.g., are proportions between
0 and 1?  
\* Do any of the values have missing data? This will influence arguments
we use later.

## Example 2: Exploring variable length and types

Above we brought in a dataset called `cty_covariates.csv`. Datasets are
composed of rows of observations and columns of variables. Variables can
take on 6 types described below.

  - Character: `“hello”`
  - Numeric (real or decimal): `2`, `2.5`
  - Integer: `2` (whole numbers only)
  - Logical: `TRUE` or `FALSE`
  - Complex: `1+4i`

But how do we use variables from a dataset? In order to use a variable,
we have to call the dataset object, use a dollar sign, and then
reference the variable you want: e.g., `datasetname$variable1`. This
allows R to know where to look and what variable we want to use.

The `$` operator tells R to subset the data frame to a particular column
by name, and then return it as a vector. This is important because we go
from having a data frame to a vector (two different data structures).

``` r
#Explore your data with the functions length(), which states the number of observations, 
length(data$state)
```

    ## [1] 3221

``` r
length(my.matrix)
```

    ## [1] 10

``` r
#Determine the number of unique values in a variable
length(unique(data$state))
```

    ## [1] 52

``` r
#Examining variables using typeof() which will again list the variable type
typeof(data$state)
```

    ## [1] "integer"

``` r
typeof(data$hhinc_mean2000)
```

    ## [1] "character"

## Example 3: Changing variable type

Sometimes a variable might not be stored in a useful format. In order
for us to better use the variable, we might want to convert it to a
character (string) or integer (number). We can do that by using
“wrapper” functions that *coerce* values from one type to another.
They are easily identified by their `as.` prefix followed by the type we
would coerce values to.

``` r
#Change the variable type
data$state2 <- as.character(data$state) # this creates a new variable state2, which is state stored as a character, and stores it in our dataset
head(data) #this will now show you the dataset contains 36 instead of 35 columns, the last being our newest variable!
```

    ##   state county    cz     czname  hhinc_mean2000 mean_commutetime2000
    ## 1     1      1 11101 Montgomery twenty thousand             28.49060
    ## 2     1      3 11001     Mobile       76064.086             26.50108
    ## 3     1      5 10301    Eufaula       51246.004             24.04751
    ## 4     1      7 10801 Tuscaloosa       55094.492             32.87532
    ## 5     1      9 10700 Birmingham       62749.727             36.18924
    ## 6     1     11  9800     Auburn       41518.551             26.25119
    ##   frac_coll_plus2000 frac_coll_plus2010 foreign_share2010 med_hhinc1990
    ## 1         0.18973459         0.22199036       0.020154603      29718.64
    ## 2         0.23003615         0.26071036       0.037591625      26435.69
    ## 3         0.10744983         0.13349621       0.028143950      19026.75
    ## 4         0.07002571         0.09924053       0.006859188      19696.79
    ## 5         0.09621403         0.12633450       0.047343444      23159.69
    ## 6         0.07616644         0.10972187       0.013493270      14736.08
    ##   med_hhinc2016 poor_share2010 poor_share2000 poor_share1990 share_white2010
    ## 1      54052.80      0.1059177     0.10375097      0.1395835       0.7724616
    ## 2      52003.09      0.1229422     0.09859775      0.1400626       0.8350479
    ## 3      33114.85      0.2506308     0.27296948      0.2562720       0.4675311
    ## 4      39846.45      0.1268499     0.21399727      0.2132011       0.7502073
    ## 5      46361.12      0.1331379     0.11554340      0.1477678       0.8888734
    ## 6      31304.78      0.2804486     0.34550691      0.3760353       0.2191680
    ##   share_black2010 share_hisp2010 share_asian2010 share_black2000
    ## 1      0.18134174     0.02400542     0.007830280      0.16422907
    ## 2      0.09752284     0.04384824     0.005953514      0.09791613
    ## 3      0.47190151     0.05051535     0.003688206      0.46370360
    ## 4      0.22282349     0.01771765     0.000741872      0.22258869
    ## 5      0.01500297     0.08070200     0.001873596      0.01293185
    ## 6      0.70221734     0.07119296     0.001793249      0.73125643
    ##   share_white2000 share_hisp2000 share_asian2000 gsmn_math_g3_2013
    ## 1       0.8043379    0.013819249     0.004298492          2.759864
    ## 2       0.8659056    0.018494057     0.003541086          2.792510
    ## 3       0.5090733    0.016422329     0.002342030          1.600009
    ## 4       0.7608481    0.009978266     0.000767521          1.531674
    ## 5       0.9220281    0.052030329     0.001227109          2.815403
    ## 6       0.2319123    0.028622525     0.001945031          1.039439
    ##   rent_twobed2015 singleparent_share2010 singleparent_share1990
    ## 1        739.3654              0.2833759              0.1655400
    ## 2        816.8452              0.2778664              0.1842143
    ## 3        527.2908              0.4680706              0.2714696
    ## 4        604.2776              0.3201363              0.1886276
    ## 5        567.6959              0.2589052              0.1224555
    ## 6        266.0000              0.5778636              0.4718738
    ##   singleparent_share2000 traveltime15_2010   emp2000 mail_return_rate2010
    ## 1              0.2408110         0.2041625 0.6095865             82.33318
    ## 2              0.2378831         0.2753262 0.5770263             80.03409
    ## 3              0.3932633         0.3760492 0.4532710             74.89907
    ## 4              0.2572943         0.2526830 0.4942406             70.00357
    ## 5              0.1734077         0.1943438 0.5778096             83.10035
    ## 6              0.5960218         0.3921350 0.3746639             47.21169
    ##   ln_wage_growth_hs_grad popdensity2010 popdensity2000
    ## 1            -0.06331379       91.80268       73.46603
    ## 2             0.03009291      114.64751       88.32320
    ## 3             0.18936642       31.02921       32.81807
    ## 4            -0.02007263       36.80634       33.45096
    ## 5             0.09646260       88.90219       79.14806
    ## 6             0.36383346       17.52395       18.69649
    ##   ann_avg_job_growth_2004_2013 job_density_2013 state2
    ## 1                  0.010145103        40.719135      1
    ## 2                  0.012950056        50.085987      1
    ## 3                 -0.020755908         9.230672      1
    ## 4                 -0.004644653        12.875392      1
    ## 5                 -0.008120399        36.175354      1
    ## 6                  0.026254078         6.954023      1

## Example 4: Cleaning our dataset

By sorting mean household income 2000, we find a non-numeric character
stored as one of the values. We can create a new variable called income2
and store it in our dataset by using the assignment operator, however,
we will get an error which tells us that all of the values that contain
characters are turned into NA. This would bias our results later on when
we try to run summary statistics.

``` r
data$income2<-as.numeric(data$hhinc_mean2000)
```

    ## Warning: 强制改变过程中产生了NA

To get around this, we could recode our variable by characters into
numbers. For instance, we can recode the word twenty thousand to 20,000.
With the `recode()` function. We can then re-assign this new variable to
income2 using the `as.numeric()` wrapper and avoid inaccuracies in our
data.

``` r
data$hhinc_mean2000v2 <- recode(data$hhinc_mean2000, "twenty thousand" = "20000") #recodes
data$income2<-as.numeric(data$hhinc_mean2000v2) #over writes the previous variable
```

Sometimes variable names aren’t intuitive, so we might want to make some
changes. Here is an example of how to change variable names to make them
easier to use.

``` r
#Change a variable name using the dplyr package, which we'll learn more about in Lab 2
data <- data  %>% rename(commuting_zone = cz) # cz="commuting_zone" 
```

## Example 5: Merging data

Sometimes a .csv file might contain only part of the data we’re
interested in analyzing. In this example, we have a variety of
county-level demographic data, but we don’t have any county-level
outcomes. We can think about merging in another dataset that has this
information using `merge()`. To do this, we will need to find another
dataset that has a matching id variable, in this case county, and we
will need to load this into our environment. When running `merge()` we
place the two dataframes we want to connect together as the first two
arguments. This function will combine both datasets using the county id
variable. Any county ids that appear in one dataset but not the other
will be dropped, unless we add `all=TRUE` to the argument.

``` r
#Read in the file you want to merge
data2 <- read.csv('county_outcomes.csv') #read in your second file

#Merge your two dataframes together
cty_outcome_dems <- merge(data, data2, all=TRUE) 
```

## Example 6: Subsetting data

Sometimes merging datasets will get to be too big for us to work with on
our computer, so we can think about subsetting our data. Specifically,
maybe we only want to keep variables that are in State 1. We can do this
by subsetting our data using logical operators. Here is a list of
operators:

  - `<` means less than  
  - `>` means greater than  
  - `<=` means less than or equal to  
  - `>=` means greater than or equal to  
  - `==` means is equal to  
  - `!=` means not equal to

NOTE: `=` should only be used when assigning a value to a variable (this
is interchangeable with `<-`). However, `==` evaluates whether two
values are equal to each other (e.g., if we wanted to create an
indicator equal to 1 when income is equal to 2000, we could do this by
evaluating the following expression and placing it in the object
`income2000` \<- `income==2000`).

``` r
#Creating a smaller dataset
cty_oucome_dems_1 <- subset(cty_outcome_dems, state==1)
```

<br>

# Part D: Summary Statistics

All of the checks in the viewing the data section are helpful in
preparing the data before exploring the data by running simple
statistics. This part of data analysis is crucial for many reasons, but
two especially important ones are 1) it could uncover important data
discrepancies we missed in step C and 2) it allows us to get a sense of
relationships between our variables of interest.

## Example 1. Taking the mean of a variable

We want to know the average value of `hhinc_mean2000v2`, but we face a
problem. \* `hhinc_mean2000v2` contains `NA` values, or missing values,
which will prevent `mean()` from being able to compute the specified
statistic.

We can fix this by \* Adding to the argument `na.rm = TRUE`, which tells
R to remove all observations with `NA`

You can replace `mean()` with `min()`, `max()`, `median()`, `mode()`, or
whatever other mathematical operation you would like in order to explore
your data\!

``` r
#Average of mean household income in 2000 for all counties
meanhh <- mean(as.numeric(data$hhinc_mean2000v2), na.rm=TRUE) #we'll store the mean in a new variable/object called meanhh
print(meanhh) #in order for us to see the mean, we will print our new variable name
```

    ## [1] 65087.29

``` r
meanpoor <- mean(as.numeric(data$poor_share2000), na.rm=TRUE)
print(meanpoor)
```

    ## [1] 0.1410037

## Example 2. Creating new variabes

Sometimes we might want to create new variables, so we can better
examine our data. For instance, maybe we want to create an “indicator”
or a variable that is equal to 1 if something is true, or 0 otherwise. R
lets us do that using logical operators (as described above).

We can also use logical operators to compare two different vectors. In
the example below, if the argument on the right hand side is true, i.e.,
if the value held in `hhinc_mean2000v2` is greater than the mean we
calculated above in `meanhh`, then above\_meanhh will turn into a 1,
otherwise it will be coded as a 0.

``` r
#Creating new indicator variables
data$above_meanhh <- (data$hhinc_mean2000v2>meanhh)
data$above_meanpoor <- (data$poor_share2000>meanpoor)
head(data) #always check your dataset to make sure your new variables were created and stored properly
```

    ##   state county commuting_zone     czname  hhinc_mean2000 mean_commutetime2000
    ## 1     1      1          11101 Montgomery twenty thousand             28.49060
    ## 2     1      3          11001     Mobile       76064.086             26.50108
    ## 3     1      5          10301    Eufaula       51246.004             24.04751
    ## 4     1      7          10801 Tuscaloosa       55094.492             32.87532
    ## 5     1      9          10700 Birmingham       62749.727             36.18924
    ## 6     1     11           9800     Auburn       41518.551             26.25119
    ##   frac_coll_plus2000 frac_coll_plus2010 foreign_share2010 med_hhinc1990
    ## 1         0.18973459         0.22199036       0.020154603      29718.64
    ## 2         0.23003615         0.26071036       0.037591625      26435.69
    ## 3         0.10744983         0.13349621       0.028143950      19026.75
    ## 4         0.07002571         0.09924053       0.006859188      19696.79
    ## 5         0.09621403         0.12633450       0.047343444      23159.69
    ## 6         0.07616644         0.10972187       0.013493270      14736.08
    ##   med_hhinc2016 poor_share2010 poor_share2000 poor_share1990 share_white2010
    ## 1      54052.80      0.1059177     0.10375097      0.1395835       0.7724616
    ## 2      52003.09      0.1229422     0.09859775      0.1400626       0.8350479
    ## 3      33114.85      0.2506308     0.27296948      0.2562720       0.4675311
    ## 4      39846.45      0.1268499     0.21399727      0.2132011       0.7502073
    ## 5      46361.12      0.1331379     0.11554340      0.1477678       0.8888734
    ## 6      31304.78      0.2804486     0.34550691      0.3760353       0.2191680
    ##   share_black2010 share_hisp2010 share_asian2010 share_black2000
    ## 1      0.18134174     0.02400542     0.007830280      0.16422907
    ## 2      0.09752284     0.04384824     0.005953514      0.09791613
    ## 3      0.47190151     0.05051535     0.003688206      0.46370360
    ## 4      0.22282349     0.01771765     0.000741872      0.22258869
    ## 5      0.01500297     0.08070200     0.001873596      0.01293185
    ## 6      0.70221734     0.07119296     0.001793249      0.73125643
    ##   share_white2000 share_hisp2000 share_asian2000 gsmn_math_g3_2013
    ## 1       0.8043379    0.013819249     0.004298492          2.759864
    ## 2       0.8659056    0.018494057     0.003541086          2.792510
    ## 3       0.5090733    0.016422329     0.002342030          1.600009
    ## 4       0.7608481    0.009978266     0.000767521          1.531674
    ## 5       0.9220281    0.052030329     0.001227109          2.815403
    ## 6       0.2319123    0.028622525     0.001945031          1.039439
    ##   rent_twobed2015 singleparent_share2010 singleparent_share1990
    ## 1        739.3654              0.2833759              0.1655400
    ## 2        816.8452              0.2778664              0.1842143
    ## 3        527.2908              0.4680706              0.2714696
    ## 4        604.2776              0.3201363              0.1886276
    ## 5        567.6959              0.2589052              0.1224555
    ## 6        266.0000              0.5778636              0.4718738
    ##   singleparent_share2000 traveltime15_2010   emp2000 mail_return_rate2010
    ## 1              0.2408110         0.2041625 0.6095865             82.33318
    ## 2              0.2378831         0.2753262 0.5770263             80.03409
    ## 3              0.3932633         0.3760492 0.4532710             74.89907
    ## 4              0.2572943         0.2526830 0.4942406             70.00357
    ## 5              0.1734077         0.1943438 0.5778096             83.10035
    ## 6              0.5960218         0.3921350 0.3746639             47.21169
    ##   ln_wage_growth_hs_grad popdensity2010 popdensity2000
    ## 1            -0.06331379       91.80268       73.46603
    ## 2             0.03009291      114.64751       88.32320
    ## 3             0.18936642       31.02921       32.81807
    ## 4            -0.02007263       36.80634       33.45096
    ## 5             0.09646260       88.90219       79.14806
    ## 6             0.36383346       17.52395       18.69649
    ##   ann_avg_job_growth_2004_2013 job_density_2013 state2  income2
    ## 1                  0.010145103        40.719135      1 20000.00
    ## 2                  0.012950056        50.085987      1 76064.09
    ## 3                 -0.020755908         9.230672      1 51246.00
    ## 4                 -0.004644653        12.875392      1 55094.49
    ## 5                 -0.008120399        36.175354      1 62749.73
    ## 6                  0.026254078         6.954023      1 41518.55
    ##   hhinc_mean2000v2 above_meanhh above_meanpoor
    ## 1            20000        FALSE          FALSE
    ## 2        76064.086         TRUE          FALSE
    ## 3        51246.004        FALSE           TRUE
    ## 4        55094.492        FALSE           TRUE
    ## 5        62749.727        FALSE          FALSE
    ## 6        41518.551        FALSE           TRUE

## Example 3: Exploring relationships with our new variables

We can create a table with our new variables that will tell us how many
observations in our dataset meet a certain condition.

For the example below, we will find in the first row the number of
observations that are below the county mean for household income and
poor share (`FALSE`, `FALSE`) and the number below the county mean for
household income but above for poor share (`FALSE`, `TRUE`). The second
row will contain the number of observations that are above the county
mean for household income but below for poor share (`TRUE`, `FALSE`) and
the number above the county mean for household income and for poor share
(`TRUE`, `TRUE`).

``` r
#Creating a frequency table to explore our new variables
table(data$above_meanhh, data$above_meanpoor)
```

    ##        
    ##         FALSE TRUE
    ##   FALSE   870 1184
    ##   TRUE    954  134

## Example 4: Correlations

A frequency table provides good intuition for the distribution of the
data, but correlations will allow us to say whether the relationship
between two variables is strong or weak and further whether that
relationship is significant or not.

NOTE: a p-value \<0.01 is considered strongly significant, \<0.05 is
considered moderately significant, and \<0.1 is considered weakly
significant).

``` r
#we can print all of the correlation test to console by not using assignment
cor.test(data$income2, data$poor_share2000, method = "pearson")
```

    ## 
    ##  Pearson's product-moment correlation
    ## 
    ## data:  data$income2 and data$poor_share2000
    ## t = -49.493, df = 3140, p-value < 2.2e-16
    ## alternative hypothesis: true correlation is not equal to 0
    ## 95 percent confidence interval:
    ##  -0.6811972 -0.6418886
    ## sample estimates:
    ##        cor 
    ## -0.6619979

``` r
#Or we can save the correlation test output to an object for later use
res <- cor.test(data$income2, data$poor_share2000, method = "pearson")
res$estimate #displays the correlation coefficient
```

    ##        cor 
    ## -0.6619979

``` r
res$p.value #dispalys the p-value, which tells us if the correlation coefficient is significant
```

    ## [1] 0
