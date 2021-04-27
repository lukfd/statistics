# Grand
meteo_grand <- read.csv("C:/Users/Luca/Desktop/SPRING2021/Statistical Research/CSV Cleaned/Meteorological Data for Grand Forks_cleaned.csv", encoding="UTF-8")

snowdepth_grand <- read.csv("C:/Users/Luca/Desktop/SPRING2021/Statistical Research/CSV Cleaned/Snow Depth from Grand Forks.csv", encoding="UTF-8")

streamflow_grand <- read.csv("C:/Users/Luca/Desktop/SPRING2021/Statistical Research/CSV Cleaned/Streamflow for Grand Forks.csv", encoding="UTF-8")

soiltemp_grand <- read.csv("C:/Users/Luca/Desktop/SPRING2021/Statistical Research/CSV Cleaned/Soil_Temp_Avg_GrandForks.csv", encoding="UTF-8")

#

meteo_grand_from_2014 <- meteo_grand[-(1:5388),]
rownames(meteo_grand_from_2014) <- 1:nrow(meteo_grand_from_2014)
meteo_grand_from_2014 <- meteo_grand_from_2014[(1:2294),]

streamflow_grand_from_2014 <- streamflow_grand[-(1:5388),]
rownames(streamflow_grand_from_2014) <- 1:nrow(streamflow_grand_from_2014)
streamflow_grand_from_2014 <- streamflow_grand_from_2014[(1:2294),]

snowdepth_grand_from_2014 <- snowdepth_grand[-(1:4019),]
rownames(snowdepth_grand_from_2014) <- 1:nrow(snowdepth_grand_from_2014)
snowdepth_grand_from_2014 <- snowdepth_grand_from_2014[(1:2294),]

# Missing days
library(lubridate)

soiltemp_correct <- soiltemp_grand
soiltemp_correct$date <- make_date(year = soiltemp_grand$X.U.FEFF.Year,
                                   month = soiltemp_grand$Month,
                                   day = soiltemp_grand$Day)

FullSeq <- seq.Date(from = min(soiltemp_correct$date), to = max(soiltemp_correct$date), by = 1)


Missing<-FullSeq[!FullSeq %in% soiltemp_correct$date]
Missing
# add
soiltemp_grand_from_2014 <- soiltemp_grand[(1:2294),]

grand <- data.frame(meteo_grand_from_2014$Month,
                    meteo_grand_from_2014$Day,
                    meteo_grand_from_2014$Year,
                    meteo_grand_from_2014$Avg.Temp,
                    meteo_grand_from_2014$Penman.PET,
                    meteo_grand_from_2014$Rainfall,
                    streamflow_grand_from_2014$Discharge,
                    snowdepth_grand_from_2014$X.mm..Snow.Depth..SNODAS..at..97.0668E.47.8363N..2003.10.01.to.2021.01.13,
                    soiltemp_grand_from_2014$Average.of.5.cm,
                    soiltemp_grand_from_2014$Average.of.10.cm,
                    soiltemp_grand_from_2014$Average.of.20.cm,
                    soiltemp_grand_from_2014$Average.of.30.cm,
                    soiltemp_grand_from_2014$Average.of.40.cm,
                    soiltemp_grand_from_2014$Average.of.50.cm,
                    soiltemp_grand_from_2014$Average.of.60.cm,
                    soiltemp_grand_from_2014$Average.of.80.cm,
                    soiltemp_grand_from_2014$Average.of.100.cm,
                    soiltemp_grand_from_2014$Average.of.125.cm,
                    soiltemp_grand_from_2014$Average.of.150.cm,
                    soiltemp_grand_from_2014$Average.of.175.cm,
                    soiltemp_grand_from_2014$Average.of.200.cm,
                    soiltemp_grand_from_2014$Average.of.225.cm)

colnames(grand) <- c("month","day","year","avg.temp","penman.pet","rainfall","discharge",
                     "snow.depth","soil.5","soil.10","soil.20","soil.30","soil.40","soil.50",
                     "soil.60","soil.80","soil.100","soil.125","soil.150","soil.175",
                     "soil.200","soil.225")
View(grand)

write.csv(grand, "grand_from_2014.csv")


