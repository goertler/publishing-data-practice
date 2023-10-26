## Exploring data to record metadata ----

## Load libraries ----
library(readr)
library(dplyr)

## Read data ----
socioecol <- read_csv("data_raw/socioecological_monitoring_data_2022_2023.csv")

glimpse(socioecol)

## Check for date range ----
socioecol %>% 
    mutate(Date = as.Date(Date, format = "%m/%d/%y")) %>% 
    select(Date) %>%
    distinct() %>% 
    arrange()

## Locations with lat long coords ----
locations <- visits_long %>%
    distinct(restore_loc, .keep_all = T) %>%
    select(restore_loc, latitude, longitude)


## Checking for missing values ----
## Note: If outcome is integer(0) it means there are no NAs
which(is.na(socioecol$EcoRestore_approximate_location))
sort(unique(socioecol$EcoRestore_approximate_location), na.last = T)

which(is.na(socioecol$Reach))
sort(unique(socioecol$Reach), na.last = T)

which(is.na(socioecol$Latitude))
sort(unique(socioecol$Latitude), na.last = T)


which(is.na(socioecol$Longitude))
sort(unique(socioecol$Longitude), na.last = T)

which(is.na(socioecol$Date))
unique(socioecol$Date)

unique(socioecol$Time_of_Day)
which(is.na(socioecol$Time_of_Day))


which(is.na(socioecol$sm_boat))
unique(socioecol$sm_boat)

which(is.na(socioecol$med_boat))
unique(socioecol$med_boat)


which(is.na(socioecol$lrg_boat))
unique(socioecol$lrg_boat)


which(is.na(socioecol$bank_angler))
unique(socioecol$bank_angler)


which(is.na(socioecol$scientist))
unique(socioecol$scientist)

which(is.na(socioecol$cars))
unique(socioecol$cars)

which(is.na(socioecol$notes))
unique(socioecol$notes)
