Lab 4 Problem Set
================

  - [Submission Instructions](#submission-instructions)
  - [Data Overview](#data-overview)
  - [Problem Set Questions](#problem-set-questions)
      - [1. Read in the crime data using the `renamefrom()` function.
        You will need to create a
        crosswalk.](#read-in-the-crime-data-using-the-renamefrom-function.-you-will-need-to-create-a-crosswalk.)
      - [2. Merge in the demographic data. Examine your variables.
        Correct the three variables that are incorrectly coded. You need
        to determine which variables these are by viewing your data and
        running the checks we learned in lab
        1.](#merge-in-the-demographic-data.-examine-your-variables.-correct-the-three-variables-that-are-incorrectly-coded.-you-need-to-determine-which-variables-these-are-by-viewing-your-data-and-running-the-checks-we-learned-in-lab-1.)
      - [3. Write a null and alternative hypothesis that you can
        feasibly answer with your data (e.g., crime rates (consider
        overall, index, violent, or property) are higher in counties
        with higher proportions of X). Your hypothesis should NOT be
        related to time; we will examine this
        later.](#write-a-null-and-alternative-hypothesis-that-you-can-feasibly-answer-with-your-data-e.g.-crime-rates-consider-overall-index-violent-or-property-are-higher-in-counties-with-higher-proportions-of-x.-your-hypothesis-should-not-be-related-to-time-we-will-examine-this-later.)
      - [4. Run a preliminary correlation for your hypothesis. Report on
        the strength of the relationship, the significance level, and
        whether the correlation supports your null or alternative
        hypothesis. (HINT: If you use a demographic variable that is
        reported as a count, you will need to turn this into a
        proportion. Also consider whether your variable makes sense on
        its
        own).](#run-a-preliminary-correlation-for-your-hypothesis.-report-on-the-strength-of-the-relationship-the-significance-level-and-whether-the-correlation-supports-your-null-or-alternative-hypothesis.-hint-if-you-use-a-demographic-variable-that-is-reported-as-a-count-you-will-need-to-turn-this-into-a-proportion.-also-consider-whether-your-variable-makes-sense-on-its-own.)
      - [5. Run a ttest for your hypothesis. In order to run a ttest,
        your independent variable will need to be binary (or coded as 0
        v 1). Recall we created indicators in lab 1. Write a rationale
        for why you split your variable the way you did. Report the
        means of your outcome for the two groups you created, and the
        significance level from the ttest. Compare your findings here to
        step 4. Speak to similarities and differences between the two
        tests.](#run-a-ttest-for-your-hypothesis.-in-order-to-run-a-ttest-your-independent-variable-will-need-to-be-binary-or-coded-as-0-v-1.-recall-we-created-indicators-in-lab-1.-write-a-rationale-for-why-you-split-your-variable-the-way-you-did.-report-the-means-of-your-outcome-for-the-two-groups-you-created-and-the-significance-level-from-the-ttest.-compare-your-findings-here-to-step-4.-speak-to-similarities-and-differences-between-the-two-tests.)
      - [6. What other variables do you think could explain the
        relationship you found in step 4? Write at least 2 other
        variables you think could attenuate (or weaken) your
        relationship and explain why. If necessary, recode the variables
        in this section. The way you code your variables will help you
        tell your story later on. Finally, thinking back to lab 4 write
        1 sentence about whether it make sense to use factors you use
        factors?](#what-other-variables-do-you-think-could-explain-the-relationship-you-found-in-step-4-write-at-least-2-other-variables-you-think-could-attenuate-or-weaken-your-relationship-and-explain-why.-if-necessary-recode-the-variables-in-this-section.-the-way-you-code-your-variables-will-help-you-tell-your-story-later-on.-finally-thinking-back-to-lab-4-write-1-sentence-about-whether-it-make-sense-to-use-factors-you-use-factors)
      - [7. Create a graph/plot/map of your choice that examines your
        hypothesis from step 3/4. Replicate your graph/plot/map but this
        time adding in trends for the different groups you identified in
        step 6. Write 1-2 sentences briefly summarizing what you find.
        (HINT: Think about whether a line graph or a bar chart makes
        more sense for this exercise. Feel free to get creative here.
        You may add in a time dimension if you would like, though it is
        not
        necessary).](#create-a-graphplotmap-of-your-choice-that-examines-your-hypothesis-from-step-34.-replicate-your-graphplotmap-but-this-time-adding-in-trends-for-the-different-groups-you-identified-in-step-6.-write-1-2-sentences-briefly-summarizing-what-you-find.-hint-think-about-whether-a-line-graph-or-a-bar-chart-makes-more-sense-for-this-exercise.-feel-free-to-get-creative-here.-you-may-add-in-a-time-dimension-if-you-would-like-though-it-is-not-necessary.)
      - [8. Run three linear models. The first model should be the
        “naive” model that only examines the relationship between your
        outcome and independent variable (identified in step 4). Your
        second model should be your “control” model where you add in the
        groups you identified in step 6. Your final model is another
        “control” model where you add year to your model (add year by
        itself removing the groups from your second model). Write 3-4
        sentences interpreting the estimates between your naive and
        control models. Pay particular attention to estimates,
        significance, and your r-squared and compare between your
        models. Think hard about what your estimates actually mean. Your
        interpration of the estimates depend on how your outcome
        variable was
        coded.](#run-three-linear-models.-the-first-model-should-be-the-naive-model-that-only-examines-the-relationship-between-your-outcome-and-independent-variable-identified-in-step-4.-your-second-model-should-be-your-control-model-where-you-add-in-the-groups-you-identified-in-step-6.-your-final-model-is-another-control-model-where-you-add-year-to-your-model-add-year-by-itself-removing-the-groups-from-your-second-model.-write-3-4-sentences-interpreting-the-estimates-between-your-naive-and-control-models.-pay-particular-attention-to-estimates-significance-and-your-r-squared-and-compare-between-your-models.-think-hard-about-what-your-estimates-actually-mean.-your-interpration-of-the-estimates-depend-on-how-your-outcome-variable-was-coded.)
      - [9. Visualize your regressions by graphing the residuals from
        both your naive and control models in step 8. Write 3-4 setences
        explaining what the graphs show, paying particular attention to
        the interpretation of your confidence
        intervals.](#visualize-your-regressions-by-graphing-the-residuals-from-both-your-naive-and-control-models-in-step-8.-write-3-4-setences-explaining-what-the-graphs-show-paying-particular-attention-to-the-interpretation-of-your-confidence-intervals.)
      - [10. For a policy leader of your choice, explain your hypothesis
        and why it is important for them to consider. Next summarize
        your findings. Finally, recall that our data represents counties
        in New York State for the years 2016 to 2018. What other data
        would you like in order to better understand your hypotheses
        (e.g., time points, neighborhoods)? How would this data better
        help you answer the question you are interested in? Specifically
        speak to HOW this new data would allow you to isolate the
        relationship you’re interested in. Write 2-3
        paragraphs.](#for-a-policy-leader-of-your-choice-explain-your-hypothesis-and-why-it-is-important-for-them-to-consider.-next-summarize-your-findings.-finally-recall-that-our-data-represents-counties-in-new-york-state-for-the-years-2016-to-2018.-what-other-data-would-you-like-in-order-to-better-understand-your-hypotheses-e.g.-time-points-neighborhoods-how-would-this-data-better-help-you-answer-the-question-you-are-interested-in-specifically-speak-to-how-this-new-data-would-allow-you-to-isolate-the-relationship-youre-interested-in.-write-2-3-paragraphs.)

<br>

<hr>

<br>

# Submission Instructions

Download the lab-four-problem-set.rmd file from GitHub and code your
answers in that file. Rename the file lastname\_firstname\_lab1.md. You
must knit your .rmd as an .md. Upload your problem set through the
Assignments tab in Canvas by July 29th at 12PM. Remember that in an R
Markdown file writing in the white space will be read as text, so you
write responses to your questions in the white space.

# Data Overview

Our data represents crime rates by county in New York from 2016-2018.
Crime rates are reported using three categories: Index, Violent, and
Property Crimes. Data was collected from
<https://www.criminaljustice.ny.gov/crimnet/ojsa/countycrimestats.htm>.
We also have demographic information for each county collected from the
United States Census. Definitions for each variables are below.

Variables:

| Variable                                          | Description                                                                                                                                                                                                                                                                                                       |
| ------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `gisjoin`                                         | GIS unique id that allows the user to merge data to a county GIS shapefile                                                                                                                                                                                                                                        |
| `year`                                            | Year the data was collected. Census data was collected between 2014-2018 and is presented as a weighted average, but we should think of all demographic data as coming from 2016.                                                                                                                                 |
| `county/countyname`                               | County name                                                                                                                                                                                                                                                                                                       |
| `countya/countfip`                                | County FIPS code                                                                                                                                                                                                                                                                                                  |
| `male`                                            | male represents the total number of individuals who identify as male overall and by the following age groups: under 18, 18 to 34 years of age, 35 to 64 years of age, and 65 or older. The total number of individuals who were surveyed to obtain these statistics are found in sex by age: total population     |
| `female`                                          | female represents the total number of individuals who identify as female overall and by the following age groups: under 18, 18 to 34 years of age, 35 to 64 years of age, and 65 or older. The total number of individuals who were surveyed to obtain these statistics are found in sex by age: total population |
| `race`                                            | Race represents the total number of individuals who identify as white, Black, Asian, American Indian, Nativan Hawaiian or other. The total number of individuals who were surveyed to obtain these statistics are found in Race: total population                                                                 |
| `education`                                       | Education represents the total number of individuals who have achieved a certain level of education as defined by HS degree or less, some college, and college or more. The total number of individuals who were surveyed to obtain these statistics are found in education: total population                     |
| `median household income`                         | The median household income                                                                                                                                                                                                                                                                                       |
| `proportion (un)employed in civilian labor force` | Of the civilian labor force, these are the proportions (0-1) of individuals who are either employed or unemployed. This does not include those serving in the armed forces or those that are not in the civilian labor force (e.g., individuals over 65)                                                          |
| `population`                                      | The total number of indivudals living in the county                                                                                                                                                                                                                                                               |
| `index crime`                                     | Index crimes include all counts of murder and nonnegligent homicide, rape, robbery, aggravated assualt, burglary, motor vehicle theft, larceny-theft, and arson                                                                                                                                                   |
| `violent crime`                                   | Violent crime is defined as an event where an offender or perpetrator uses or threatens to use force upon a victim                                                                                                                                                                                                |
| `property crime`                                  | Property crime is defined as an event where a victim’s property is stolen or destroyed without the use or threat of force against the victim. This is represented as an overall count of occurences and a rate per                                                                                                |
| `new york city`                                   | This is an indicator stating whether the county is in New York City                                                                                                                                                                                                                                               |

# Problem Set Questions

## 1\. Read in the crime data using the `renamefrom()` function. You will need to create a crosswalk.

``` r
#Code your answer here
```

## 2\. Merge in the demographic data. Examine your variables. Correct the three variables that are incorrectly coded. You need to determine which variables these are by viewing your data and running the checks we learned in lab 1.

``` r
#Code your answer here
```

## 3\. Write a null and alternative hypothesis that you can feasibly answer with your data (e.g., crime rates (consider overall, index, violent, or property) are higher in counties with higher proportions of X). Your hypothesis should NOT be related to time; we will examine this later.

Write your answer here

## 4\. Run a preliminary correlation for your hypothesis. Report on the strength of the relationship, the significance level, and whether the correlation supports your null or alternative hypothesis. (HINT: If you use a demographic variable that is reported as a count, you will need to turn this into a proportion. Also consider whether your variable makes sense on its own).

Write your response here

``` r
#Code your answer here
```

## 5\. Run a ttest for your hypothesis. In order to run a ttest, your independent variable will need to be binary (or coded as 0 v 1). Recall we created indicators in lab 1. Write a rationale for why you split your variable the way you did. Report the means of your outcome for the two groups you created, and the significance level from the ttest. Compare your findings here to step 4. Speak to similarities and differences between the two tests.

Write your response here

``` r
#Code your answer here
```

## 6\. What other variables do you think could explain the relationship you found in step 4? Write at least 2 other variables you think could attenuate (or weaken) your relationship and explain why. If necessary, recode the variables in this section. The way you code your variables will help you tell your story later on. Finally, thinking back to lab 4 write 1 sentence about whether it make sense to use factors you use factors?

Write your response here

``` r
#If applicable, code your answer here
```

## 7\. Create a graph/plot/map of your choice that examines your hypothesis from step 3/4. Replicate your graph/plot/map but this time adding in trends for the different groups you identified in step 6. Write 1-2 sentences briefly summarizing what you find. (HINT: Think about whether a line graph or a bar chart makes more sense for this exercise. Feel free to get creative here. You may add in a time dimension if you would like, though it is not necessary).

``` r
#Code your answer here
```

## 8\. Run three linear models. The first model should be the “naive” model that only examines the relationship between your outcome and independent variable (identified in step 4). Your second model should be your “control” model where you add in the groups you identified in step 6. Your final model is another “control” model where you add year to your model (add year by itself removing the groups from your second model). Write 3-4 sentences interpreting the estimates between your naive and control models. Pay particular attention to estimates, significance, and your r-squared and compare between your models. Think hard about what your estimates actually mean. Your interpration of the estimates depend on how your outcome variable was coded.

``` r
#Code your answer here
```

## 9\. Visualize your regressions by graphing the residuals from both your naive and control models in step 8. Write 3-4 setences explaining what the graphs show, paying particular attention to the interpretation of your confidence intervals.

``` r
#Code your answer here
```

## 10\. For a policy leader of your choice, explain your hypothesis and why it is important for them to consider. Next summarize your findings. Finally, recall that our data represents counties in New York State for the years 2016 to 2018. What other data would you like in order to better understand your hypotheses (e.g., time points, neighborhoods)? How would this data better help you answer the question you are interested in? Specifically speak to HOW this new data would allow you to isolate the relationship you’re interested in. Write 2-3 paragraphs.

Write your answer here.
