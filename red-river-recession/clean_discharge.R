### Luca
### Updating grand and fargo for substituting empty or "ICE" present in discharge.

fargo_complete<- read.csv("C:/Users/Luca/Desktop/SPRING2021/Statistical Research/Combined data/fargo_complete.csv", encoding="UTF-8", na.strings=c("","NA"))
grand_complete <- read.csv("C:/Users/Luca/Desktop/SPRING2021/Statistical Research/Combined data/grand_complete.csv", encoding="UTF-8", na.strings=c("","NA"))

# counting NA
sum(is.na(grand_complete$discharge))
sum(is.na(fargo_complete$discharge))

# subsitute string "Ice" with value of 0
grand_complete$discharge <- gsub('Ice', 0, grand_complete$discharge)
fargo_complete$discharge <- gsub('Ice', 0, fargo_complete$discharge)

# make discharge as numeric
grand_complete$discharge<-as.numeric(grand_complete$discharge)
fargo_complete$discharge<-as.numeric(fargo_complete$discharge)

# substitute NAs with Time series values
### Using package imputeTS
library(imputeTS)

grand_discharge_ts <- ts(grand_complete$discharge)
grand_discharge_no_na <- na_seadec(grand_discharge_ts)
ggplot_na_distribution(grand_discharge_ts)
grand_discharge_new <- data.frame(grand_discharge_no_na)
grand_complete$discharge <- grand_discharge_new$grand_discharge_no_na

fargo_discharge_ts <- ts(fargo_complete$discharge)
fargo_discharge_no_na <- na_seadec(fargo_discharge_ts)
ggplot_na_distribution(fargo_discharge_ts)
fargo_discharge_new <- data.frame(fargo_discharge_no_na)
fargo_complete$discharge <- fargo_discharge_new$fargo_discharge_no_na

sum(is.na(grand_complete$discharge))
sum(is.na(fargo_complete$discharge))

# saving the file
write.csv(grand_complete, "C:/Users/Luca/Desktop/SPRING2021/Statistical Research/Combined data/grand_correct_discharge.csv")
write.csv(fargo_complete, "C:/Users/Luca/Desktop/SPRING2021/Statistical Research/Combined data/fargo_correct_discharge.csv")