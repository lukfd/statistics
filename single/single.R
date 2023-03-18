# Luca Comba

library(tidyverse)

# import data
# dal sito dell'istat: http://dati.istat.it/Index.aspx?lang=it&SubSessionId=29b35657-22db-4614-910e-315e563c88a8
# Dati estratti il 18 Mar 2023
data <- read_csv("./single/DCCV_AVQ_FAMIGLIE_18032023212423487.csv")

data <- data %>%
  select('Tipo dato', 'TIPO_DATO_AVQ', 'MISURA_AVQ', 'Misura', 'TIME', 'Value') %>%
  filter(MISURA_AVQ == "HSC_S") %>%
  select(-MISURA_AVQ) %>%
  rename(type = 'TIPO_DATO_AVQ', age = 'Tipo dato', value = 'Value', year = 'TIME')

# print(n = 40, unique(data[,"type"]))

data <- data %>%
  filter(type == 'SING_L45_F' | type == 'SING_L45_M')

#data <- data %>%
#  mutate(typeDescription = recode(type, SING_UNM_45 = 'unmerried',
#                       SING_SDM_45 = '',
#                       SING_MF_WI = '',
#                       SING_GE65_MF = '',
#                       SING_M_WI = '',
#                       SING_UNF_GE65 = '',
#                       SING_GE65_M = '',
#                       SING_WIM_45 = '',
#                       SING_45_64_M = '',
#                       SING_SDM_GE65 = '',
#                       SING_M_SP = '',
#                       SING_WIM_GE65 = '',
#                       SING_F_UNM = '',
#                       SING_UNF_45_64 = '',
#                       SING_SDF_45_64 = '',
#                       SING_WIF_45_64 = '',
#                       SING_L45_F = '',
#                       SING_SDF_45 = '',
#                       SING_M_UNM = '',
#                       SING_F_WI = '',
#                       SING_UNF_45 = '',
#                       SING_L45_M = '',
#                       SING_GE65_F = '',
#                       SING_45_64_MF = '',
#                       SING_WIF_45 = '',
#                       SING_UNM_GE65 = '',
#                       SING_MF_SP = '',
#                       SING_SDF_GE65 = '',
#                       SING_WIF_GE65 = '',
#                       SING_MF_UNM = '',
#                       SING_45_64_F = '',
#                       SING_F_SP = '',
#                       SING_L45_MF = '',
#                       SING_WIM_45_64 = '',
#                       SING_UNM_45_64 = '',
#                       SING_SDM_45_64 = ''))

maleData <- data %>%
  filter(type == 'SING_L45_M')

femaleData <- data %>%
  filter(type == 'SING_L45_F')

# Creating ggplot
g <- ggplot() + 
  geom_line(maleData, mapping = aes(y = value, x = year), color="steelblue") +
  geom_line(femaleData, mapping = aes(y = value, x = year), color="deeppink2") +
  expand_limits(y = 0) +
  ggtitle("Single Italians under 45") +
  ylab("percentage") + xlab("year") +
  theme_minimal() +
  labs(caption = "source istat.it", )
  
# plot
g
