# Script for creating master dataset
# Fargo
meteo_fargo <- read.csv("C:/Users/Luca/Desktop/SPRING2021/Statistical Research/CSV Cleaned/Meteorological Data for Fargo_cleaned.csv", encoding="UTF-8")

snowdepth_fargo <- read.csv("C:/Users/Luca/Desktop/SPRING2021/Statistical Research/CSV Cleaned/Snow Depth for Fargo.csv", encoding="UTF-8")

streamflow_fargo <- read.csv("C:/Users/Luca/Desktop/SPRING2021/Statistical Research/CSV Cleaned/Streamflow for Fargo.csv", encoding="UTF-8")

soiltemp_fargo <- read.csv("C:/Users/Luca/Desktop/SPRING2021/Statistical Research/CSV Cleaned/Soil_Temps_Avg_Fargo.csv", encoding="UTF-8")

# Checking for missing days
library(lubridate)

soiltemp_correct <- soiltemp_fargo
soiltemp_correct$date <- make_date(year = soiltemp_fargo$X.U.FEFF.Year,
                                    month = soiltemp_fargo$Month,
                                    day = soiltemp_fargo$Day)

FullSeq <- seq.Date(from = min(soiltemp_correct$date), to = max(soiltemp_correct$date), by = 1)


Missing<-FullSeq[!FullSeq %in% soiltemp_correct$date]
Missing

meteo_fargo_from_2014 <- meteo_fargo[-(1:5388),]
rownames(meteo_fargo_from_2014) <- 1:nrow(meteo_fargo_from_2014)
meteo_fargo_from_2014 <- meteo_fargo_from_2014[(1:2294),]

streamflow_fargo_from_2014 <- streamflow_fargo[-(1:5388),]
rownames(streamflow_fargo_from_2014) <- 1:nrow(streamflow_fargo_from_2014)
streamflow_fargo_from_2014 <- streamflow_fargo_from_2014[(1:2294),]

snowdepth_fargo_from_2014 <- snowdepth_fargo[-(1:4019),]
rownames(snowdepth_fargo_from_2014) <- 1:nrow(snowdepth_fargo_from_2014)
snowdepth_fargo_from_2014 <- snowdepth_fargo_from_2014[(1:2294),]

soiltemp_fargo_from_2014 <- soiltemp_fargo[(1:2294),]

fargo <- data.frame(meteo_fargo_from_2014$Month,
                    meteo_fargo_from_2014$Day,
                    meteo_fargo_from_2014$Year,
                    meteo_fargo_from_2014$Avg.Temp,
                    meteo_fargo_from_2014$Penman.PET,
                    meteo_fargo_from_2014$Rainfall,
                    streamflow_fargo_from_2014$Discharge,
                    snowdepth_fargo_from_2014$X.mm..Snow.Depth..SNODAS..at..96.8120E.46.8970N..2003.10.01.to.2021.01.13,
                    soiltemp_fargo_from_2014$Average.of.5.cm,
                    soiltemp_fargo_from_2014$Average.of.10.cm,
                    soiltemp_fargo_from_2014$Average.of.20.cm,
                    soiltemp_fargo_from_2014$Average.of.30.cm,
                    soiltemp_fargo_from_2014$Average.of.40.cm,
                    soiltemp_fargo_from_2014$Average.of.50.cm,
                    soiltemp_fargo_from_2014$Average.of.60.cm,
                    soiltemp_fargo_from_2014$Average.of.80.cm,
                    soiltemp_fargo_from_2014$Average.of.100.cm,
                    soiltemp_fargo_from_2014$Average.of.125.cm,
                    soiltemp_fargo_from_2014$Average.of.150.cm,
                    soiltemp_fargo_from_2014$Average.of.175.cm,
                    soiltemp_fargo_from_2014$Average.of.200.cm,
                    soiltemp_fargo_from_2014$Average.of.225.cm)

colnames(fargo) <- c("month","day","year","avg.temp","penman.pet","rainfall","discharge",
                    "snow.depth","soil.5","soil.10","soil.20","soil.30","soil.40","soil.50",
                    "soil.60","soil.80","soil.100","soil.125","soil.150","soil.175",
                    "soil.200","soil.225")
View(fargo)

write.csv(fargo, "fargo_from_2014.csv")



# Grand
meteo_grand <- read.csv("C:/Users/Luca/Desktop/SPRING2021/Statistical Research/CSV Cleaned/Meteorological Data for Grand Forks_cleaned.csv", encoding="UTF-8")

snowdepth_grand <- read.csv("C:/Users/Luca/Desktop/SPRING2021/Statistical Research/CSV Cleaned/Snow Depth from Grand Forks.csv", encoding="UTF-8")

streamflow_grand <- read.csv("C:/Users/Luca/Desktop/SPRING2021/Statistical Research/CSV Cleaned/Streamflow for Grand Forks.csv", encoding="UTF-8")

soiltemp_grand <- read.csv("C:/Users/Luca/Desktop/SPRING2021/Statistical Research/CSV Cleaned/Soil_Temps_Avg_GrandForks.csv", encoding="UTF-8")
































# Combining tables for FARGO!
# 
# need data from 10/1/2003 until 1/11/2021
#

meteo_fargo_from_2003 <- meteo_fargo[-(1:1369),]
rownames(meteo_fargo_from_2003) <- 1:nrow(meteo_fargo_from_2003)
meteo_fargo_from_2003 <- meteo_fargo_from_2003[(3),]

streamflow_fargo_from_2003 <- streamflow_fargo[-(1:1369),]
rownames(streamflow_fargo_from_2003) <- 1:nrow(streamflow_fargo_from_2003)
streamflow_fargo_from_2003 <- streamflow_fargo_from_2003[(1:6313),]

snowdepth_fargo_from_2003 <- snowdepth_fargo[(1:6313),]
rownames(snowdepth_fargo_from_2003) <- 1:nrow(snowdepth_fargo_from_2003)

# Fix missing days in snowdepth
library(lubridate)

snowdepth_correct <- snowdepth_fargo_from_2003
snowdepth_correct$date <- make_date(year = snowdepth_fargo_from_2003$Year,
                                    month = snowdepth_fargo_from_2003$X.U.FEFF.Month,
                                    day = snowdepth_fargo_from_2003$Day)

FullSeq <- seq.Date(from = min(snowdepth_correct$date), to = max(snowdepth_correct$date), by = 1)


Missing<-FullSeq[!FullSeq %in% snowdepth_correct$date]
Missing
# create FARGO master dataset

fargo <- data.frame(meteo_fargo_from_2003$Month,
                    meteo_fargo_from_2003$Day,
                    meteo_fargo_from_2003$Year,
                    meteo_fargo_from_2003$Avg.Temp,
                    meteo_fargo_from_2003$Penman.PET,
                    meteo_fargo_from_2003$Rainfall,
                    streamflow_fargo_from_2003$Discharge)


# Combining tables for FARGO!
# 
# need data from 10/1/2003 until 1/13/2021
#






