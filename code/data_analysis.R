setwd("../../Pablo/Documents/Data")
# load packages
source("R_pakete/packages.R")
# deactivate scientific notations of numbers
options(scipen = 9999)
# add font
font_add_google(name = "Montserrat")
showtext_auto()


tripdata_final <- read_delim("Portfolio_Projects/Google_data_analytics_case_study/final data/tripdata_final.csv", delim = ",")


# Comparing statistics between casual and members -------------------------------------------------------

# distribution between members and casual drivers ----------------------------
distribution <- tripdata_final %>% 
  select(ride_id, member_type) %>% 
  group_by(member_type) %>% 
  summarise(total_count = n()) %>% 
  ungroup()

distribution1 <- distribution %>% 
  group_by(member_type) %>% 
  summarise(percentage = round((sum(total_count) / sum(distribution$total_count) * 100), digits = 2)) %>% 
  mutate(percentage = paste(percentage, "%", sep = " "))


plot_distribution <- distribution1 %>% 
  ggplot(aes(x = member_type, y = percentage, group = member_type, fill = member_type)) +
  geom_bar(stat = "identity") + geom_text(aes(label = percentage, vjust = -0.3)) + theme_bw() +
  theme(
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank(),
    text = element_text(family = "Montserrat"),
    legend.title = element_text(face = "bold"),
    legend.justification = "top",
    legend.background = element_blank()
  ) +
  labs(
    color = "Member Type",
    title = "Distribution of Member Types",
    subtitle = "",
    x = "Member Type",
    y = "Percentage"
  )

plot_distribution

# amount of total rides -------------------------------------------------------

# rides per month --------
rides_per_month <- tripdata_final %>% 
  select(ride_id, member_type, month_name, month_number) %>% 
  group_by(month_name, month_number, member_type) %>% 
  summarise(total_rides = n()) %>% 
  ungroup() %>% 
  arrange(month_number) %>% 
  select(- month_number)

level_order_months <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
# plot
plot_rides_per_month <- rides_per_month %>% 
  ggplot(aes(x = month_name, y = total_rides, group = member_type, colour = member_type)) + 
  geom_line(size = 1.3) + scale_x_discrete(limits = level_order_months) +
  theme_bw() + scale_y_continuous(labels = scales::comma_format(scale = 1e-3)) +
  theme(
    text = element_text(family = "Montserrat"),
    legend.title = element_text(face = "bold"),
    legend.justification = "top",
    legend.background = element_blank()
  ) +
  labs(
    color = "Member Type",
    title = "Total Trips",
    subtitle = "Per Month and Member Types",
    x = "Months",
    y = "Trips in thousands"
  )

plot_rides_per_month

# rides per weekdays --------
rides_per_weekday <- tripdata_final %>% 
  select(ride_id, day_of_week, member_type) %>% 
  group_by(day_of_week, member_type) %>% 
  summarise(total_rides = n()) %>% 
  ungroup()

level_order_days <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday")

#plot
plot_rides_per_weekdays <- rides_per_weekday %>% 
  ggplot(aes(x = day_of_week, y = total_rides, group = member_type, colour = member_type)) + 
  geom_line(size = 1.3) + scale_x_discrete(limits = level_order_days) +
  theme_bw() + scale_y_continuous(labels = scales::comma_format(scale = 1e-3)) +
  theme(
    text = element_text(family = "Montserrat"),
    legend.title = element_text(face = "bold"),
    legend.justification = "top",
    legend.background = element_blank()
  ) +
  labs(
    color = "Member Type",
    title = "Total Trips",
    subtitle = "Per Weekday and Member Types",
    x = "Day",
    y = "Trips in thousands"
  )

plot_rides_per_weekdays

# rides per hour ---------
rides_per_hour <- tripdata_final %>% 
  select(ride_id, started_at, member_type) %>% 
  mutate(
    hour_of_day = hour(started_at)
  ) %>% 
  group_by(hour_of_day, member_type) %>% 
  summarise(total_rides = n()) %>% 
  ungroup()


# plot
plot_ride_per_hour <- rides_per_hour %>% 
  ggplot(aes(x = hour_of_day, y = total_rides, group = member_type, colour = member_type)) + 
  geom_line(size = 1.3) + theme_bw() + scale_y_continuous(labels = scales::comma_format(scale = 1e-3)) +
  theme(
    text = element_text(family = "Montserrat"),
    legend.title = element_text(face = "bold"),
    legend.justification = "top",
    legend.background = element_blank()
  ) +
  labs(
    color = "Member Type",
    title = "Total Trips",
    subtitle = "Per Hour of Day and Member Types",
    x = "Hour of Day",
    y = "Trips in thousands"
  )
plot_ride_per_hour

# average ride durations --------------------------------------------------------------

# ride duration month ----------------------------
ride_duration_month <- tripdata_final %>% 
  select(ride_id, month_name, ride_duration_mins, member_type) %>% 
  group_by(month_name, member_type) %>% 
  summarise(
    average_duration = round(mean(ride_duration_mins), digits = 0)
    ) %>% 
  ungroup()

# plot
plot_duration_month <- ride_duration_month %>% 
  ggplot(aes(x = month_name, y = average_duration, group = member_type, colour = member_type)) + 
  geom_line(size = 1.3) + scale_x_discrete(limits = level_order_months) +
  theme_bw() + 
  theme(
    text = element_text(family = "Montserrat"),
    legend.title = element_text(face = "bold"),
    legend.justification = "top",
    legend.background = element_blank()
  ) +
  labs(
    color = "Member Type",
    title = "Average Ride Duration",
    subtitle = "Per Month and Member Types",
    x = "Months",
    y = "Average Duration(mins)"
  )

plot_duration_month

# ride duration weekdays -------------------
ride_duration_weekdays <- tripdata_final %>% 
  select(ride_id, day_of_week, ride_duration_mins, member_type) %>% 
  group_by(day_of_week, member_type) %>% 
  summarise(
    average_duration = round(mean(ride_duration_mins), digits = 0)
  ) %>% 
  ungroup()

# plot
plot_duration_weekdays <- ride_duration_weekdays %>% 
  ggplot(aes(x = day_of_week, y = average_duration, group = member_type, colour = member_type)) + 
  geom_line(size = 1.3) + scale_x_discrete(limits = level_order_days) +
  theme_bw() + 
  theme(
    text = element_text(family = "Montserrat"),
    legend.title = element_text(face = "bold"),
    legend.justification = "top",
    legend.background = element_blank()
  ) +
  labs(
    color = "Member Type",
    title = "Average Ride Duration",
    subtitle = "Per Weekday",
    x = "Weekday",
    y = "Average Duration(mins)"
  )

plot_duration_weekdays

# ride duration per hour ------------
ride_duration_per_hour <- tripdata_final %>% 
  select(ride_id, started_at, ride_duration_mins, member_type) %>% 
  mutate(
    hour_of_day = hour(started_at)
  ) %>% 
  group_by(hour_of_day, member_type) %>% 
  summarise(
    average_duration = round(mean(ride_duration_mins), digits = 0)
  ) %>% 
  ungroup()

# plot
plot_duration_per_hour <- ride_duration_per_hour %>% 
  ggplot(aes(x = hour_of_day, y = average_duration, group = member_type, colour = member_type)) + 
  geom_line(size = 1.3) + theme_bw() + 
  theme(
    text = element_text(family = "Montserrat"),
    legend.title = element_text(face = "bold"),
    legend.justification = "top",
    legend.background = element_blank()
  ) +
  labs(
    color = "Member Type",
    title = "Average Ride Duration",
    subtitle = "Per Hour of Day and Member Types",
    x = "Hour of Day",
    y = "Average Duration(mins)"
  )

plot_duration_per_hour  

# saving plots ----------------------------------------------------------------------------------
#ggsave(filename = "Portfolio_Projects/Google_data_analytics_case_study/plots/distribution_members.png", plot = plot_distribution)
#ggsave(filename = "Portfolio_Projects/Google_data_analytics_case_study/plots/total_rides_per_month.png", plot = plot_rides_per_month)
#ggsave(filename = "Portfolio_Projects/Google_data_analytics_case_study/plots/total_rides_per_hour.png", plot = plot_ride_per_hour)
#ggsave(filename = "Portfolio_Projects/Google_data_analytics_case_study/plots/total_rides_per_weekday.png", plot = plot_rides_per_weekdays)
#ggsave(filename = "Portfolio_Projects/Google_data_analytics_case_study/plots/ride_duration_month.png", plot = plot_duration_month)
#ggsave(filename = "Portfolio_Projects/Google_data_analytics_case_study/plots/ride_duration_per_hour.png", plot = plot_duration_per_hour)
#ggsave(filename = "Portfolio_Projects/Google_data_analytics_case_study/plots/ride_duration_weekdays.png.png", plot = plot_duration_weekdays)
