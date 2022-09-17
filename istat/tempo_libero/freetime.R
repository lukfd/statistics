# import data.table library 
library(tidyverse)

# import data
# dal sito dell'istat: http://dati.istat.it/Index.aspx?DataSetCode=DCCV_ATTPRINC
# Dati estratti il 28 apr 2022, 02h14 UTC (GMT) da I.Stat	 http://dati.istat.it/
# dati chiamati: Attivita quotidiana
data <- read_csv("~/Development/Git/statistics/istat/tempo_libero/freetime.csv")

# data wrangling 
data <- data %>%
  rename(how = "Tipo dato", when = "Periodo temporale", sex = "SEXISTAT1", withwho = "COMPAGNIA", education = "Titolo di studio", year = "TIME", value = Value) %>%
  select (how, when, sex, withwho, education, year, value) %>%
  filter(year == 2013, education != "totale", withwho != "NRP", sex != "9") %>%
  filter(how == "tempo medio trascorso da solo o in compagnia, per tipo di persona frequentata - popolazione di 15 anni e più (durata media generica in hh.mm)") %>%
  mutate(withwho = recode(withwho, "ALO" = "Alone", 
                        "MOCOH" = "Mother",
                        "FACOH" = "Father",
                        "PACOH" = "Partner",
                        "SDCOH" = "Children",
                        "BSCOH" = "Siblings",
                        "OTHPEO" = "Friends",
                        "OTHCOH" = "Rommates",
                        "BED" = "Bed")) %>%
  mutate(education = recode(education, "laurea e post-laurea" = "university",
                            "licenza di scuola elementare, nessun titolo di studio" = "elementary",
                            "licenza di scuola media" = "middle school",
                            "diploma" = "high school")) %>%
  mutate(sex = factor(sex, labels = c("male", "female"))) %>%
  mutate(when = if_else( when == "domenica" | when == "sabato", "weekend", "weekday"))

data_female <- data %>%
  filter(sex == "female") %>%
  group_by(withwho, education) %>%
  summarise(withwho = withwho, education  = education, hours = mean(value)) %>%
  distinct()

data_male <- data %>%
  filter(sex == "male") %>%
  group_by(withwho, education) %>%
  summarise(withwho = withwho, education = education, hours = mean(value)) %>%
  distinct()

data_summarised <- data %>%
  filter(sex == "male") %>%
  group_by(withwho, education) %>%
  summarise(withwho = withwho, education = education, hours = mean(value)) %>%
  distinct()
 
# Creating ggplot
#geom_col(data_male, mapping = aes(fct_reorder(withwho, hours), hours, fill = education), position = "dodge", alpha = 0.5) +
g <- ggplot() + 
  geom_col(data_summarised, mapping = aes(fct_reorder(withwho, hours), hours, fill = education), position = "dodge") +
  ggtitle("How Italians spend their freetime") +
  ylab("Number of hours in a week") + xlab("") +
  theme_minimal() +
  coord_flip() +
  scale_fill_brewer(palette = "Spectral") +
  labs(tag = "From istat.it", ) + 
  theme(plot.tag.position = c(0.9, 0.02), plot.tag = element_text(size=10))

# Run ggplot
g
