setwd("../../Pablo/Documents/Data")
# load packages
source("R_pakete/packages.R")

# import data
all_tripdata <- read_delim("../../../Pablo/Documents/Data/Portfolio_Projects/Google_data_analytics_case_study/data_raw/all_tripdata.csv")

# data cleaning and filtering process ----------------------------------------------------

# getting rid of stations names, ids, coordinates and NA values
all_tripdata_cleaned <- all_tripdata %>% 
  select(- c(starts_with("start_"), starts_with("end_"))) %>% 
  filter_all(all_vars(!is.na(.))) %>% 
  rename(member_type = member_casual) %>% 
  arrange(started_at) %>% 
  filter(duplicated(ride_id, fromLast = T) == F)

  
# data manipulation ----------------------------------------------------------------------
all_tripdata_final <- all_tripdata_cleaned %>% 
  mutate(
    ride_duration = difftime(ended_at, started_at, units = "secs"), 
    ride_duration_mins = round(difftime(ended_at, started_at, units = "mins"), digits = 0)
  ) %>% 
  # filtering out unplausible ride durations 
  filter(
    ride_duration_mins > 1,
    ride_duration_mins < 1440
  ) %>% 
  # adding month names column
  mutate(
    month_number = month(started_at),
    month_name = month(started_at, label = T)
  )


# saving all_tripdata_final as csv for analysis
write_csv(all_tripdata_final, "../Data/Portfolio_Projects/Google_data_analytics_case_study/final data/tripdata_final.csv")




