# Data importing

## Readings

1. R4DS [Chapter 10](http://r4ds.had.co.nz/tibbles.html), [Chapter 11](http://r4ds.had.co.nz/data-import.html)

## Tibbles vs. data.frame

### Data frames are awesome

Whenever you have rectangular, spreadsheet-y data, your default data receptacle in R is a data frame. Do not depart from this without good reason. Data frames are awesome because...

  * Data frames package related variables neatly together,
    - keeping them in sync vis-a-vis row order
    - applying any filtering of observations uniformly.
  * Most functions for inference, modelling, and graphing are happy to be passed a data frame via a `data =` argument. This has been true in base R for a long time.
  * The set of packages known as the [`tidyverse`](https://github.com/hadley/tidyverse) takes this one step further and explicitly prioritizes the processing of data frames. This includes popular packages like `dplyr` and `ggplot2`. In fact the tidyverse prioritizes a special flavor of data frame, called a "tibble."

Data frames -- unlike general arrays or, specifically, matrices in R -- can hold variables of different flavors, such as character data (subject ID or name), quantitative data (white blood cell count), and categorical information (treated vs. untreated). If you use homogenous structures, like matrices, for data analysis, you  are likely to make the terrible mistake of spreading a dataset out over multiple, unlinked objects. Why? Because you can't put character data, such as subject name, into the numeric matrix that holds white blood cell count. This fragmentation is a Bad Idea.

In [Programming with R] we use `data.frame` in base R as our main data structure. From now on we will start to use `tibble` and other functions in  [`tidyverse`](https://github.com/hadley/tidyverse) as much as possible. This will provide a special type of data frame called a "tibble" that has nice default printing behavior, among other benefits such as speed performance and better default behavior.

First, install tidyverse packages if you haven't yet, you only need to do this once on your laptop:


```r
install.packages("tidyverse")
```

Then load the tidyverse packages:

```r
library(tidyverse)
```

```
## Loading tidyverse: ggplot2
## Loading tidyverse: tibble
## Loading tidyverse: tidyr
## Loading tidyverse: readr
## Loading tidyverse: purrr
## Loading tidyverse: dplyr
```

```
## Conflicts with tidy packages ----------------------------------------------
```

```
## filter(): dplyr, stats
## lag():    dplyr, stats
```

There are two main differences in the usage of a tibble vs. a classic `data.frame`: printing and subsetting.

### Printing

Tibbles have a refined print method that shows only the first 10 rows, and all the columns that fit on screen. This makes it much easier to work with large data. In addition to its name, each column reports its type, a nice feature borrowed from `str()`:


```r
tibble(
  a = lubridate::now() + runif(1e3) * 86400,
  b = lubridate::today() + runif(1e3) * 30,
  c = 1:1e3,
  d = runif(1e3),
  e = sample(letters, 1e3, replace = TRUE)
)
```

```
## # A tibble: 1,000 x 5
##                      a          b     c         d     e
##                 <dttm>     <date> <int>     <dbl> <chr>
##  1 2017-11-27 09:25:08 2017-12-07     1 0.3691793     i
##  2 2017-11-27 12:27:02 2017-12-11     2 0.8357064     w
##  3 2017-11-26 23:42:29 2017-12-14     3 0.3489976     a
##  4 2017-11-27 05:23:20 2017-12-16     4 0.2364787     h
##  5 2017-11-26 23:10:14 2017-12-19     5 0.5347933     j
##  6 2017-11-27 01:51:47 2017-12-10     6 0.1535821     k
##  7 2017-11-27 11:00:27 2017-12-16     7 0.4882053     o
##  8 2017-11-27 11:04:42 2017-12-07     8 0.2242546     e
##  9 2017-11-27 16:19:40 2017-12-13     9 0.6103028     a
## 10 2017-11-27 04:15:50 2017-12-08    10 0.6990164     a
## # ... with 990 more rows
```

`lubridate` is a R package for date and time. You need to install the package if you want to replicate the above code on your own computer.

Tibbles are designed so that you don't accidentally overwhelm your console when you print large data frames. But sometimes you need more output than the default display. There are a few options that can help.

First, you can explicitly `print()` the data frame and control the number of rows (`n`) and the `width` of the display. `width = Inf` will display all columns:


```r
print(mtcars, n = 10, width = Inf)
```

You can also control the default print behaviour by setting options:

* `options(tibble.print_max = n, tibble.print_min = m)`: if more than `m`
  rows, print only `n` rows. Use `options(dplyr.print_min = Inf)` to always
  show all rows.

* Use `options(tibble.width = Inf)` to always print all columns, regardless
  of the width of the screen.

You can see a complete list of options by looking at the package help with `package?tibble`.

A final option is to use RStudio's built-in data viewer to get a scrollable view of the complete dataset. This is also often useful at the end of a long chain of manipulations.


```r
View(mtcars)
```

### Subsetting

So far all the tools you've learned have worked with complete data frames. If you want to pull out a single variable, you need some new tools, `$` and `[[`. `[[` can extract by name or column position; `$` only extracts by name but is a little less typing.


```r
df <- tibble(
  x = runif(5),
  y = rnorm(5)
)

# Extract by name
df$x
```

```
## [1] 0.87235111 0.73370038 0.05790868 0.19026375 0.47509619
```

```r
df[["x"]]
```

```
## [1] 0.87235111 0.73370038 0.05790868 0.19026375 0.47509619
```

```r
# Extract by column position
df[[1]]
```

```
## [1] 0.87235111 0.73370038 0.05790868 0.19026375 0.47509619
```

<!-- To use these in a pipe, you'll need to use the special placeholder `.`: -->

<!-- ```{r} -->
<!-- df %>% .$x -->
<!-- df %>% .[["x"]] -->
<!-- ``` -->

Compared to a `data.frame`, tibbles are more strict: they never do partial matching, and they will generate a warning if the column you are trying to access does not exist.

### Converting

Some older functions don't work with tibbles. If you encounter one of these functions, use `as.data.frame()` to turn a tibble back to a `data.frame`:


```r
class(as.data.frame(df))
```

```
## [1] "data.frame"
```

Or use `as_tibble()` to convert a data.frame to tibble:


```r
class(as_tibble(mtcars))
```

```
## [1] "tbl_df"     "tbl"        "data.frame"
```


The main reason that some older functions don't work with tibble is the `[` function.  We don't use `[` much in this book because `dplyr::filter()` and `dplyr::select()` allow you to solve the same problems with clearer code (but you will learn a little about it in [vector subsetting](#vector-subsetting)). With base R data frames, `[` sometimes returns a data frame, and sometimes returns a vector. With tibbles, `[` always returns another tibble.

## Data Import

The most common data in data science is rectangular, spreadsheet-y data that works best to be loaded as a R data frame, and this section focus on import data into R as data frames. `tidyverse` provides the [`readr`](https://github.com/tidyverse/readr) package that reads comma-separated values (csv), tab delimited values (tsv), and fixed width files (fwf) as tibbles. Other R packages provide access to Excel spreadsheets, binary statistical data formats (SPSS, SAS, Stata), and relational databases:

* [readr](https://github.com/tidyverse/readr), reads flat files (csv, tsv, fwf) into R
* [readxl](https://github.com/tidyverse/readxl), reads excel files (.xls and .xlsx) into R
* [heaven](https://github.com/tidyverse/haven), reads SPSS, Stata and SAS files into R
* [rstats-db](https://github.com/rstats-db), R interface to databases
   * [RMySQL](https://github.com/rstats-db/RMySQL)
   * [RSQLite](https://github.com/rstats-db/RSQLite)
   * [RPostgres](https://github.com/rstats-db/RPostgres)
   * ...

For this section, we primarily focus on importing data in flat files into data frames. `readr` provides these functions:

* `read_csv()` reads comma delimited files, `read_csv2()` reads semicolon
  separated files (common in countries where `,` is used as the decimal place),
  `read_tsv()` reads tab delimited files, and `read_delim()` reads in files
  with any delimiter.

* `read_fwf()` reads fixed width files. You can specify fields either by their
  widths with `fwf_widths()` or their position with `fwf_positions()`.
  `read_table()` reads a common variation of fixed width files where columns
  are separated by white space.

* `read_log()` reads Apache style log files. (But also check out
  [webreadr](https://github.com/Ironholds/webreadr) which is built on top
  of `read_log()` and provides many more helpful tools.)

These functions all have similar syntax: once you've mastered one, you can use the others with ease. For the rest of this chapter we'll focus on `read_csv()`. Not only are csv files one of the most common forms of data storage, but once you understand `read_csv()`, you can easily apply your knowledge to all the other functions in readr.

The first argument to `read_csv()` is the most important: it's the path to the file to read.


```r
heights <- read_csv("data/heights.csv")
```

```
## Parsed with column specification:
## cols(
##   earn = col_double(),
##   height = col_double(),
##   sex = col_character(),
##   ed = col_integer(),
##   age = col_integer(),
##   race = col_character()
## )
```

```r
heights
```

```
## # A tibble: 1,192 x 6
##     earn   height    sex    ed   age     race
##    <dbl>    <dbl>  <chr> <int> <int>    <chr>
##  1 50000 74.42444   male    16    45    white
##  2 60000 65.53754 female    16    58    white
##  3 30000 63.62920 female    16    29    white
##  4 50000 63.10856 female    16    91    other
##  5 51000 63.40248 female    17    39    white
##  6  9000 64.39951 female    15    26    white
##  7 29000 61.65633 female    12    49    white
##  8 32000 72.69854   male    17    46    white
##  9  2000 72.03947   male    15    21 hispanic
## 10 27000 72.23493   male    12    26    white
## # ... with 1,182 more rows
```

When you run `read_csv()` it prints out a column specification that gives the name and type of each column. That's an important part of readr, which we'll come back to in [parsing a file].

`read_csv()` uses the first line of the data for the column names, which is a very common convention. There are two cases where you might want to tweak this behaviour:

1.  Sometimes there are a few lines of metadata at the top of the file. You can
    use `skip = n` to skip the first `n` lines; or use `comment = "#"` to drop
    all lines that start with (e.g.) `#`.
    
    
    ```r
    read_csv("The first line of metadata
      The second line of metadata
      x,y,z
      1,2,3", skip = 2)
    ```
    
    ```
    ## # A tibble: 1 x 3
    ##       x     y     z
    ##   <int> <int> <int>
    ## 1     1     2     3
    ```
    
    ```r
    read_csv("# A comment I want to skip
      x,y,z
      1,2,3", comment = "#")
    ```
    
    ```
    ## # A tibble: 1 x 3
    ##       x     y     z
    ##   <int> <int> <int>
    ## 1     1     2     3
    ```
    
1.  The data might not have column names. You can use `col_names = FALSE` to
    tell `read_csv()` not to treat the first row as headings, and instead
    label them sequentially from `X1` to `Xn`:
    
    
    ```r
    read_csv("1,2,3\n4,5,6", col_names = FALSE)
    ```
    
    ```
    ## # A tibble: 2 x 3
    ##      X1    X2    X3
    ##   <int> <int> <int>
    ## 1     1     2     3
    ## 2     4     5     6
    ```
    
    (`"\n"` is a convenient shortcut for adding a new line. You'll learn more
    about it and other types of string escape in [string basics].)
    
    Alternatively you can pass `col_names` a character vector which will be
    used as the column names:
    
    
    ```r
    read_csv("1,2,3\n4,5,6", col_names = c("x", "y", "z"))
    ```
    
    ```
    ## # A tibble: 2 x 3
    ##       x     y     z
    ##   <int> <int> <int>
    ## 1     1     2     3
    ## 2     4     5     6
    ```

Another option that commonly needs tweaking is `na`: this specifies the value (or values) that are used to represent missing values in your file:


```r
read_csv("a,b,c\n1,2,.", na = ".")
```

```
## # A tibble: 1 x 3
##       a     b     c
##   <int> <int> <chr>
## 1     1     2  <NA>
```

This is all you need to know to read ~75% of CSV files that you'll encounter in practice. You can also easily adapt what you've learned to read tab separated files with `read_tsv()` and fixed width files with `read_fwf()`. To read in more challenging files, you'll need to learn more about how readr parses each column, turning them into R vectors.

## Exercise

[Link to the README file for the data](https://github.com/cities/datascience2017/blob/master/data/README.md)

1. What is the difference between a data.frame and tibble? How do you convert between them?
1. Import the bike counts data for [Hawthorne](https://github.com/cities/datascience2017/raw/master/data/Hawthorne%20Bridge%20daily%20bike%20counts%202012-2016%20082117.xlsx) and [Tilikum](https://github.com/cities/datascience2017/raw/master/data/Tilikum%20Crossing%20daily%20bike%20counts%202015-16%20082117.xlsx) in Microsoft Excel format;
1. Import the [Portland weather data in csv format](https://github.com/cities/datascience2017/raw/master/data/NCDC-CDO-PortlandOR.csv);
1. [Challenge] Import the [Portland weather data in fixed width format](https://github.com/cities/datascience2017/raw/master/data/NCDC-CDO-USC00356750.txt);
1. For those already familiar with R, create a R script that loads, cleans, and visualizes the bike counts data as well as temperature and precipitation data (using data from Weather Station `USC00356750`); <p>
for those not yet familiar with R, think about how you would go about doing these tasks with the software you are most comfortable with.

## Learning More

* [R Data Import Tutorial](https://www.datacamp.com/community/tutorials/r-data-import-tutorial) by Data Camp
* [Importing Data](http://uc-r.github.io/import) and [Exporting Data](http://uc-r.github.io/exporting) by R Programming @ UC.
* [Data Import & Export in R](https://science.nature.nps.gov/im/datamgmt/statistics/r/fundamentals/index.cfm) by National Park Services
* [Scrape web data with APIs](http://stat545.com/cm111_webdata.html)
