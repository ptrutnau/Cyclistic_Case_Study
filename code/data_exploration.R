setwd("../../Pablo/Documents/Data")
# load packages
source("R_pakete/packages.R")

# deactivate scientific notations of numbers
#options(scipen = 9999)

# read all edited excel data in a loop at once -------------------------------------------------------
directory <- "Portfolio_Projects/Google_data_analytics_case_study/data/"

files <- list.files(path = directory, pattern = ".xlsx", full.names = T)
tripdata <- lapply(files, read_excel)

tripdata_202206 <- tripdata[[1]]
tripdata_202207 <- tripdata[[2]]
tripdata_202208 <- tripdata[[3]]
tripdata_202209 <- tripdata[[4]]
tripdata_202210 <- tripdata[[5]]
tripdata_202211 <- tripdata[[6]]
tripdata_202212 <- tripdata[[7]]
tripdata_202301 <- tripdata[[8]]
tripdata_202302 <- tripdata[[9]]
tripdata_202303 <- tripdata[[10]]
tripdata_202304 <- tripdata[[11]]
tripdata_202305 <- tripdata[[12]]
tripdata_202306 <- tripdata[[13]]

# combining all dataframes into one ---------------------------------------------------------
all_tripdata <- rbind(
  tripdata_202206, 
  tripdata_202207,
  tripdata_202208,
  tripdata_202209,
  tripdata_202210,
  tripdata_202211,
  tripdata_202212,
  tripdata_202301,
  tripdata_202302,
  tripdata_202303,
  tripdata_202304,
  tripdata_202305,
  tripdata_202306
) 

# removing single dataframes
remove(
  tripdata_202206,
  tripdata_202207,
  tripdata_202208,
  tripdata_202209,
  tripdata_202210,
  tripdata_202211,
  tripdata_202212,
  tripdata_202301,
  tripdata_202302,
  tripdata_202303,
  tripdata_202304,
  tripdata_202305,
  tripdata_202306
)

# get datatype of columns
datatype <- data.frame(
  column = colnames(all_tripdata),
  datatype = sapply(all_tripdata, function(col) class(col)[1])
)

# number of na values per column
na_values <- data.frame(
  column = colnames(all_tripdata),
  na_count = sapply(all_tripdata, function(col) sum(is.na(col)))
)

# check for duplicate rows
dup_rows <- sum(duplicated(all_tripdata, fromLast = T) == T)

# check distinct values of member column
values_member <- unique(all_tripdata$member_casual)

write_csv(all_tripdata, "../../../Pablo/Documents/Data/Portfolio_Projects/Google_data_analytics_case_study/data_raw/all_tripdata.csv")
