## This script creates a finalize plot for total visits to Delta restoration sites by "type" of visitor

## Load libraries ----
library(readr)
library(ggplot2)
library(forcats)
library(dplyr)


## Read data ----
visits_loc <- read_csv("data_clean/delta_restoration_loc_visits_2022_2023.csv")


## Adding column with total number of visitors ----
visits_totals <- visits_loc %>% 
    group_by(restore_loc) %>%
    mutate(n = sum(total_visits)) %>% 
    ungroup()


## Saving my plotting theme ----
my_theme <- theme_bw(base_size = 16) +
    theme(legend.position = "bottom",
          axis.ticks.y = element_blank())

## Plot ----
ggplot(data = visits_totals,
       aes(x = fct_reorder(restore_loc, n), y = total_visits,
           fill = visitor_type))+
    geom_col()+
    labs(x = "Restoration Location",
         y = "Number of Visits",
         fill = "Type of Visitor",
         title = "Total Number of Visits to Delta Restoration Areas by visitor type",
         subtitle = "Sum of all visits during study period")+
    coord_flip()+
    scale_y_continuous(breaks = seq(0,120, 20), expand = c(0,0))+
    my_theme


