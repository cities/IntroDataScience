# Create R Package

## Lesson

1. [Developing R Packages with RStudio](https://support.rstudio.com/hc/en-us/articles/200486488-Developing-Packages-with-RStudio)
1. [Building, Testing, and Distributing Packages](https://support.rstudio.com/hc/en-us/articles/200486508-Building-Testing-and-Distributing-Packages)
1. [Writing Package Documentation](https://support.rstudio.com/hc/en-us/articles/200532317)
1. [Writing documents for R package](http://r-pkgs.had.co.nz/man.html)

## R package checklist
0. Check out (clone) the package repository as a RStudio project or create a R package project from RStudio menu **File/New Project...**;
1. Test that the pakcage builds and loads without issue;
1. Check the package with `devtools::check()`, which also runs tests inlcuded in the package; verify there are no errors or warnings;
1. Does the package include tests? Do the tests run successfully?
1. Verify that the package includes proper documents as roxygen comments in the R code files;
1. (Does the package include vignettes?)
1. Install the package and load it with `library`;
1. See what functions are provided by the package with `ls("package:<package name>")` after loading it with `library`;
1. Study the vignettes and help documents to learn how to use it.

## Exercise

Re-organize the function(s) you developed in [the R coding basics section](02-coding.html) into a R package:

- Use roxgen comments to specify the dependencies of your function(s);
- Use roxgen comments to document your function(s);
- [Advanced] Create tests for your functions;
- Make sure your package build and load properly;
- Go through the R package checklist;
- Commit your package as a GitHub repository.

## Learning more
1. [R Package by Hadley Wickham](http://r-pkgs.had.co.nz/)
1. [Making Your First R Package by Fong Chun Chan](http://tinyheero.github.io/jekyll/update/2015/07/26/making-your-first-R-package.html)
1. [A Quickstart Guide for Building Your First R Package](https://methodsblog.wordpress.com/2015/11/30/building-your-first-r-package/)
