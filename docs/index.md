--- 
title: "Introduction to Data Science \nfor Transportation Researchers, Planners, and Engineers"
author: "Liming Wang"
date: "2017-03-16"
site: "bookdown::bookdown_site"
output:
   bookdown::gitbook:
     lib_dir: "book_assets"
#output: bookdown::word_document2
documentclass: book
#bibliography: []
#biblio-style: apalike
link-citations: yes
github-repo: cities/datascience
description: ""
---




# Syllabus

Did you ever feel you are “drinking from a hose” with the amount of data you are attempting to analyze? Have you been frustrated with the tedious steps in your data processing and analysis process and thinking there gotta be a better way to do things? Are you curious what the buzz of data science is about? If any of your answers is yes, then this course is for you. Although computing is now an integral part of every aspect of science and engineering, transportation research included, most students of science, engineering, and planning are never taught how to build, use, validate, and share software well. As a result, many spend hours or days doing things badly that could be done well in just a few minutes. The goal of this course is to start changing that so that the students can spend less time wrestling with software and more time doing useful research. Building on the successful data science training programs, such as the Software Carpentry (http://www.software-carpentry.org/) and Data Carpentry, and recent development of related software and research, this course exposes students in transportation research and practice to the best practices in scientific computing through hands-on lab sessions and aims to help students tackle the challenge of "drinking from a hose" when dealing with overwhelming amount of data that is increasingly common in transportation research and practice.

## Prerequisite

Basic knowledge and experience of conduct scientific research with quantitative information; skill of using (or keen to learn) a programming language and/or data processing and statistical software (such as python, R, SPSS, Stata).

## Format

Classes will all be hands-on sessions with lecture, discussions and labs. Readings drawn from books, articles, and online resources will be assigned. Students are expected to read them before class and to participate in class discussions. A major component of the class is the class project in which students go through the process of data retrieval, processing, conducting analysis, and developing a report/article while learning the best practices of data science.

## Software and Hardware

This course will use R free statistical software and RStudio (https://www.rstudio.com/) as our main interface to R. The lecture and lab instructions will be provided using R. It is possible (and encouraged) for existing Python users (and potentially other software, such as SPSS, Stata, Matlab, SAS, etc) to keep using the software they already know well. Student are encouraged bring their own laptop. The instructor and TA will help the students set up their laptop to run all examples/exercises. They can review/re-run the examples in lectures and labs by themselves. 

## Textbook and Readings

The course will use the following textbook:

- [Wickham, H., Grolemund, G., 2017. R for Data Science: Import, Tidy, Transform, Visualize, and Model Data, 1 edition. ed. O’Reilly Media](https://www.amazon.com/Data-Science-Transform-Visualize-Model/dp/1491910399).

An electronic version is available on [Hadley Wickham's website](http://r4ds.had.co.nz/).

For Python users, Wes McKinney’s book is recommended:

- [McKinney, W., 2012. Python for Data Analysis: Data Wrangling with Pandas, NumPy, and IPython, 1 edition. ed. O’Reilly Media](https://www.amazon.com/Python-Data-Analysis-Wrangling-IPython/dp/1449319793).

Journal articles and online resources are used as supplements to the textbook.

## Topics

1. Data science best practices
2. Data science work flow
3. Reproducible research

## License

The course materials are made available under the [Creative Commons Attribution license](https://creativecommons.org/licenses/by/4.0/).

## Acknowledgements

This course is developed with the financial support from National Institute of Transportation and Communities project #854.

<div style="width:300px">
[![NITC](http://nitc.trec.pdx.edu/sites/default/files/nitc_4c_horiz_tag.jpg)](http://nitc.trec.pdx.edu/)
</div>

The course materials have greatly benefited from the following sources:

- [R for Data Science](https://github.com/hadley/r4ds) by Hadley Wickham
- [Software Carpentry workshop lessons](https://software-carpentry.org/lessons/)
- [UBC Stat 545](http://stat545.com) by Professor Jenny Bryan at UBC
- [NEU 5110 Introduction to Data Science](http://janvitek.org/events/NEU/5110/) by Professor Jan Vitek

The writing-up and website is powered by the [bookdown](https://bookdown.org) package and [github](https://www.github.com).

<!-- 
## PSU Accessibility and Title IX Statements

### Access and Inclusion for Students with Disabilities

Access and Inclusion for Students with Disabilities
PSU values diversity and inclusion; we are committed to fostering mutual respect and full participation for all students. My goal is to create a learning environment that is equitable, useable, inclusive, and welcoming. If any aspects of instruction or course design result in barriers to your inclusion or learning, please notify me. The Disability  Resource Center (DRC) provides reasonable accommodations for students who encounter barriers in the learning environment.

If you have, or think you may have, a disability that may affect your work in this class and feel you need accommodations, contact the Disability Resource Center to schedule an appointment and initiate a conversation about reasonable accommodations. The DRC is located in 116 Smith Memorial Student Union, 503-725-4150, drc@pdx.edu, https://www.pdx.edu/drc.

If you already have accommodations, please contact me to make sure that I have received a faculty notification letter and discuss your accommodations.
Students who need accommodations for tests and quizzes are expected to schedule their tests to overlap with the time the class is taking the test.
Please be aware that the accessible tables or chairs in the room should remain available for students who find that standard classroom seating is not useable. 
For information about emergency preparedness, please go to the Fire and Life Safety webpage (https://www.pdx.edu/environmental-health-safety/fire-and-life-safety) for information.

### Title IX Statement

Portland State is committed to providing an environment free of all forms of prohibited discrimination and sexual harassment (sexual assault, domestic and dating violence, and gender or sex-based harassment and stalking). If you have experienced any form of gender or sex-based discrimination or sexual harassment, know that help and support are available. PSU has staff members trained to support survivors in navigating campus life, accessing health and counseling services, providing academic and on-housing accommodations, helping with legal protective orders, and more. Information about PSU’s support services on campus, including confidential services and reporting options, can be found on PSU’s Sexual Misconduct Prevention and Response website at: http://www.pdx.edu/sexual-assault/get-help or you may call a confidential IPV Advocate at 503-725-5672. You may report any incident of discrimination or discriminatory harassment, including sexual harassment, to either the Office of Equity and Compliance or the Office of the Dean of Student Life.

Please be aware that all PSU faculty members and instructors are required to report information of an incident that may constitute prohibited discrimination, including sexual harassment and sexual violence. This means that if you tell me about a situation of sexual harassment or sexual violence that may have violated university policy or student code of conduct, I have to share the information with my supervisor, the University’s Title IX Coordinator or the Office of the Dean of Student Life. For more information about Title IX please complete the required student module Creating a Safe Campus in your D2L.
-->
