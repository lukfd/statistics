library(lubridate)
library(dplyr)

# Reads the data
fargo_from_2014 <- read.csv("C:/Users/Luca/Desktop/SPRING2021/Statistical Research/Combined data/fargo_from_2014.csv", encoding="UTF-8")
rainfall_fargo <- read.csv("C:/Users/Luca/Desktop/SPRING2021/Statistical Research/RainFall data/fargo_rainfall.csv", encoding="UTF-8")

# make dates
fargo_from_2014$date <- make_date(year = fargo_from_2014$year,
                                   month = fargo_from_2014$month,
                                   day = fargo_from_2014$day)
rainfall_fargo$date <- ymd(rainfall_fargo$DATE)

# delete rows
rainfall_fargo <- rainfall_fargo[-(1:5388),]
rownames(rainfall_fargo) <- 1:nrow(rainfall_fargo)
rainfall_fargo <- rainfall_fargo[(1:2294),]

# include rainfall new data
ifelse(is.na(fargo_from_2014$rainfall),fargo_from_2014$rainfall<-rainfall_fargo$PRCP,fargo_from_2014$rainfall<-fargo_from_2014$rainfall)

# Check for other NAs
sum(is.na(fargo_from_2014$snow.depth))

# make new column for top ground temperature
fargo_from_2014$top.soil.temp <- rowMeans(fargo_from_2014[,c(9,10,11,12)])

# save file
write.csv(fargo_from_2014, "fargo_complete.csv")
