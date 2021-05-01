library(tidyverse)
library(moderndive)
library(modelr)
library(broom)
library(readr)

hightide <- read_csv("DATA/High.tide.analysis.csv")
disturbance <- read_csv("DATA/Immed.displ.analysis.csv")
hightide_README <- read_csv("DATA/README_for_High.tide.analysis.csv")
disturbance_README <- read_csv("DATA/README_for_Immed.displ.analysis.csv")

#Figure 1 plot
ggplot(disturbance, aes(movement_category, distance)) + 
  geom_point() + 
  labs(x = "Movement Category", 
                        y = "Immediate Displacement Distance (km)", 
                        title = "Immediate Displacement as a Result of Disturbance",
                        caption = "Figure 1. Depiction of immediate displacement resulting from different disturbance
                        categories. The points are indicative of each displacement event of the 240 observations.")
#Short-term disturbance statistical test
model_1 <- kruskal.test(distance ~ movement_category, data = disturbance) #overall significance 
pairwise.wilcox.test(disturbance$distance, g = disturbance$movement_category) #pairwise significance across categories

