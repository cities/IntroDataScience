# Data manipulation with dplyr

## Readings

1. [R4DS Data Transformation](http://r4ds.had.co.nz/transform.html)
1. [R4DS Relational data](http://r4ds.had.co.nz/relational-data.html)

## Overview

dplyr is a grammar of data manipulation, providing a consistent set of verbs that help you solve the most common data manipulation challenges:

- `mutate()` adds new variables that are functions of existing variables
- `select()` picks variables based on their names.
- `filter()` picks cases based on their values.
- `summarise()` reduces multiple values down to a single summary.
- `arrange()` changes the ordering of the rows.

These all combine naturally with `group_by()` which allows you to perform any operation "by group". You can learn more about them in `vignette("dplyr")`. As well as these single-table verbs, dplyr also provides a variety of two-table verbs, which you can learn about in `vignette("two-table")`.

dplyr is designed to abstract over how the data is stored. That means as well as working with local data frames, you can also work with remote database tables, using exactly the same R code. Install the dbplyr package then read `vignette("databases", package = "dbplyr")`.

## Lesson

Lesson below is adapted from [UBC's Stat 545 course materials by Professor Jenny Bryon](http://stat545.com/block009_dplyr-intro.html).

### Prerequisites

Load `dplyr` (or `tidyverse`, which will load `dplyr`) and `gapminder` (install it if not yet installed):


```r
library(gapminder)
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

### Use `filter()` to subset data row-wise.

`filter()` takes logical expressions and returns the rows for which all are `TRUE`.


```r
filter(gapminder, lifeExp < 29)
```

```
## # A tibble: 2 x 6
##       country continent  year lifeExp     pop gdpPercap
##        <fctr>    <fctr> <int>   <dbl>   <int>     <dbl>
## 1 Afghanistan      Asia  1952  28.801 8425333  779.4453
## 2      Rwanda    Africa  1992  23.599 7290203  737.0686
```

```r
filter(gapminder, country == "Rwanda", year > 1979)
```

```
## # A tibble: 6 x 6
##   country continent  year lifeExp     pop gdpPercap
##    <fctr>    <fctr> <int>   <dbl>   <int>     <dbl>
## 1  Rwanda    Africa  1982  46.218 5507565  881.5706
## 2  Rwanda    Africa  1987  44.020 6349365  847.9912
## 3  Rwanda    Africa  1992  23.599 7290203  737.0686
## 4  Rwanda    Africa  1997  36.087 7212583  589.9445
## 5  Rwanda    Africa  2002  43.413 7852401  785.6538
## 6  Rwanda    Africa  2007  46.242 8860588  863.0885
```

```r
filter(gapminder, country %in% c("Rwanda", "Afghanistan"))
```

```
## # A tibble: 24 x 6
##        country continent  year lifeExp      pop gdpPercap
##         <fctr>    <fctr> <int>   <dbl>    <int>     <dbl>
##  1 Afghanistan      Asia  1952  28.801  8425333  779.4453
##  2 Afghanistan      Asia  1957  30.332  9240934  820.8530
##  3 Afghanistan      Asia  1962  31.997 10267083  853.1007
##  4 Afghanistan      Asia  1967  34.020 11537966  836.1971
##  5 Afghanistan      Asia  1972  36.088 13079460  739.9811
##  6 Afghanistan      Asia  1977  38.438 14880372  786.1134
##  7 Afghanistan      Asia  1982  39.854 12881816  978.0114
##  8 Afghanistan      Asia  1987  40.822 13867957  852.3959
##  9 Afghanistan      Asia  1992  41.674 16317921  649.3414
## 10 Afghanistan      Asia  1997  41.763 22227415  635.3414
## # ... with 14 more rows
```

Under no circumstances should you subset your data the way I did at first:


```r
excerpt <- gapminder[241:252, ]
```

Why is this a terrible idea?

  * It is not self-documenting. What is so special about rows 241 through 252?
  * It is fragile. This line of code will produce different results if someone changes the row order of `gapminder`, e.g. sorts the data earlier in the script.
  

```r
filter(gapminder, country == "Canada")
```

This call explains itself and is fairly robust.

### Use `select()` to subset the data on variables or columns.

Use `select()` to subset the data on variables or columns. Here's a conventional call:


```r
select(gapminder, year, lifeExp)
```

```
## # A tibble: 1,704 x 2
##     year lifeExp
##    <int>   <dbl>
##  1  1952  28.801
##  2  1957  30.332
##  3  1962  31.997
##  4  1967  34.020
##  5  1972  36.088
##  6  1977  38.438
##  7  1982  39.854
##  8  1987  40.822
##  9  1992  41.674
## 10  1997  41.763
## # ... with 1,694 more rows
```

Think: "Take `gapminder`, then select the variables year and lifeExp, then show the first 4 rows."

### Revel in the convenience

Here's the data for Cambodia, taking certain variables:


```r
gapminder %>%
  filter(country == "Cambodia") %>%
  select(year, lifeExp)
```

```
## # A tibble: 12 x 2
##     year lifeExp
##    <int>   <dbl>
##  1  1952  39.417
##  2  1957  41.366
##  3  1962  43.415
##  4  1967  45.415
##  5  1972  40.317
##  6  1977  31.220
##  7  1982  50.957
##  8  1987  53.914
##  9  1992  55.803
## 10  1997  56.534
## 11  2002  56.752
## 12  2007  59.723
```

### Pure, predictable, pipeable

We've barely scratched the surface of `dplyr` but I want to point out key principles you may start to appreciate. If you're new to R or "programming with data", feel free skip this section and [move on](block010_dplyr-end-single-table.html).

`dplyr`'s verbs, such as `filter()` and `select()`, are what's called [pure functions](http://en.wikipedia.org/wiki/Pure_function). To quote from Wickham's [Advanced R Programming book](http://adv-r.had.co.nz/Functions.html):

> The functions that are the easiest to understand and reason about are pure functions: functions that always map the same input to the same output and have no other impact on the workspace. In other words, pure functions have no side effects: they don’t affect the state of the world in any way apart from the value they return.

In fact, these verbs are a special case of pure functions: they take the same flavor of object as input and output. Namely, a data frame or one of the other data receptacles `dplyr` supports.

And finally, the data is __always__ the very first argument of the verb functions.

This set of deliberate design choices, together with the new pipe operator, produces a highly effective, low friction [domain-specific language](http://adv-r.had.co.nz/dsl.html) for data analysis.

### Use `mutate()` to add new variables

Imagine we wanted to recover each country's GDP. After all, the Gapminder data has a variable for population and GDP per capita. Let's multiply them together.

`mutate()` is a function that defines and inserts new variables into a tibble. You can refer to existing variables by name.


```r
gapminder %>%
  mutate(gdp = pop * gdpPercap)
```

```
## # A tibble: 1,704 x 7
##        country continent  year lifeExp      pop gdpPercap         gdp
##         <fctr>    <fctr> <int>   <dbl>    <int>     <dbl>       <dbl>
##  1 Afghanistan      Asia  1952  28.801  8425333  779.4453  6567086330
##  2 Afghanistan      Asia  1957  30.332  9240934  820.8530  7585448670
##  3 Afghanistan      Asia  1962  31.997 10267083  853.1007  8758855797
##  4 Afghanistan      Asia  1967  34.020 11537966  836.1971  9648014150
##  5 Afghanistan      Asia  1972  36.088 13079460  739.9811  9678553274
##  6 Afghanistan      Asia  1977  38.438 14880372  786.1134 11697659231
##  7 Afghanistan      Asia  1982  39.854 12881816  978.0114 12598563401
##  8 Afghanistan      Asia  1987  40.822 13867957  852.3959 11820990309
##  9 Afghanistan      Asia  1992  41.674 16317921  649.3414 10595901589
## 10 Afghanistan      Asia  1997  41.763 22227415  635.3414 14121995875
## # ... with 1,694 more rows
```

Hmmmm ... those GDP numbers are almost uselessly large and abstract. Consider the [advice of Randall Munroe of xkcd](http://fivethirtyeight.com/datalab/xkcd-randall-munroe-qanda-what-if/):

> One thing that bothers me is large numbers presented without context... 'If I added a zero to this number, would the sentence containing it mean something different to me?' If the answer is 'no,' maybe the number has no business being in the sentence in the first place."

Maybe it would be more meaningful to consumers of my tables and figures to stick with GDP per capita. But what if I reported GDP per capita, relative to some a benchmark country. 

I need to create a new variable that is `gdpPercap` divided by Canadian `gdpPercap`, taking care that I always divide two numbers that pertain to the same year.

How I achieve:

  * Filter down to the rows for Canada
  * Create a new temporary variable in `gapminder`:
    - Extract the `gdpPercap` variable from the Canadian data.
    - Replicate it once per country in the dataset, so it has the right length.
  * Divide raw `gdpPercap` by this Canadian figure.
  * Discard the temporary variable of replicated Canadian `gdpPercap`.


```r
ctib <- gapminder %>%
  filter(country == "Canada") %>% 
  select(year, BasegdpPercap=gdpPercap)
ctib
```

```
## # A tibble: 12 x 2
##     year BasegdpPercap
##    <int>         <dbl>
##  1  1952      11367.16
##  2  1957      12489.95
##  3  1962      13462.49
##  4  1967      16076.59
##  5  1972      18970.57
##  6  1977      22090.88
##  7  1982      22898.79
##  8  1987      26626.52
##  9  1992      26342.88
## 10  1997      28954.93
## 11  2002      33328.97
## 12  2007      36319.24
```

```r
my_gap <- gapminder %>%
  inner_join(ctib, by="year") %>% 
  mutate(gdpPercapRel = gdpPercap / BasegdpPercap,
         BasegdpPercap = NULL)
my_gap
```

```
## # A tibble: 1,704 x 7
##        country continent  year lifeExp      pop gdpPercap gdpPercapRel
##         <fctr>    <fctr> <int>   <dbl>    <int>     <dbl>        <dbl>
##  1 Afghanistan      Asia  1952  28.801  8425333  779.4453   0.06856992
##  2 Afghanistan      Asia  1957  30.332  9240934  820.8530   0.06572108
##  3 Afghanistan      Asia  1962  31.997 10267083  853.1007   0.06336874
##  4 Afghanistan      Asia  1967  34.020 11537966  836.1971   0.05201335
##  5 Afghanistan      Asia  1972  36.088 13079460  739.9811   0.03900679
##  6 Afghanistan      Asia  1977  38.438 14880372  786.1134   0.03558542
##  7 Afghanistan      Asia  1982  39.854 12881816  978.0114   0.04271018
##  8 Afghanistan      Asia  1987  40.822 13867957  852.3959   0.03201305
##  9 Afghanistan      Asia  1992  41.674 16317921  649.3414   0.02464959
## 10 Afghanistan      Asia  1997  41.763 22227415  635.3414   0.02194243
## # ... with 1,694 more rows
```

Note that, `mutate()` builds new variables sequentially so you can reference earlier ones (like `tmp`) when defining later ones (like `gdpPercapRel`). Also, you can get rid of a variable by setting it to `NULL`.

How could we sanity check that this worked? The Canadian values for `gdpPercapRel` better all be 1!


```r
my_gap %>% 
  filter(country == "Canada") %>% 
  select(country, year, gdpPercapRel)
```

```
## # A tibble: 12 x 3
##    country  year gdpPercapRel
##     <fctr> <int>        <dbl>
##  1  Canada  1952            1
##  2  Canada  1957            1
##  3  Canada  1962            1
##  4  Canada  1967            1
##  5  Canada  1972            1
##  6  Canada  1977            1
##  7  Canada  1982            1
##  8  Canada  1987            1
##  9  Canada  1992            1
## 10  Canada  1997            1
## 11  Canada  2002            1
## 12  Canada  2007            1
```

I perceive Canada to be a "high GDP" country, so I predict that the distribution of `gdpPercapRel` is located below 1, possibly even well below. Check your intuition!


```r
summary(my_gap$gdpPercapRel)
```

```
##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
## 0.007236 0.061648 0.171521 0.326659 0.446564 9.534690
```

The relative GDP per capita numbers are, in general, well below 1. We see that most of the countries covered by this dataset have substantially lower GDP per capita, relative to Canada, across the entire time period.

Remember: Trust No One. Including (especially?) yourself. Always try to find a way to check that you've done what meant to. Prepare to be horrified.

### Use `arrange()` to row-order data in a principled way

`arrange()` reorders the rows in a data frame. Imagine you wanted this data ordered by year then country, as opposed to by country then year.


```r
my_gap %>%
  arrange(year, country)
```

```
## # A tibble: 1,704 x 7
##        country continent  year lifeExp      pop  gdpPercap gdpPercapRel
##         <fctr>    <fctr> <int>   <dbl>    <int>      <dbl>        <dbl>
##  1 Afghanistan      Asia  1952  28.801  8425333   779.4453   0.06856992
##  2     Albania    Europe  1952  55.230  1282697  1601.0561   0.14084925
##  3     Algeria    Africa  1952  43.077  9279525  2449.0082   0.21544589
##  4      Angola    Africa  1952  30.015  4232095  3520.6103   0.30971764
##  5   Argentina  Americas  1952  62.485 17876956  5911.3151   0.52003442
##  6   Australia   Oceania  1952  69.120  8691212 10039.5956   0.88321046
##  7     Austria    Europe  1952  66.800  6927772  6137.0765   0.53989527
##  8     Bahrain      Asia  1952  50.939   120447  9867.0848   0.86803421
##  9  Bangladesh      Asia  1952  37.484 46886859   684.2442   0.06019482
## 10     Belgium    Europe  1952  68.000  8730405  8343.1051   0.73396559
## # ... with 1,694 more rows
```

Or maybe you want just the data from 2007, sorted on life expectancy?


```r
my_gap %>%
  filter(year == 2007) %>%
  arrange(lifeExp)
```

```
## # A tibble: 142 x 7
##                     country continent  year lifeExp      pop gdpPercap
##                      <fctr>    <fctr> <int>   <dbl>    <int>     <dbl>
##  1                Swaziland    Africa  2007  39.613  1133066 4513.4806
##  2               Mozambique    Africa  2007  42.082 19951656  823.6856
##  3                   Zambia    Africa  2007  42.384 11746035 1271.2116
##  4             Sierra Leone    Africa  2007  42.568  6144562  862.5408
##  5                  Lesotho    Africa  2007  42.592  2012649 1569.3314
##  6                   Angola    Africa  2007  42.731 12420476 4797.2313
##  7                 Zimbabwe    Africa  2007  43.487 12311143  469.7093
##  8              Afghanistan      Asia  2007  43.828 31889923  974.5803
##  9 Central African Republic    Africa  2007  44.741  4369038  706.0165
## 10                  Liberia    Africa  2007  45.678  3193942  414.5073
## # ... with 132 more rows, and 1 more variables: gdpPercapRel <dbl>
```

Oh, you'd like to sort on life expectancy in **desc**ending order? Then use `desc()`.


```r
my_gap %>%
  filter(year == 2007) %>%
  arrange(desc(lifeExp))
```

```
## # A tibble: 142 x 7
##             country continent  year lifeExp       pop gdpPercap
##              <fctr>    <fctr> <int>   <dbl>     <int>     <dbl>
##  1            Japan      Asia  2007  82.603 127467972  31656.07
##  2 Hong Kong, China      Asia  2007  82.208   6980412  39724.98
##  3          Iceland    Europe  2007  81.757    301931  36180.79
##  4      Switzerland    Europe  2007  81.701   7554661  37506.42
##  5        Australia   Oceania  2007  81.235  20434176  34435.37
##  6            Spain    Europe  2007  80.941  40448191  28821.06
##  7           Sweden    Europe  2007  80.884   9031088  33859.75
##  8           Israel      Asia  2007  80.745   6426679  25523.28
##  9           France    Europe  2007  80.657  61083916  30470.02
## 10           Canada  Americas  2007  80.653  33390141  36319.24
## # ... with 132 more rows, and 1 more variables: gdpPercapRel <dbl>
```

I advise that your analyses NEVER rely on rows or variables being in a specific order. But it's still true that human beings write the code and the interactive development process can be much nicer if you reorder the rows of your data as you go along. Also, once you are preparing tables for human eyeballs, it is imperative that you step up and take control of row order.

### Use `rename()` to rename variables

The Gapminder use [`camelCase`](http://en.wikipedia.org/wiki/CamelCase) for variable naming, an alternative convention is [`snake_case`](http://en.wikipedia.org/wiki/Snake_case). Let's rename some variables to use snake case!


```r
my_gap %>%
  rename(life_exp = lifeExp,
         gdp_percap = gdpPercap,
         gdp_percap_rel = gdpPercapRel)
```

```
## # A tibble: 1,704 x 7
##        country continent  year life_exp      pop gdp_percap gdp_percap_rel
##         <fctr>    <fctr> <int>    <dbl>    <int>      <dbl>          <dbl>
##  1 Afghanistan      Asia  1952   28.801  8425333   779.4453     0.06856992
##  2 Afghanistan      Asia  1957   30.332  9240934   820.8530     0.06572108
##  3 Afghanistan      Asia  1962   31.997 10267083   853.1007     0.06336874
##  4 Afghanistan      Asia  1967   34.020 11537966   836.1971     0.05201335
##  5 Afghanistan      Asia  1972   36.088 13079460   739.9811     0.03900679
##  6 Afghanistan      Asia  1977   38.438 14880372   786.1134     0.03558542
##  7 Afghanistan      Asia  1982   39.854 12881816   978.0114     0.04271018
##  8 Afghanistan      Asia  1987   40.822 13867957   852.3959     0.03201305
##  9 Afghanistan      Asia  1992   41.674 16317921   649.3414     0.02464959
## 10 Afghanistan      Asia  1997   41.763 22227415   635.3414     0.02194243
## # ... with 1,694 more rows
```

I did NOT assign the post-rename object back to `my_gap` because that would make the chunks in this tutorial harder to copy/paste and run out of order. In real life, I would probably assign this back to `my_gap`, in a data preparation script, and proceed with the new variable names.

### `select()` can rename and reposition variables

You've seen simple use of `select()`. There are two tricks you might enjoy:

  1. `select()` can rename the variables you request to keep.
  1. `select()` can be used with `everything()` to hoist a variable up to the front of the tibble.
  

```r
my_gap %>%
  filter(country == "Burundi", year > 1996) %>% 
  select(yr = year, lifeExp, gdpPercap) %>% 
  select(gdpPercap, everything())
```

```
## # A tibble: 3 x 3
##   gdpPercap    yr lifeExp
##       <dbl> <int>   <dbl>
## 1  463.1151  1997  45.326
## 2  446.4035  2002  47.360
## 3  430.0707  2007  49.580
```

`everything()` is one of several helpers for variable selection. Read its help to see the rest.

### `group_by()` is a mighty weapon

I have found ~~friends and family~~ collaborators love to ask seemingly innocuous questions like, "which country experienced the sharpest 5-year drop in life expectancy?". In fact, that is a totally natural question to ask. But if you are using a language that doesn't know about data, it's an incredibly annoying question to answer.

dplyr offers powerful tools to solve this class of problem.

  * `group_by()` adds extra structure to your dataset -- grouping information -- which lays the groundwork for computations within the groups.
  * `summarize()` takes a dataset with $n$ observations, computes requested summaries, and returns a dataset with 1 observation.
  * Window functions take a dataset with $n$ observations and return a dataset with $n$ observations.
  * `mutate()` and `summarize()` will honor groups.
  * You can also do very general computations on your groups with `do()`, though elsewhere in this course, I advocate for other approaches that I find more intuitive, using the `purrr` package.

Combined with the verbs you already know, these new tools allow you to solve an extremely diverse set of problems with relative ease.

#### Counting things up

Let's start with simple counting.  How many observations do we have per continent?


```r
my_gap %>%
  group_by(continent) %>%
  summarize(n = n())
```

```
## # A tibble: 5 x 2
##   continent     n
##      <fctr> <int>
## 1    Africa   624
## 2  Americas   300
## 3      Asia   396
## 4    Europe   360
## 5   Oceania    24
```

Let us pause here to think about the tidyverse. You could get these same frequencies using `table()` from base R.


```r
table(gapminder$continent)
```

```
## 
##   Africa Americas     Asia   Europe  Oceania 
##      624      300      396      360       24
```

```r
str(table(gapminder$continent))
```

```
##  'table' int [1:5(1d)] 624 300 396 360 24
##  - attr(*, "dimnames")=List of 1
##   ..$ : chr [1:5] "Africa" "Americas" "Asia" "Europe" ...
```

But the object of class `table` that is returned makes downstream computation a bit fiddlier than you'd like. For example, it's too bad the continent levels come back only as *names* and not as a proper factor, with the original set of levels. This is an example of how the tidyverse smooths transitions where you want the output of step i to become the input of step i + 1.

The `tally()` function is a convenience function that knows to count rows. It honors groups.


```r
my_gap %>%
  group_by(continent) %>%
  tally()
```

```
## # A tibble: 5 x 2
##   continent     n
##      <fctr> <int>
## 1    Africa   624
## 2  Americas   300
## 3      Asia   396
## 4    Europe   360
## 5   Oceania    24
```

The `count()` function is an even more convenient function that does both grouping and counting.


```r
my_gap %>% 
  count(continent)
```

```
## # A tibble: 5 x 2
##   continent     n
##      <fctr> <int>
## 1    Africa   624
## 2  Americas   300
## 3      Asia   396
## 4    Europe   360
## 5   Oceania    24
```

What if we wanted to add the number of unique countries for each continent? You can compute multiple summaries inside `summarize()`. Use the `n_distinct()` function to count the number of distinct countries within each continent.


```r
my_gap %>%
  group_by(continent) %>%
  summarize(n = n(),
            n_countries = n_distinct(country))
```

```
## # A tibble: 5 x 3
##   continent     n n_countries
##      <fctr> <int>       <int>
## 1    Africa   624          52
## 2  Americas   300          25
## 3      Asia   396          33
## 4    Europe   360          30
## 5   Oceania    24           2
```

#### General summarization

The functions you'll apply within `summarize()` include classical statistical summaries, like  `mean()`, `median()`, `var()`, `sd()`, `mad()`, `IQR()`, `min()`, and `max()`. Remember they are functions that take $n$ inputs and distill them down into 1 output.

Although this may be statistically ill-advised, let's compute the average life expectancy by continent.


```r
my_gap %>%
  group_by(continent) %>%
  summarize(avg_lifeExp = mean(lifeExp))
```

```
## # A tibble: 5 x 2
##   continent avg_lifeExp
##      <fctr>       <dbl>
## 1    Africa    48.86533
## 2  Americas    64.65874
## 3      Asia    60.06490
## 4    Europe    71.90369
## 5   Oceania    74.32621
```

`summarize_each()` applies the same summary function(s) to multiple variables. Let's compute average and median life expectancy and GDP per capita by continent by year ... but only for 1952 and 2007.


```r
my_gap %>%
  filter(year %in% c(1952, 2007)) %>%
  group_by(continent, year) %>%
  summarise_each(funs(mean, median), lifeExp, gdpPercap)
```

```
## `summarise_each()` is deprecated.
## Use `summarise_all()`, `summarise_at()` or `summarise_if()` instead.
## To map `funs` over a selection of variables, use `summarise_at()`
```

```
## # A tibble: 10 x 6
## # Groups:   continent [?]
##    continent  year lifeExp_mean gdpPercap_mean lifeExp_median
##       <fctr> <int>        <dbl>          <dbl>          <dbl>
##  1    Africa  1952     39.13550       1252.572        38.8330
##  2    Africa  2007     54.80604       3089.033        52.9265
##  3  Americas  1952     53.27984       4079.063        54.7450
##  4  Americas  2007     73.60812      11003.032        72.8990
##  5      Asia  1952     46.31439       5195.484        44.8690
##  6      Asia  2007     70.72848      12473.027        72.3960
##  7    Europe  1952     64.40850       5661.057        65.9000
##  8    Europe  2007     77.64860      25054.482        78.6085
##  9   Oceania  1952     69.25500      10298.086        69.2550
## 10   Oceania  2007     80.71950      29810.188        80.7195
## # ... with 1 more variables: gdpPercap_median <dbl>
```

Let's focus just on Asia. What are the minimum and maximum life expectancies seen by year?


```r
my_gap %>%
  filter(continent == "Asia") %>%
  group_by(year) %>%
  summarize(min_lifeExp = min(lifeExp), max_lifeExp = max(lifeExp))
```

```
## # A tibble: 12 x 3
##     year min_lifeExp max_lifeExp
##    <int>       <dbl>       <dbl>
##  1  1952      28.801      65.390
##  2  1957      30.332      67.840
##  3  1962      31.997      69.390
##  4  1967      34.020      71.430
##  5  1972      36.088      73.420
##  6  1977      31.220      75.380
##  7  1982      39.854      77.110
##  8  1987      40.822      78.670
##  9  1992      41.674      79.360
## 10  1997      41.763      80.690
## 11  2002      42.129      82.000
## 12  2007      43.828      82.603
```

Of course it would be much more interesting to see *which* country contributed these extreme observations. Is the minimum (maximum) always coming from the same country? We tackle that with window functions shortly.

### Grouped mutate

Sometimes you don't want to collapse the $n$ rows for each group into one row. You want to keep your groups, but compute within them.

#### Computing with group-wise summaries

Let's make a new variable that is the years of life expectancy gained (lost) relative to 1952, for each individual country. We group by country and use `mutate()` to make a new variable. The `first()` function extracts the first value from a vector. Notice that `first()` is operating on the vector of life expectancies *within each country group*.


```r
my_gap %>% 
  group_by(country) %>% 
  select(country, year, lifeExp) %>% 
  mutate(lifeExp_gain = lifeExp - first(lifeExp)) %>% 
  filter(year < 1963)
```

```
## # A tibble: 426 x 4
## # Groups:   country [142]
##        country  year lifeExp lifeExp_gain
##         <fctr> <int>   <dbl>        <dbl>
##  1 Afghanistan  1952  28.801        0.000
##  2 Afghanistan  1957  30.332        1.531
##  3 Afghanistan  1962  31.997        3.196
##  4     Albania  1952  55.230        0.000
##  5     Albania  1957  59.280        4.050
##  6     Albania  1962  64.820        9.590
##  7     Algeria  1952  43.077        0.000
##  8     Algeria  1957  45.685        2.608
##  9     Algeria  1962  48.303        5.226
## 10      Angola  1952  30.015        0.000
## # ... with 416 more rows
```

Within country, we take the difference between life expectancy in year $i$ and life expectancy in 1952. Therefore we always see zeroes for 1952 and, for most countries, a sequence of positive and increasing numbers.

#### Window functions

Window functions take $n$ inputs and give back $n$ outputs. Furthermore, the output depends on all the values. So `rank()` is a window function but `log()` is not. Here we use window functions based on ranks and offsets.

Let's revisit the worst and best life expectancies in Asia over time, but retaining info about *which* country contributes these extreme values.


```r
my_gap %>%
  filter(continent == "Asia") %>%
  select(year, country, lifeExp) %>%
  group_by(year) %>%
  filter(min_rank(desc(lifeExp)) < 2 | min_rank(lifeExp) < 2) %>% 
  arrange(year) %>%
  print(n = Inf)
```

```
## # A tibble: 24 x 3
## # Groups:   year [12]
##     year     country lifeExp
##    <int>      <fctr>   <dbl>
##  1  1952 Afghanistan  28.801
##  2  1952      Israel  65.390
##  3  1957 Afghanistan  30.332
##  4  1957      Israel  67.840
##  5  1962 Afghanistan  31.997
##  6  1962      Israel  69.390
##  7  1967 Afghanistan  34.020
##  8  1967       Japan  71.430
##  9  1972 Afghanistan  36.088
## 10  1972       Japan  73.420
## 11  1977    Cambodia  31.220
## 12  1977       Japan  75.380
## 13  1982 Afghanistan  39.854
## 14  1982       Japan  77.110
## 15  1987 Afghanistan  40.822
## 16  1987       Japan  78.670
## 17  1992 Afghanistan  41.674
## 18  1992       Japan  79.360
## 19  1997 Afghanistan  41.763
## 20  1997       Japan  80.690
## 21  2002 Afghanistan  42.129
## 22  2002       Japan  82.000
## 23  2007 Afghanistan  43.828
## 24  2007       Japan  82.603
```

We see that (min = Afghanistan, max = Japan) is the most frequent result, but Cambodia and Israel pop up at least once each as the min or max, respectively. That table should make you impatient for our upcoming work on tidying and reshaping data! Wouldn't it be nice to have one row per year?

How did that actually work? First, I store and view a partial that leaves off the `filter()` statement. All of these operations should be familiar.


```r
asia <- my_gap %>%
  filter(continent == "Asia") %>%
  select(year, country, lifeExp) %>%
  group_by(year)
asia
```

```
## # A tibble: 396 x 3
## # Groups:   year [12]
##     year     country lifeExp
##    <int>      <fctr>   <dbl>
##  1  1952 Afghanistan  28.801
##  2  1957 Afghanistan  30.332
##  3  1962 Afghanistan  31.997
##  4  1967 Afghanistan  34.020
##  5  1972 Afghanistan  36.088
##  6  1977 Afghanistan  38.438
##  7  1982 Afghanistan  39.854
##  8  1987 Afghanistan  40.822
##  9  1992 Afghanistan  41.674
## 10  1997 Afghanistan  41.763
## # ... with 386 more rows
```

Now we apply a window function -- `min_rank()`. Since `asia` is grouped by year, `min_rank()` operates within mini-datasets, each for a specific year. Applied to the variable `lifeExp`, `min_rank()` returns the rank of each country's observed life expectancy. FYI, the `min` part just specifies how ties are broken. Here is an explicit peek at these within-year life expectancy ranks, in both the (default) ascending and descending order.

For concreteness, I use `mutate()` to actually create these variables, even though I dropped this in the solution above. Let's look at a bit of that.


```r
asia %>%
  mutate(le_rank = min_rank(lifeExp),
         le_desc_rank = min_rank(desc(lifeExp))) %>% 
  filter(country %in% c("Afghanistan", "Japan", "Thailand"), year > 1995)
```

```
## # A tibble: 9 x 5
## # Groups:   year [3]
##    year     country lifeExp le_rank le_desc_rank
##   <int>      <fctr>   <dbl>   <int>        <int>
## 1  1997 Afghanistan  41.763       1           33
## 2  2002 Afghanistan  42.129       1           33
## 3  2007 Afghanistan  43.828       1           33
## 4  1997       Japan  80.690      33            1
## 5  2002       Japan  82.000      33            1
## 6  2007       Japan  82.603      33            1
## 7  1997    Thailand  67.521      12           22
## 8  2002    Thailand  68.564      12           22
## 9  2007    Thailand  70.616      12           22
```

Afghanistan tends to present 1's in the `le_rank` variable, Japan tends to present 1's in the `le_desc_rank` variable and other countries, like Thailand, present less extreme ranks.

You can understand the original `filter()` statement now:


```r
filter(min_rank(desc(lifeExp)) < 2 | min_rank(lifeExp) < 2)
```

These two sets of ranks are formed on-the-fly, within year group, and `filter()` retains rows with rank less than 2, which means ... the row with rank = 1. Since we do for ascending and descending ranks, we get both the min and the max.

If we had wanted just the min OR the max, an alternative approach using `top_n()` would have worked.


```r
my_gap %>%
  filter(continent == "Asia") %>%
  select(year, country, lifeExp) %>%
  arrange(year) %>%
  group_by(year) %>%
  #top_n(1, wt = lifeExp)        ## gets the min
  top_n(1, wt = desc(lifeExp)) ## gets the max
```

```
## # A tibble: 12 x 3
## # Groups:   year [12]
##     year     country lifeExp
##    <int>      <fctr>   <dbl>
##  1  1952 Afghanistan  28.801
##  2  1957 Afghanistan  30.332
##  3  1962 Afghanistan  31.997
##  4  1967 Afghanistan  34.020
##  5  1972 Afghanistan  36.088
##  6  1977    Cambodia  31.220
##  7  1982 Afghanistan  39.854
##  8  1987 Afghanistan  40.822
##  9  1992 Afghanistan  41.674
## 10  1997 Afghanistan  41.763
## 11  2002 Afghanistan  42.129
## 12  2007 Afghanistan  43.828
```

### Grand Finale

So let's answer that "simple" question: which country experienced the sharpest 5-year drop in life expectancy? Recall that this excerpt of the Gapminder data only has data every five years, e.g. for 1952, 1957, etc. So this really means looking at life expectancy changes between adjacent timepoints.

At this point, that's just too easy, so let's do it by continent while we're at it.


```r
my_gap %>%
  select(country, year, continent, lifeExp) %>%
  group_by(continent, country) %>%
  ## within country, take (lifeExp in year i) - (lifeExp in year i - 1)
  ## positive means lifeExp went up, negative means it went down
  mutate(le_delta = lifeExp - lag(lifeExp)) %>% 
  ## within country, retain the worst lifeExp change = smallest or most negative
  summarize(worst_le_delta = min(le_delta, na.rm = TRUE)) %>% 
  ## within continent, retain the row with the lowest worst_le_delta
  top_n(-1, wt = worst_le_delta) %>% 
  arrange(worst_le_delta)
```

```
## # A tibble: 5 x 3
## # Groups:   continent [5]
##   continent     country worst_le_delta
##      <fctr>      <fctr>          <dbl>
## 1    Africa      Rwanda        -20.421
## 2      Asia    Cambodia         -9.097
## 3  Americas El Salvador         -1.511
## 4    Europe  Montenegro         -1.464
## 5   Oceania   Australia          0.170
```

Ponder that for a while. The subject matter and the code. Mostly you're seeing what genocide looks like in dry statistics on average life expectancy.

Break the code into pieces, starting at the top, and inspect the intermediate results. That's certainly how I was able to *write* such a thing. These commands do not [leap fully formed out of anyone's forehead](http://tinyurl.com/athenaforehead) -- they are built up gradually, with lots of errors and refinements along the way. I'm not even sure it's a great idea to do so much manipulation in one fell swoop. Is the statement above really hard for you to read? If yes, then by all means break it into pieces and make some intermediate objects. Your code should be easy to write and read when you're done.

### Working with two datasets

When working with two or more datasets, we routinely join them. `dplyr` adopts the SQL-dialect for joining datasets. Below are examples for those of us who don't speak SQL so good. There are lots of [Venn diagrams re: SQL joins on the interwebs](https://encrypted.google.com/search?q=sql+join&tbm=isch), but I wanted R examples.

[Full documentation](http://www.rdocumentation.org/packages/dplyr) for the dplyr package, which is developed by Hadley Wickham and Romain Francois on [GitHub](https://github.com/hadley/dplyr). The [vignette on Two-table verbs](https://cran.r-project.org/web/packages/dplyr/vignettes/two-table.html) covers the joins shown here.

### Variable recoding with dplyr
- `recode` and `recode_factor`: Replace numeric values based on their position, and character values by their name;
- `if_else`: Replace values based on a logical vector;
- `case_when`: Vectorise multiple if and else if statements.

Recoding, when to use which function:
- one-to-one, many-to-one: `recode` and `recode_factor`

Download the NHTS 2009 data file for the demos [here](https://raw.githubusercontent.com/cities/datascience2017/master/data/NHTS2009_dd.csv) (Right click & select Save As...)


```r
library(tidyverse)

# load NHTS2009 travel diaries subset
dd <- read_csv("data/NHTS2009_dd.csv")
```

```
## Parsed with column specification:
## cols(
##   HOUSEID = col_integer(),
##   PERSONID = col_character(),
##   HHSIZE = col_integer(),
##   HH_RACE = col_character(),
##   HHFAMINC = col_character(),
##   URBRUR = col_character(),
##   TRIPPURP = col_character(),
##   TRPTRANS = col_character(),
##   TRVLMIN = col_integer(),
##   TRPMILES = col_double()
## )
```

```r
# recode race (HH_RACE column) according to data dictionary: http://nhts.ornl.gov/tables09/CodebookPage.aspx?id=951
dd %>% mutate(hh_race_str=recode(HH_RACE, 
                                 "01"="White",
                                 "02"="African American, Black",
                                 "03"="Asian Only",
                                 "04"="American Indian, Alaskan Native",
                                 "05"="Native Hawaiian, other Pacific",
                                 "06"="Multiracial",
                                 "07"="Hispanic/Mexican",
                                 "97"="Other specify",
                                 .default = as.character(NA) # any unspecified values would be assgined NA
                                 )) %>% 
  select(HH_RACE, hh_race_str)
```

```
## # A tibble: 304 x 2
##    HH_RACE hh_race_str
##      <chr>       <chr>
##  1      01       White
##  2      01       White
##  3      01       White
##  4      01       White
##  5      01       White
##  6      01       White
##  7      01       White
##  8      01       White
##  9      01       White
## 10      01       White
## # ... with 294 more rows
```

- a logical condition: `if_else`

```r
# code driving & non-driving based on travel modes (TRPTRANS column) data dictionary: http://nhts.ornl.gov/tables09/CodebookPage.aspx?id=1084
dd %>% mutate(driving=ifelse(TRPTRANS %in% c("01", "02", "03", "04", "05", "06", "07"), 1, 0),
              driving=ifelse(TRPTRANS %in% c("-1", "-7", "-8", "-9"), NA, driving) # retain missing values as NA
             ) %>% 
  select(TRPTRANS, driving)
```

```
## # A tibble: 304 x 2
##    TRPTRANS driving
##       <chr>   <dbl>
##  1       03       1
##  2       03       1
##  3       03       1
##  4       03       1
##  5       03       1
##  6       03       1
##  7       03       1
##  8       03       1
##  9       03       1
## 10       03       1
## # ... with 294 more rows
```

- multiple logical conditions: `case_when`

```r
# code driving & non-driving based on travel modes (TRPTRANS column) data dictionary: http://nhts.ornl.gov/tables09/CodebookPage.aspx?id=1084 use case_when
dd %>% mutate(driving=case_when(
  TRPTRANS %in% c("01", "02", "03", "04", "05", "06", "07") ~ 1, 
  TRPTRANS %in% c("-1", "-7", "-8", "-9") ~ as.double(NA), # retain missing values as NA
  TRUE ~ 0)) %>% 
  select(TRPTRANS, driving)
```

```
## # A tibble: 304 x 2
##    TRPTRANS driving
##       <chr>   <dbl>
##  1       03       1
##  2       03       1
##  3       03       1
##  4       03       1
##  5       03       1
##  6       03       1
##  7       03       1
##  8       03       1
##  9       03       1
## 10       03       1
## # ... with 294 more rows
```

```r
# reclassify households into low, med, high income based on HHFAMINC column data dictionary: http://nhts.ornl.gov/tables09/CodebookPage.aspx?id=949 with brackets [0, 30000, 6000]
dd <- dd %>% mutate(income_cat=case_when(
  HHFAMINC %in% c("01", "02", "03", "04", "05", "06") ~ "low income",
  HHFAMINC %in% c("07", "08", "09", "10", "11", "12") ~ "med income",
  HHFAMINC %in% c("13", "14", "15", "16", "17", "18") ~ "high income",
  TRUE ~ as.character(NA) # retain missing values as NA
  ))

# verify recodeing results with group_by & tally
dd %>% group_by(HHFAMINC, income_cat) %>% 
  tally()
```

```
## # A tibble: 13 x 3
## # Groups:   HHFAMINC [?]
##    HHFAMINC  income_cat     n
##       <chr>       <chr> <int>
##  1       01  low income     4
##  2       02  low income     2
##  3       03  low income    12
##  4       04  low income     2
##  5       06  low income    18
##  6       07  med income     6
##  7       08  med income    10
##  8       12  med income     7
##  9       14 high income    20
## 10       16 high income    38
## 11       17 high income    64
## 12       18 high income   115
## 13       -7        <NA>     6
```

### Programming with dplyr

- [Non-standard Evaluation in dplyr 0.6+](https://alexpghayes.github.io/2017/gentle-non-standard-evaluation-in-dplyr-0-6/)
- [Programming with dplyr](http://dplyr.tidyverse.org/articles/programming.html)

## Exercise
1. Filter days where there are missing values in bike counts and weather information. Count number of days with missing values on either bike counts or weather information;
1. Calculate weekly, monthly, and annual bike counts from the daily bike counts data using dplyr verbs;
1. Join the bike counts data with the weather data. Which type of joins works best here?
1. With the [NHTS2009 travel diaries data](https://raw.githubusercontent.com/cities/datascience2017/master/data/NHTS2009_dd.csv), how do you cacluate total miles traveled (using any modes) and miles traveled by driving for each household (hint: the TRPMILES column contains information of trip distance for each member of a household).
1. [Challenge] How do you compute the average household-level miles driving per capita by income categories (low, med, high)?

## Learning more
1. [Dataframe Manipulation with dplyr](http://swcarpentry.github.io/r-novice-gapminder/13-dplyr/)
1. [Data Wrangling Cheat sheet](https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf)
