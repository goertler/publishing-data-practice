## This Scripts cleans Socioecological Monitor Data ----

## Data provenance: Kraus-Polk, A. and B. Milligan. 2020. Sacramento-San Joaquin Delta Socioecological Monitoring ver 1. Environmental Data Initiative. https://doi.org/10.6073/pasta/e5bba3945d7f94c3005a7f8c38d00802 



## This data was collected between July 2022 to March 2023

## Load libraries ----
library(dplyr)
library(tidyr)
library(readr)
library(janitor)


## Read data ----
## update to url once data is submitted to a repository
delta_visits <- read_csv("data_raw/socioecological_monitoring_data_2022_2023.csv") %>% 
    janitor::clean_names() 


## Check anc Explore ----

## Check out column names
colnames(delta_visits)

## Peak at each column and class
glimpse(delta_visits)

## class of column data
class(delta_visits$date)

## First and last rows
head(delta_visits)
tail(delta_visits)

## Which time of day?
unique(delta_visits$time_of_day)


## From wide to long ----

visits_long <- delta_visits %>% 
    pivot_longer(cols = c("sm_boat", "med_boat", "lrg_boat", "bank_angler", "scientist", "cars"),
                 names_to = "visitor_type",
                 values_to = "quantity") %>%
    rename(restore_loc = eco_restore_approximate_location) %>% 
    mutate(date = as.Date(date, format = "%m/%d/%y")) %>% 
    select(-notes)

## Checking the outcome
head(visits_long)

## From when to when
range(visits_long$date)


## Calculating daily visits by restoration location ----

visits_location <- visits_long %>%
    group_by(restore_loc, visitor_type) %>% 
    summarise(total_visits = sum(quantity))

head(visits_location)



## Saving clean data ----

write_csv(visits_location, "data_clean/delta_restoration_loc_visits_2022_2023.csv")
