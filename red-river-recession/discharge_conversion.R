# Reading Datasets

# data for Fargo
fargo <- read.csv("C:/Users/Luca/Desktop/SPRING2021/Statistical Research/Combined data/CompleteFargoWithRecession.csv", encoding="UTF-8")
# data for Grand
grand <- read.csv("C:/Users/Luca/Desktop/SPRING2021/Statistical Research/Combined data/CompleteGrandWithRecession.csv", encoding="UTF-8")

# making conversion
library(dplyr)

fargo <- fargo %>% 
  mutate(discharge.mm.day = (discharge) * (1.39*10^(-4)))

grand <- grand %>% 
  mutate(discharge.mm.day = (discharge) * (3.936*10^(-5)))

fargo <- fargo %>% 
  mutate(season = if_else(Spring == 1, 1, if_else(Summer == 1, 2, 0)))

grand <- grand %>% 
  mutate(season = if_else(Spring == 1, 1, if_else(Summer == 1, 2, 0)))

fargo$season <- as.factor(fargo$season)
grand$season <- as.factor(grand$season)

#saving as csv
write.csv(grand, "grand.csv")
write.csv(fargo, "fargo.csv")
