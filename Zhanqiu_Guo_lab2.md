
> 3/3 pts for turning in .md file from .rmd that runs to completion and loads appropriate libraries

Hands-on Task 1: Wrangle the Craigslist data
============================================

Here you will use `dplyr` to complete process the listing data that we
started with to get a feel for writing data manipulation code. Once we
are done preparing the data, we will do some basic data visualization
and statistical analysis to understand patterns and relationships within
the data.


Load the listing data.
----------------------

    library(dplyr)

    ##
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ##
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ##
    ##     intersect, setdiff, setequal, union

    library(tidyverse)

    ## -- Attaching packages --------------------------------------------------- tidyverse 1.3.0 --

    ## √ ggplot2 3.3.2     √ purrr   0.3.4
    ## √ tibble  3.0.2     √ stringr 1.4.0
    ## √ tidyr   1.1.0     √ forcats 0.5.0
    ## √ readr   1.3.1

    ## -- Conflicts ------------------------------------------------------ tidyverse_conflicts() --
    ## x dplyr::filter() masks stats::filter()
    ## x dplyr::lag()    masks stats::lag()

    library(sf)

    ## Linking to GEOS 3.8.0, GDAL 3.0.4, PROJ 6.3.1

    library(lubridate)

    ##
    ## Attaching package: 'lubridate'

    ## The following objects are masked from 'package:base':
    ##
    ##     date, intersect, setdiff, union

    library(leaflet)
    load("./input/ithaca_rentals.RData")

> 1/1 pt for successfully loading listing data


Create a new data frame that is limited to 1 bedroom units.
-----------------------------------------------------------

    one_bedroom <- filter(scraped, scraped_beds == "1BR")

> 2/2 pts for subsetting to desired table with dplyr and assigning result to new df


Mutate fields in `scraped` that are currently character but should be numeric as new columns.
---------------------------------------------------------------------------------------------

    scraped <- mutate(scraped,clean_rent = parse_number(scraped_rent),
                      clean_sqft = parse_number(scraped_sqft),
                      clean_baths = parse_number(scraped_baths))

    ## Warning: 582 parsing failures.
    ## row col expected        actual
    ## 401  -- a number available now
    ## 409  -- a number available now
    ## 438  -- a number -
    ## 500  -- a number available now
    ## 508  -- a number available now
    ## ... ... ........ .............
    ## See problems(...) for more details.

    ## Warning: 84 parsing failures.
    ##  row col expected   actual
    ##  296  -- a number sharedBa
    ##  367  -- a number sharedBa
    ##  454  -- a number sharedBa
    ##  975  -- a number sharedBa
    ## 1306  -- a number sharedBa
    ## .... ... ........ ........
    ## See problems(...) for more details.

> 2/2 pts for creating numeric versions of fields with parse_number()


Create a new data frame with listings that mention “affordable” in their title
------------------------------------------------------------------------------

    affordable <- filter(scraped, str_detect(listing_title, pattern = "affordable"))

> 2/2 pts for creating new data frame with listings that mention affordable

Create a column in `scraped` indicating whether the rent asked is more than $800.
---------------------------------------------------------------------------------

    scraped <- mutate(scraped, scraped_rent > 800)

> 0/2 pts for creating a new column indicating rents greater than $800
> This is creating a column named `scraped_rent > 800`, which is not itself a problem
> but the values within it are incorrect since you ought to be using the _numeric_ rent.
> column for such an expression because >/< does not make sense on character columns.
> filter(scraped, `scraped_rent > 800`) shows 6 listings, none of which have value rent values.
> an acceptable answer would have been scraped <- mutate(scraped, gt_800 = clean_rent > 800)


Summarize the average square footage for 1, 2 and 3 bedroom units.
------------------------------------------------------------------

    summarize(filter(scraped, parse_number(scraped_beds) <= 3),
              mean_b=mean(parse_number(scraped_sqft),na.rm = T))

    ## Warning: 352 parsing failures.
    ## row col expected        actual
    ## 351  -- a number available now
    ## 359  -- a number available now
    ## 428  -- a number available now
    ## 436  -- a number available now
    ## 462  -- a number available now
    ## ... ... ........ .............
    ## See problems(...) for more details.

    ## Simple feature collection with 1 feature and 1 field
    ## geometry type:  MULTIPOINT
    ## dimension:      XY
    ## bbox:           xmin: -78.90302 ymin: 42.10337 xmax: -76.03615 ymax: 42.93978
    ## geographic CRS: WGS 84
    ##     mean_b                       geometry
    ## 1 695.7065 MULTIPOINT ((-78.90302 42.9...

> 2/4 pts for producing this summary table using a set of dplyr verbs
> The goal of this was to produce bedroom size specific averages, rather than an overall average.
> NB: you can use the numeric versions of these variables (clean_beds, clean_sqft) created earlier to avoid
> using parse_number() any time you need to use the numeric value.

Create a summary statistic table with the minimum, maximum and average rent values for 1 bedroom units, as well as the number of 1 bedroom units in the data.
-------------------------------------------------------------------------------------------------------------------------------------------------------------

    summarize(one_bedroom,min_1b=min(parse_number(scraped_rent),na.rm = T),
              max_1b=max(parse_number(scraped_rent),na.rm = T),
              mean_1b=mean(parse_number(scraped_rent),na.rm = T),
              length_1b=length(scraped_rent))

    ## Simple feature collection with 1 feature and 4 fields
    ## geometry type:  MULTIPOINT
    ## dimension:      XY
    ## bbox:           xmin: -78.90302 ymin: 42.10706 xmax: -76.17315 ymax: 42.93978
    ## geographic CRS: WGS 84
    ##   min_1b max_1b  mean_1b length_1b                       geometry
    ## 1      1   2400 1087.765      3738 MULTIPOINT ((-78.90302 42.9...

> 4/4 pts for producing summary table of rent values for 1 bedrooms.
> NB: would help to establish ceiling/floor here to remove $1 (this is definitely not a real unit)

Create a summary table for the proportion of 1, 2 and 3 bedroom units with rents below Fair Market Rent levels set by the Department of Housing and Urban Development.
----------------------------------------------------------------------------------------------------------------------------------------------------------------------

You will want to consult
[this](https://www.rentdata.org/ithaca-ny-msa/2018) site for the FMR
values. Hint: you could use `case_when()` to create a FMR column with
each bedroom size’s FMR value and then `mutate()` another column
flagging if the row’s rent was greater than or less than the FMR.

    scraped <- mutate(scraped, clean_beds = parse_number(scraped_beds))
    scraped <- mutate(scraped, clean_beds = ifelse(clean_beds > 6, NA, clean_beds))
    fmr <- scraped %>%
    mutate(limit = case_when(
           clean_beds == 1 ~ 978,
           clean_beds == 2 ~ 1164,
           clean_beds == 3 ~ 1495))  %>%
    mutate(clean_rent < limit)
    table(fmr$`clean_rent < limit`, useNA = "always")

    ##
    ## FALSE  TRUE  <NA>
    ##  8341  2716  2096

    sum(fmr$`clean_rent < limit`,na.rm = T)/length(scraped$clean_rent)

    ## [1] 0.2064928

> 4/5 pts for calculating table with proportion of 1, 2, and 3 bedroom listings covered by FMR
> The goal was to compute bedroom-specific proportions but you've nonetheless done everything
> else that was required here.

If housing assistance allows households to rent units up to the FMR level, how much choice would you say they have on the rental markes? What policy proposals, if any, would you propose given the evidence you’ve generated using current rental listings?
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

They have 2716 kinds of choice. The houses with rents lower than FMR
level is only 21% of the whole market. The rental market is overheating
and mn people may can’t afford the price. The government could subsidize
the renters. Therefore, they will be more willing to set a lower price
to meet the FMR standard. As the price decreases, more tenant could
afford the price, solving the housing problem in the society.

> 3/3pts for discussion of proportions, implications for housing opportunities and
> possible policy prescriptions.
> Your interpretation regarding FMRs providing narrow range of choice is spot on.
> I'm not sure I follow your reasoning since we're already talking about subsidizing renters because they receive assistance,
> but I'll give give you the benefit of the doubt and assume you mean additional incentives for landlords that
> work with assisted households.
> I think the general contours of a proposal would be to increase FMR levels, incentivize landlords to keep
> rents below FMR (e.g. tax break), subsidize below-FMR development, or set a cap on rent increases (i.e. rent control).

<br>
<hr>

<br>

Hands-on Task 2: Making some plots of the Craigslist data
=========================================================

Create and interpret a scatterplot of square footage by rent asked for 2 bedroom listings using `ggplot()`.
-----------------------------------------------------------------------------------------------------------

    point <- scraped %>% filter(parse_number(scraped_beds)==2)
    ggplot(point, aes(x = clean_sqft, y = clean_rent)) +
      geom_point()

    ## Warning: Removed 487 rows containing missing values (geom_point).

![](lab_2_problem_set_files/figure-markdown_strict/unnamed-chunk-11-1.png)

> 1.5/3 pts for creation and interpretation of scatterplot. Your code would create
> the scatterplot but you did not provide any interpretation of the graphic.

Create and interpret a bar chart of average square footage by bedroom size using `ggplot()`.
--------------------------------------------------------------------------------------------

    sum_df <- scraped %>%
      group_by(clean_beds) %>%
      summarize(median = median(clean_sqft,na.rm = T))

    ## `summarise()` ungrouping output (override with `.groups` argument)

    ggplot(sum_df, aes(x = clean_beds, y = median)) +
      geom_bar(stat = "identity")

    ## Warning: Removed 1 rows containing missing values (position_stack).

![](lab_2_problem_set_files/figure-markdown_strict/unnamed-chunk-12-1.png)

> 1.5/3 pts for creation and interpretation of bar graphic. Your code creates
> a bar graphic but you did not provide an interpretation. You also computed the median
> rather than the mean/average, though I won't take points off for this.

Create and interpret a histogram of square footage using `ggplot()`.
--------------------------------------------------------------------

    ggplot(point, aes(x = clean_sqft)) +
      geom_histogram()

    ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.

    ## Warning: Removed 487 rows containing non-finite values (stat_bin).

![](lab_2_problem_set_files/figure-markdown_strict/unnamed-chunk-13-1.png)

> 1.5/3 pts for creation and interpretation of histogram. Your code creates a
> histogram but you did not provide an interpretation.

Create and interpret a ggplot of your choice using the listing data that incorporates the color aesthetic.
----------------------------------------------------------------------------------------------------------

    ggplot(scraped, aes(x = clean_sqft, y = clean_rent,color = clean_rent)) +
      geom_point()

    ## Warning: Removed 2861 rows containing missing values (geom_point).

![](lab_2_problem_set_files/figure-markdown_strict/unnamed-chunk-14-1.png)
This shows the relation between the rent and the the square footage. The
lighter the point, the higher the rent.

> 4/4 pts for creating interpreting your own ggplot that has a color aesthetic.

<br>
<hr>

<br>

Hands-on Task 3: Correlation
============================

Estimate the correlation between square footage and rent overall and interpret this statistic.
----------------------------------------------------------------------------------------------

    cor.test(scraped$clean_sqft,scraped$clean_rent,method = "pearson")

    ##
    ##  Pearson's product-moment correlation
    ##
    ## data:  scraped$clean_sqft and scraped$clean_rent
    ## t = 34.133, df = 10290, p-value < 2.2e-16
    ## alternative hypothesis: true correlation is not equal to 0
    ## 95 percent confidence interval:
    ##  0.3014562 0.3361675
    ## sample estimates:
    ##       cor
    ## 0.3189188

The p-value is smaller than 2.2e-16, the correlation is significant. The
cor value is about 0.3,which is weak positive relation. This means
higher square foot may leads to higher rent. <br>

> 3/3 pts for estimating and interpreting correlation. Good work.

<hr>

<br>

Hands-on Task 4: Make a map
===========================

Create a map of 2 bedroom units listed in May with `ggplot()` or `leaflet()`
----------------------------------------------------------------------------

    scraped <- scraped %>%
      filter(month(listing_date)==5)
    scraped <- st_set_crs(scraped, "EPSG:4326")
    ggplot(scraped) +
      geom_sf()

![](lab_2_problem_set_files/figure-markdown_strict/unnamed-chunk-16-1.png)

    leaflet(scraped) %>%
      addTiles() %>%
      addMarkers()

 > 2/3 pts for creating the requested map. You need to add a bedroom size filter
 > to create the map that the question asks for.



Create a map of 1 bedroom units listed in May that have a rent asked that is below Fair Market Rent with `ggplot()` or `leaflet()`
----------------------------------------------------------------------------------------------------------------------------------

    scraped <- scraped %>%
      filter(month(listing_date)==5,clean_beds==1,clean_rent<978)
    scraped <- st_set_crs(scraped, "EPSG:4326")
    ggplot(scraped) +
      geom_sf()

![](lab_2_problem_set_files/figure-markdown_strict/unnamed-chunk-17-1.png)

    leaflet(scraped) %>%
      addTiles() %>%
      addMarkers()

  > 3/3 pts for creating the requested map.

> 39.5/50 pts
