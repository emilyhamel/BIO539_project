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
  theme_classic() +
  labs(x = "Movement Category", 
                        y = "Immediate Displacement Distance (km)", 
                        title = "Immediate Displacement as a Result of Disturbance",
                        caption = "Figure 1. Depiction of immediate displacement resulting from different disturbance
                        categories. The points are indicative of each displacement event of the 240 observations.")
#Short-term disturbance statistical test
model_1 <- kruskal.test(distance ~ movement_category, data = disturbance) #overall significance 
model_1_pair <- pairwise.wilcox.test(disturbance$distance, g = disturbance$movement_category) #pairwise significance across categories


#Figure 2 plot
ggplot(hightide, aes(waterlevel, distance_total, color = roost)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  theme_classic() +
  labs(x = "Maximum Water Level at High Tide (m)", 
       y = "Distance Traveled in High Tide Interval (km)", 
       color = "Roost Site", 
       title = "High Tide Travel Distance and Water Level",
       caption = "Figure 2. Relationship between the distance birds traveled during intervals of high tide and the maximum water level during these events.
       Data is divided between three relevant roosting sites: Mid, North, and South (shown in red, green, and blue - respectively).") 

#Figure 3 plot
ggplot(hightide, aes(distance_disturbed, distance_total)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  theme_classic()
