library(lubridate)
library(dplyr)

grand_from_2014 <- read.csv("C:/Users/Luca/Desktop/SPRING2021/Statistical Research/Combined data/grand_from_2014.csv", encoding="UTF-8")
rainfall_grand <- read.csv("C:/Users/Luca/Desktop/SPRING2021/Statistical Research/RainFall data/grand_rainfall.csv", encoding="UTF-8")

# make dates
grand_from_2014$date <- make_date(year = grand_from_2014$year,
                                  month = grand_from_2014$month,
                                  day = grand_from_2014$day)
rainfall_grand$date <- ymd(rainfall_grand$DATE)

# delete rows
rainfall_grand <- rainfall_grand[-(1:5265),]
rownames(rainfall_grand) <- 1:nrow(rainfall_grand)
rainfall_grand <- rainfall_grand[(1:2294),]

# include rainfall new data
ifelse(is.na(grand_from_2014$rainfall),grand_from_2014$rainfall<-rainfall_grand$PRCP,grand_from_2014$rainfall<-grand_from_2014$rainfall)

# Check for other NAs
sum(is.na(grand_from_2014$rainfall))

### Create time series and predict missing value of all NA
### Using package imputeTS
library(imputeTS)

# DO IT FOR ALL SOILs
soil5_ts <- ts(grand_from_2014$soil.225)
soil5_no_na <- na_seadec(soil5_ts)
statsNA(soil5_ts)
ggplot_na_distribution(soil5_ts)
soil_5_new <- data.frame(soil5_no_na)
grand_from_2014$soil.225 <- soil_5_new$soil5_no_na

# make new column for top ground temperature
grand_from_2014$top.soil.temp <- rowMeans(grand_from_2014[,c(9,10,11,12)])

# check na for na
sum(is.na(grand_from_2014$soil.20))

# save file
write.csv(grand_from_2014, "grand_complete_new.csv")
