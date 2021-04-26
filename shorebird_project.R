library(tidyverse)
library(moderndive)
library(modelr)
library(broom)
library(readr)

hightide <- read_csv("DATA/High.tide.analysis.csv")
disturbance <- read_csv("DATA/Immed.displ.analysis.csv")
hightide_README <- read_csv("DATA/README_for_High.tide.analysis.csv")
disturbance_README <- read_csv("DATA/README_for_Immed.displ.analysis.csv")

