# R Markdown

R Markdown provides an authoring framework for data science. You can use a single R Markdown file to both

- save and execute code
- generate high quality reports that can be shared with an audience

R Markdown documents are fully reproducible and support dozens of static and dynamic output formats. 

You write R Markdown documents in a simple plain text-like format, which allows you to format text using intuitive notation, so that you can focus on the content you're writing. But you still get a well-formatted document out. In fact, you can turn your plain text (and R code and results) into an html file or, if you have an installation of LaTeX and Pandoc on your machine, a pdf, or even a Word document (if you must!).

## Readings

1. R4DS [Chapter 27](http://r4ds.had.co.nz/r-markdown.html), [Chapter 30](http://r4ds.had.co.nz/r-markdown-workflow.html), [Chapter 29](http://r4ds.had.co.nz/r-markdown-formats.html)
2. [R Markdown gallery](http://rmarkdown.rstudio.com/gallery.html)

## Lessons

To get started, install the `knitr` package.


```r
install.packages("knitr")
```

When you click on File -> New File, there is an option for "R Markdown...". Choose this and accept the default options in the dialog box that follows (but note that you can also create presentations this way). Save the file and click on the "Knit HTML" button at the top of the script. Compare the output to the source.

> **Formatting Text in Markdown**
>
> Visit <http://rmarkdown.rstudio.com/authoring_basics.html> and briefly check out some of the formatting options.
>
> In the example document add
>
> * Headers using `#`
> * Emphasis using astericks:  \*italics\* and \*\*bold\*\*
> * Lists using `*` and numbered lists using `1.`, `2.`, etc.

Markdown also supports LaTeX equation editing.
We can display pretty equations by enclosing them in `$`,
e.g., `$\alpha = \dfrac{1}{(1 - \beta)^2}$` renders as: $\alpha = \dfrac{1}{(1 - \beta)^2}$.

The top of the source (.Rmd) file has some header material in YAML format (enclosed by triple dashes).
Some of this gets displayed in the output header, other of it provides formatting information to the conversion engine.

To distinguish R code from text, RMarkdown uses three back-ticks followed by `{r}` to distinguish a "code chunk".
In RStudio, the keyboard shortcut to create a code chunk is command-option-i or control-alt-i.

A code chunk will set off the code and its results in the output document,
but you can also print the results of code within a text block by enclosing code like so: `` `r code-here` ``.

> **Use knitr to Produce a Report**
>
> 1. Open an new .Rmd script and save it as inflammation_report.Rmd
> 2. Copy code from earlier into code chunks to read the inflammation data and plot average inflammation.
> 3. Add a few notes describing what the code does and what the main findings are. Include an in-line calculation of the median inflammation level.
> 4. `knit` the document and view the html result.

## Exercise

Follow [Test drive R Markdown by Professor Bryan](http://stat545.com/block007_first-use-rmarkdown.html) to create a report (in html format) that includes:

- A brief introduction of the bike counts data (where were the data collected, the period, etc);
- Load the bike counts data in the R code chunks of your R markdown file;
- Embed summary statistics and visualization of the bike counts data in your report.

[Advanced] Create a vignette for the R package you created for [Create R Package](04-package.html) that demonstrates the usage of the package. 

## Learning more
1. [R Markdown from RStudio](http://rmarkdown.rstudio.com/lesson-1.html)
1. [R Markdown Cheatsheet](https://www.rstudio.com/wp-content/uploads/2015/02/rmarkdown-cheatsheet.pdf)
1. [Software Carpentry R Markdown lesson](http://swcarpentry.github.io/r-novice-gapminder/15-knitr-markdown/)
1. [Test drive R Markdown by Professor Bryan](http://stat545.com/block007_first-use-rmarkdown.html)
1. [Writing Vignettes with R Markdown](http://r-pkgs.had.co.nz/vignettes.html)
