# Lab Tutorial 2 - The Rent Is Too High

## Goals

In this lab tutorial, we will focus on honing our data analysis skills using the `tidyverse` libraries. These software libraries include:

- `dplyr` - a *very* important package for handling most data manipulation tasks
- `ggplot2` - functions to create beautiful data visualizations with the "grammar of graphics"
- `tibble` - a special data frame object with some nice features to improve usability
- `tidyr` - functions to change the structure of data to redefine what a row means
- `readr` - functions to load different filetypes of structured data and to parse the values into R classes
- `stringr` - functions to work with character class, or string, values in a data frame (e.g., look for patterns)
- `forcats` - functions to work with factor class values (where integer values correspond to a set of character values)

## Data

The data for this lab are a set of apartment listings in the Ithaca, NY area that we scraped from the internet. Rental listings indicate a housing vacancy somewhere in the real world, so these are intrinsically *spatial data* that contain information about the unit itself, as well as information about its location in physical space. Since we are working with spatial data, the final part of this lab will introduce tools that R has for acting as a *Geographic Information System* (GIS).

## Getting started

Go to [the lab 2 notebook](lab_2_notebook.md) to get started with the guided tutorial.

Clone the lab 2 repository to run tutorial code natively on your own computer or to get started on the lab 2 problem set.

Either use the green button above to download a .zip of this repository

OR

Open a terminal (OS X, Linux) / git bash (Windows) and run:
`git clone "https://github.com/big-data-big-problems/lab-2.git"`
