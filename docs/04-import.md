

# Import

## Readings

1. [R4DS] Chapter 10, 11

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

First, install and load tidyverse packages if you haven't yet:


```r
install.packages("tidyverse")
library(tidyverse)
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
## # A tibble: 1,000 × 5
##                      a          b     c         d     e
##                 <dttm>     <date> <int>     <dbl> <chr>
## 1  2017-03-17 03:00:32 2017-04-02     1 0.6110699     y
## 2  2017-03-16 18:11:36 2017-04-10     2 0.8111735     v
## 3  2017-03-17 12:26:32 2017-03-22     3 0.7096738     t
## 4  2017-03-16 20:36:22 2017-03-28     4 0.1235041     i
## 5  2017-03-16 14:45:45 2017-04-07     5 0.0423646     d
## 6  2017-03-17 07:57:19 2017-03-24     6 0.1532908     w
## 7  2017-03-17 10:27:05 2017-04-14     7 0.4006629     a
## 8  2017-03-17 12:22:58 2017-04-09     8 0.2333310     i
## 9  2017-03-16 22:42:19 2017-04-03     9 0.2849094     l
## 10 2017-03-16 22:00:23 2017-04-06    10 0.9128008     s
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
## [1] 0.2193120 0.9044310 0.1883894 0.8977420 0.8454857
```

```r
df[["x"]]
```

```
## [1] 0.2193120 0.9044310 0.1883894 0.8977420 0.8454857
```

```r
# Extract by column position
df[[1]]
```

```
## [1] 0.2193120 0.9044310 0.1883894 0.8977420 0.8454857
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
## # A tibble: 1,192 × 6
##     earn   height    sex    ed   age     race
##    <dbl>    <dbl>  <chr> <int> <int>    <chr>
## 1  50000 74.42444   male    16    45    white
## 2  60000 65.53754 female    16    58    white
## 3  30000 63.62920 female    16    29    white
## 4  50000 63.10856 female    16    91    other
## 5  51000 63.40248 female    17    39    white
## 6   9000 64.39951 female    15    26    white
## 7  29000 61.65633 female    12    49    white
## 8  32000 72.69854   male    17    46    white
## 9   2000 72.03947   male    15    21 hispanic
## 10 27000 72.23493   male    12    26    white
## # ... with 1,182 more rows
```

When you run `read_csv()` it prints out a column specification that gives the name and type of each column. That's an important part of readr, which we'll come back to in [parsing a file].

You can also supply an inline csv file. This is useful for experimenting with readr and for creating reproducible examples to share with others:


```r
read_csv("a,b,c
1,2,3
4,5,6")
```

```
## # A tibble: 2 × 3
##       a     b     c
##   <int> <int> <int>
## 1     1     2     3
## 2     4     5     6
```

In both cases `read_csv()` uses the first line of the data for the column names, which is a very common convention. There are two cases where you might want to tweak this behaviour:

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
    ## # A tibble: 1 × 3
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
    ## # A tibble: 1 × 3
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
    ## # A tibble: 2 × 3
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
    ## # A tibble: 2 × 3
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
## # A tibble: 1 × 3
##       a     b     c
##   <int> <int> <chr>
## 1     1     2  <NA>
```

This is all you need to know to read ~75% of CSV files that you'll encounter in practice. You can also easily adapt what you've learned to read tab separated files with `read_tsv()` and fixed width files with `read_fwf()`. To read in more challenging files, you'll need to learn more about how readr parses each column, turning them into R vectors.

### Compared to base R

If you've used R before, you might wonder why we're not using `read.csv()`. There are a few good reasons to favour readr functions over the base equivalents:

* They are typically much faster (~10x) than their base equivalents.
  Long running jobs have a progress bar, so you can see what's happening. 
  If you're looking for raw speed, try `data.table::fread()`. It doesn't fit 
  quite so well into the tidyverse, but it can be quite a bit faster.

* They produce tibbles, they don't convert character vectors to factors,
  use row names, or munge the column names. These are common sources of
  frustration with the base R functions.

* They are more reproducible. Base R functions inherit some behaviour from
  your operating system and environment variables, so import code that works 
  on your computer might not work on someone else's.

* If you're interested in learning more on under the hood magics of how `readr` 
  parses file, [this section](http://r4ds.had.co.nz/data-import.html#parsing-a-vector) 
  in R for Data Science provides an overview.
  
### Exercises

1.  What function would you use to read a file where fields were separated with  
    "|"?
    
1.  Apart from `file`, `skip`, and `comment`, what other arguments do
    `read_csv()` and `read_tsv()` have in common?
    
1.  What are the most important arguments to `read_fwf()`?
   
1.  Sometimes strings in a CSV file contain commas. To prevent them from
    causing problems they need to be surrounded by a quoting character, like
    `"` or `'`. By convention, `read_csv()` assumes that the quoting
    character will be `"`, and if you want to change it you'll need to
    use `read_delim()` instead. What arguments do you need to specify
    to read the following text into a data frame?
    
    
    ```r
    "x,y\n1,'a,b'"
    ```
    
1.  Identify what is wrong with each of the following inline CSV files. 
    What happens when you run the code?
    
    
    ```r
    read_csv("a,b\n1,2,3\n4,5,6")
    read_csv("a,b,c\n1,2\n1,2,3,4")
    read_csv("a,b\n\"1")
    read_csv("a,b\n1,2\na,b")
    read_csv("a;b\n1;3")
    ```


## Writing to a file

readr also comes with two useful functions for writing data back to disk: `write_csv()` and `write_tsv()`. Both functions increase the chances of the output file being read back in correctly by:

* Always encoding strings in UTF-8.
  
* Saving dates and date-times in ISO8601 format so they are easily
  parsed elsewhere.

If you want to export a csv file to Excel, use `write_excel_csv()` --- this writes a special character (a "byte order mark") at the start of the file which tells Excel that you're using the UTF-8 encoding.

The most important arguments are `x` (the data frame to save), and `path` (the location to save it). You can also specify how missing values are written with `na`, and if you want to `append` to an existing file.


```r
write_csv(heights, "results/heights.csv")
```

Note that the type information is lost when you save to csv:


```r
heights
```

```
## # A tibble: 1,192 × 6
##     earn   height    sex    ed   age     race
##    <dbl>    <dbl>  <chr> <int> <int>    <chr>
## 1  50000 74.42444   male    16    45    white
## 2  60000 65.53754 female    16    58    white
## 3  30000 63.62920 female    16    29    white
## 4  50000 63.10856 female    16    91    other
## 5  51000 63.40248 female    17    39    white
## 6   9000 64.39951 female    15    26    white
## 7  29000 61.65633 female    12    49    white
## 8  32000 72.69854   male    17    46    white
## 9   2000 72.03947   male    15    21 hispanic
## 10 27000 72.23493   male    12    26    white
## # ... with 1,182 more rows
```

```r
write_csv(heights, "results/heights-2.csv")
read_csv("results/heights-2.csv")
```

```
## # A tibble: 1,192 × 6
##     earn   height    sex    ed   age     race
##    <dbl>    <dbl>  <chr> <int> <int>    <chr>
## 1  50000 74.42444   male    16    45    white
## 2  60000 65.53754 female    16    58    white
## 3  30000 63.62920 female    16    29    white
## 4  50000 63.10856 female    16    91    other
## 5  51000 63.40248 female    17    39    white
## 6   9000 64.39951 female    15    26    white
## 7  29000 61.65633 female    12    49    white
## 8  32000 72.69854   male    17    46    white
## 9   2000 72.03947   male    15    21 hispanic
## 10 27000 72.23493   male    12    26    white
## # ... with 1,182 more rows
```

This makes CSVs a little unreliable for caching interim results---you need to recreate the column specification every time you load in. There are two alternatives:

1.  `write_rds()` and `read_rds()` are uniform wrappers around the base 
    functions `readRDS()` and `saveRDS()`. These store data in R's custom 
    binary format called RDS:
    
    
    ```r
    write_rds(heights, "results/heights.rds")
    read_rds("results/heights.rds")
    ```
    
    ```
    ## # A tibble: 1,192 × 6
    ##     earn   height    sex    ed   age     race
    ##    <dbl>    <dbl>  <chr> <int> <int>    <chr>
    ## 1  50000 74.42444   male    16    45    white
    ## 2  60000 65.53754 female    16    58    white
    ## 3  30000 63.62920 female    16    29    white
    ## 4  50000 63.10856 female    16    91    other
    ## 5  51000 63.40248 female    17    39    white
    ## 6   9000 64.39951 female    15    26    white
    ## 7  29000 61.65633 female    12    49    white
    ## 8  32000 72.69854   male    17    46    white
    ## 9   2000 72.03947   male    15    21 hispanic
    ## 10 27000 72.23493   male    12    26    white
    ## # ... with 1,182 more rows
    ```
  
1.  The feather package implements a fast binary file format that can
    be shared across programming languages:
    
    
    ```r
    install.packages("feather")
    library(feather)
    write_feather(heights, "results/heights.feather")
    read_feather("results/heights.feather")
    ```

Feather tends to be faster than RDS and is usable outside of R. RDS supports list-columns (which we will come back to in [Model]); feather currently does not.



## Learn More

* [R Data Import Tutorial](https://www.datacamp.com/community/tutorials/r-data-import-tutorial) by Data Camp
* [Importing Data](http://uc-r.github.io/import) and [Exporting Data](http://uc-r.github.io/exporting) by R Programming @ UC.
* [Data Import & Export in R](https://science.nature.nps.gov/im/datamgmt/statistics/r/fundamentals/index.cfm) by National Park Services
* [Scrape web data with APIs](http://stat545.com/cm111_webdata.html)
