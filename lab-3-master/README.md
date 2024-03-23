# Lab 3: Explore COVID-19 data

## Goals

This lab builds on the skills developed in the first two labs, and will also introduce two more concepts:

  - Joining two data frames with `left_join()` or `inner_join()`
  - Handling dates with `as.Dates()`
  - Using the `paste()` function
  - Using `tidycensus()`
  - Creating a map of the US with descriptive statistics for each state

## Data

In this lab we will be working with COVID-related data the Opportunity Insights group has gathered for anyone to use in their research. 

You can read more about these data at the [Opportunity Lab Economic Tracker GitHub repository](https://github.com/Opportunitylab/EconomicTracker). These data include COVID-19 cases/deaths, spending, job postings, mobility, unemployment, and student learning at the state-, county-, and/or city-level. The website provides information on the data sources and data definitions.

For this lab we will focus on the COVID-19 cases data. To explore the data we will plot trends over time by state and create maps to show the geographic variation in cases across the US.

Steps:
  
  1. Download/prepare COVID-19 cases data 
  2. Graph COVID-19 trends by state
  3. Prepare for mapping
  4. Plot a _time series_
  4. Map COVID-19 cases by state
  
## Getting started
  
Go to [the lab 3 notebook](lab-3-notebook.md) to begin the guided tutorial.

Clone the lab 3 repository to run tutorial code natively on your own computer or to get started on the lab 3 problem set.

Either use the green button above to download a .zip of this repository

OR

Open a terminal (OS X, Linux) / git bash (Windows) and run:
`git clone "https://github.com/big-data-big-problems/lab-3.git"`
