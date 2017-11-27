# Where to go from here

## Noticeable features not covered
R is getting more powerful all the time. There are many exciting features and packages that we have not covered and many more are emerging. Below are a few features I think are worth mentioning:

## Automate testing your code

It is always a good idea to test your code with simple inputs to make sure it work correctly before adding complexity and deploying it for actual work (see best practices for data science 5). There are ways to automate the tests, so you will not forget to run the tests. Hadley Wickham writes about [testing for R packages](http://r-pkgs.had.co.nz/tests.html) and [`testthat` is a R package specifically to make testing](https://github.com/r-lib/testthat). And if you use GitHub or other popular public version control website, it is possible to use Travis-CI to do "continuous integration" tests for your code. Julia Silge has [a nice tutorial for beginners](https://juliasilge.com/blog/beginners-guide-to-travis/).

## Automate your workflow

If you are seasoned programmer and are familiar with the `make` toolchain, you can use it to automate your workflow too. Professor Jenny Bryan provides [a tutorial](http://stat545.com/automation00_index.html) for her STAT 545 class.

A more research-oriented solution is to use [the `remake` package](https://github.com/richfitz/remake):

> The idea here is to re-imagine a set of ideas from make but built for R. Rather than having a series of calls to different instances of R (as happens if you run make on R scripts), the idea is to define pieces of a pipeline within an R session. Rather than being language agnostic (like make must be), remake is unapologetically R focussed.

`remake` is still under heavy development and is not yet available on CRAN. You will have to install it from github:


```r
library(devtools)
install_github("richfitz/remake")
```

## Develop interactive apps with Shiny

Shiny allows you to develop interactive apps that run on top of R. Again Prof Jenny Bryan has a nice [tutorial for getting started with Shiny](http://stat545.com/shiny00_index.html).

## Where to go from here

Practice makes perfection. Use what you learned as much as possible in your research and work.

## Where to find help

1. Help documents;
1. Package vignett and manual;
1. [R cookbook](http://www.cookbook-r.com/);
1. [Stack Overflow](http://stackoverflow.com/questions/tagged/r) and [Cross Validated](https://stats.stackexchange.com/), A Q&A community for programming and statistics;
1. Google is your friend;
1. Ask a person that may know.
