--- 
title: "Introduction to Data Science \nfor Transportation Researchers, Planners, and Engineers"
author: "Liming Wang"
#date: "2017-11-26"
site: "bookdown::bookdown_site"
output:
    bookdown::gitbook:
      lib_dir: "book_assets"
      keep_md: false
# output:
#     bookdown::word_document2:
#         reference_docx: Final_Report_Template_July_2017.docx
bibliography: datascience.bib
biblio-style: apalike
link-citations: yes
documentclass: book
github-repo: cities/datascience
description: ""
---



# Introduction to Data Science

With almost every aspect of transportation research and practice driven to utilize complex computer software and innovative data sources [@UTRC2014], researchers and professionals increasingly face the computing challenges that have plagued other science and engineering disciplines [@Merali2010]. Most students of science, engineering, and planning are never taught to build, use, validate, and share software well [@Merali2010]. To help students and professionals in transportation research cope with these challenges, this project will apply lessons from similar programs in other disciplines and aims to equip them with proper scientific computing skills.

The direct outcomes of this project are a course plan and materials for training transportation students and professionals in basic data science. The course materials are open-source under the Creative Commons (CC) license and publicly available online on GitHub at https://cities.github.com/datascience. Any school or instructor can replicate the course. The course would also be helpful to transportation practitioners who may use it for self-instruction.

The intangible outcomes of this project will be groups of transportation students who are better equipped for transportation research in the age of computing, and who can spend less time wrestling with software and more time doing useful research.

The project identifies and absorbs the best practices in data science in academic and professional literature (for example, @Wilson2014) as well as successful courses and workshops for similar purpose, such as the Software Carpentry lessons, and develops the following course topics:

- Best practices in data science,
- Coding and scripting basics,
- Version control using Git,
- The import-tidy-transform-visualize-model-communicate workflow, 
- Communication and reproducible research, and
- How to find help.

The course was first offered as a [Transportation Research and Education Consortium (TREC)](https://trec.pdx.edu) [summer course in 2017](https://cities.github.io/datascience2017/index.html). Future offerings of the course is being planned.

## Syllabus

Did you ever feel you are “drinking from a hose” with the amount of data you are attempting to analyze? Have you been frustrated with the tedious steps in your data processing and analysis process and thinking, “There’s gotta be a better way to do things”? Are you curious what the buzz of data science is about? If any of your answers are yes, then this course is for you. 
Although computing is now integral to every aspect of science and engineering, transportation research included, most students of science, engineering, and planning are never taught how to build, use, validate, and share software well. As a result, many spend hours or days doing things badly that could be done well in just a few minutes and in a repeatable and self-documented way. The goal of this course is to empower students to spend less time wrestling with software and more time doing useful research/work. 
Building on successful data science training programs such as the Software Carpentry (http://www.software-carpentry.org/) and Data Carpentry, and recent developments in related software and research, this course exposes transportation students and professional to the best practices in data science and scientific computing through lectures, discussion, and hands-on lab sessions and aims to help them tackle the challenge of “drinking from a hose” when dealing with an overwhelming amount of data.

### Format, Software and Hardware

Classes will all be hands-on sessions with lecture, discussions and labs. A major component of the class is the class project, in which students go through actual data processing, analysis and reporting while learning the best practices of data science.

This course will use the free statistical software R, with RStudio (https://www.rstudio.com/) as the main interface. The lecture and lab instructions will use R. It is possible (and encouraged) for existing Python users (and potentially users of other software, such as, Stata, Matlab, etc) to keep using the software they already know well. Students are encouraged to bring their own laptops. The instructor and TA will help the students set laptops up to run all examples and exercises in lectures and labs, and to re-run them later for review and their own project.

### Prerequisite

Basic knowledge and experience of working with quantitative data; experiences and skills in (or keenness to learn) a programming language (e.g. Python) and/or data processing and statistical software (e.g. R, Matlab, Stata).

### Textbook and Readings

The course will use the following textbook:

- [Wickham, H., Grolemund, G., 2017. R for Data Science: Import, Tidy, Transform, Visualize, and Model Data, 1 edition. ed. O’Reilly Media](https://www.amazon.com/Data-Science-Transform-Visualize-Model/dp/1491910399). (R4DS)

An electronic version is available on [Hadley Wickham's website](http://r4ds.had.co.nz/).

For Python users, Wes McKinney’s book is recommended:

- [McKinney, W., 2012. Python for Data Analysis: Data Wrangling with Pandas, NumPy, and IPython, 1 edition. ed. O’Reilly Media](https://www.amazon.com/Python-Data-Analysis-Wrangling-IPython/dp/1449319793).

Journal articles and online resources are used as supplements to the textbook.

### Topics

Topics are tentative and subject to change according to students’ needs, but will be centered on these topical areas:

-	Part I:
  1. Overview
  1. Coding and scripting basics
  3. Version control using Git
  2. R Package
  4. Workflow and RStudio, and
  5. How to find help
  
- Part II:
  1. Overview
  1. The import-tidy-transform-visualize-model-communicate workflow
  2. tidyverse suite of packages (dplyr, tidyr, ggplot2, and purrr)
  3. R Markdown

## License

The course materials are made available under the [Creative Commons Attribution license](https://creativecommons.org/licenses/by/4.0/).

## Acknowledgements

This course is developed with the financial support from National Institute of Transportation and Communities project #854. 

<div style="width:300px">
[![NITC](http://nitc.trec.pdx.edu/sites/default/files/nitc_4c_horiz_tag.jpg)](http://nitc.trec.pdx.edu/)
</div>

I am grateful to the participants of the 2017 summer course for the valueable feedback. The support of TREC staff, in particular, Lisa Patterson and Eva-Maria Muecke, is greatly appreciated.

Parts of the course materials have been adpated from the following sources:

- [R for Data Science](https://github.com/hadley/r4ds) by Hadley Wickham
- [Software Carpentry workshop lessons](https://software-carpentry.org/lessons/)
- [UBC Stat 545](http://stat545.com) by Professor Jenny Bryan at UBC
- [NEU 5110 Introduction to Data Science](http://janvitek.org/events/NEU/5110/) by Professor Jan Vitek

The writing-up and website is powered by the [bookdown](https://bookdown.org) package and [github](https://www.github.com).
