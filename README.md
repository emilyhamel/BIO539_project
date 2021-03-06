---
title: "BIO539_README"
author: "Emily Hamel"
date: "April 26, 2021"
output: pdf_document
---

This anlaysis utilizes data from collected in a 2019 paper examining the relationship between shorebird energy expendature and near-by human disturbance. 
These data were obtained from the Dryad Digital Repository at the following location: 
  https://doi.org/10.5061/dryad.74vm25v


The "header.txt" file was created to fix issues of figures cutting off captions and moving to different locations when knit from the Rmarkdown file. The text was copied from an online user. SOURCE: https://stackoverflow.com/questions/51582345/image-position-in-r-markdown/56949568#56949568


The intention of this test was, primarily, to explore the data from a shorebird related study. With limited statistical knowledge, it was the intention of this project to simply work through these results and to test this researcher's knowledge of R programming and ability to produce accurate figures with the available data. 


The shorebird_project.R file is annotated in the interest of reproducibility, but there are no functions involved that require more specific instructions in order to make them run correctly. 


It should also be noted that the statistical models referenced in the R code and the Rmarkdown files are listed according to the figures they refer to. 

For example: 
"model_1" is associated with Figure 1.
"model_1_pair" is the pairwise analysis, also associated with Figure 1.
"model_2_hightide" is the overall linear model associated with Figure 2.
"model_2_roost_split" outlines the difference in roost locations within the linear model, also associated with Figure 2.
And so on.

The Rmarkdown files and output PDFs display a combination of inline code and copied information with the relevant statistical values. This is due to the fact that I was unable to figure out how to convey inline values from a pairwise test. Hopefully, this does not pose to great challenge to the reader attempting to recreate this data. 