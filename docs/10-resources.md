# Resources

## Where to go from here

R is getting more powerful all the time. There are many exciting features and packages that we have not covered and many more are emerging. Below are a few features I think are worth mentioning:

### Automate testing your code


### Automate your workflow

If you are seasoned programmer and are familiar with the `make` toolchain, you can use it to automate your workflow too. Professor Jenny Bryan provides [a tutorial](http://stat545.com/automation00_index.html) for her STAT 545 class.

A more research-oriented solution is to use [the `remake` package](https://github.com/richfitz/remake):

> The idea here is to re-imagine a set of ideas from make but built for R. Rather than having a series of calls to different instances of R (as happens if you run make on R scripts), the idea is to define pieces of a pipeline within an R session. Rather than being language agnostic (like make must be), remake is unapologetically R focussed.

`remake` is still under heavy development and is not yet available on CRAN. You will have to install it from github:


```r
library(devtools)
install_github("richfitz/remake")
```

### Share your work as a R package

If the scripts, data, and/or documents you develop has values to people besides your direct collaborators, it may be worth considering release them as a R package and share it with the world. How cold is that? And it is not hard at all with many helpful functions provided by the `devtools` package and RStudio.

[R Packages](http://r-pkgs.had.co.nz/) by Hadley Wickham is the best resource for developing R packages. If you want more hands-on tutorials, check out the one by [Prof Jenny Bryan](http://stat545.com/packages00_index.html) and [Chun Chan](http://tinyheero.github.io/jekyll/update/2015/07/26/making-your-first-R-package.html).

### Develop interactive apps with Shiny

Shiny allows you to develop interactive apps that run on top of R. Again Prof Jenny Bryan has a nice [tutorial for getting started with Shiny](http://stat545.com/shiny00_index.html).

### Where to go from here

Practice makes perfection. Use what you learned as much as possible in your research and work.

## Where to find help
1. Help documents
1. Package vignett and manual
1. [R cookbook](http://www.cookbook-r.com/)
1. [stackoverflow](http://stackoverflow.com/questions/tagged/r), A Q&A community for programming
1. Google is your friend
1. Ask a person that may know
