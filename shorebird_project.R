#relevant libraries
library(tidyverse)
library(moderndive)
library(modelr)
library(broom)
library(readr)

#loaded data 
  #obtained from repository noted in the README file
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
                        caption = "Figure 1. Depiction of immediate displacement resulting from different disturbance categories. The points are indicative of each displacement event of the 240 observations.")
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
       caption = "Figure 2. Relationship between the distance birds traveled during intervals of high tide and the maximum water level during these events. Data is divided between three relevant roosting sites: Mid, North, and South (shown in red, green, and blue - respectively).") 

#Linear model comparing the total movement distance to the water level during a high tide interval
  #model, when run, displays an overall p-value indicating significance and r^2 value accounting for variability in the data
model_2_hightide <- lm(distance_total ~ waterlevel, data = hightide)
summary(model_2_hightide)

#high tide model, mapped across the three roosting sites
  #not totally necessary for data manipulation, but could be helpful to see how the sites differ in water level and roost sensitivity
model_2_roost_split <- hightide %>%
  split(.$roost)%>%
  map(~lm(distance_total ~ waterlevel, data = .))


#Figure 3 plot
ggplot(hightide, aes(distance_disturbed, distance_total)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  theme_classic() +
  labs(x ="Total Immediate Displacement (km)",
       y = "Distance Traveled in High Tide Interval (km)",
       title = "Displacement as a Result of Disturbance and High Tide Travel Distance",
       caption = "Figure 3. Relationship between the total distance traveled within the high tide period in kilometers (i.e. high tide travel distance) and the total distance traveled in responce to immediate disturbance within the high tide period in kilometers (calculated as the sum of the collected movements from GPS transmitters from disturbance, i.e. total immediate displacement).")

#linear summary and model of the figure 3 data
model_3_htdist <- lm(distance_total ~ distance_disturbed, data = hightide)
summary(model_3_htdist)


#Figure 4 plot 
ggplot(hightide, aes(distance_disturbed, distance_additional)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  theme_classic() +
  labs(x ="Total Immediate Displacement (km)",
       y = "Additional High Tide Travel Distance (km)",
       title = "Displacement as a Result of Disturbance and Additional Travel Distance",
       caption = "Figure 4. Depiction of the relationship bewteen the additional distance traveled during the high tide interval, measured in kilometers, and the total distance traveled in response to immediate disturbance events, also measured in kilometers.") 

#linear summary and model of the figure 4 data
model_4_adddist <- lm(distance_additional ~ distance_disturbed, data = hightide)
summary(model_4_adddist)


#energy budget calculations

  #calculate the average distance birds moved in each disturbance category
  #tibble created where "m" = the average displacement distance in km
dist_avg <- disturbance %>% group_by(movement_category) %>% summarise(m = mean(distance))
  
  #updated table to add energy expenditure, multiplying the average distance by the 3000 J/km used in flight
    #this number was obtained by multiplying the 36 J/s used in flight and the bird's average flight speed of 12 J/s
dist_avg_eng <- dist_avg %>% mutate(energy_use = m*3000)
  #further updated table showing the average energy use due to disturbance compared to the daily energy requirement in J
    #with an additional column quantifying the energy use in kJ
dist_avg_eng_use <- dist_avg_eng %>% mutate(860000-energy_use) %>% mutate((860000-energy_use)/1000)

