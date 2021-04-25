library(tidyverse)
library(moderndive)
library(modelr)
library(broom)

hightide <- read_csv("https://datadryad.org/stash/downloads/file_stream/113068")
disturbance <- read_csv("https://datadryad.org/stash/downloads/file_stream/113066")
hightide_README <- read_csv("https://datadryad.org/stash/downloads/file_stream/113069")
disturbace_README <- read_csv("https://datadryad.org/stash/downloads/file_stream/113067")

