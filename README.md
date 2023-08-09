# Google Data Analytics Capstone: Cyclistic Case Study
On this Repository, i will perform the [Google Data Analytics Capstone Project](https://www.coursera.org/learn/google-data-analytics-capstone) (a case study from the Google Data Analytics course).

## Introduction
In this case study, i will perform tasks of a junior data analyst for a fictional company named Cyclistic.

## Summary (links)
Data Source: [here](https://divvy-tripdata.s3.amazonaws.com/index.html)

Code:


## Cyclistic
Cyclistic is a bike-sharing company, which features more that 5800 bikes in 600 different stations across Chicago.
The bikes can be unlocked from one station and returned to any other station in the system anytime.
Something innovative about this company, is the offer of reclining bikes, hand tricycles and cargo bikes, making bike-share more
inclusive to people with disabilities. The majority of riders opt for traditional bikes; about 8% of riders use the assistive options. 
Cyclistic users are more likely to ride for leisure, but about 30% use them to commute to work each day.

Until now, Cyclistic’s marketing strategy relied on building general awareness and appealing to broad consumer segments.
One approach that helped make these things possible was the flexibility of its pricing plans: single-ride passes, full-day passes,
and annual memberships. Customers who purchase single-ride or full-day passes are referred to as casual riders. Customers
who purchase annual memberships are Cyclistic members.

Cyclistic’s finance analysts have concluded that annual members are much more profitable than casual riders. Although the
pricing flexibility helps Cyclistic attract more customers, they believe that maximizing the number of annual members will
be key to future growth. Rather than creating a marketing campaign that targets all-new customers, Moreno believes there is a
very good chance to convert casual riders into members. She notes that casual riders are already aware of the Cyclistic
program and have chosen Cyclistic for their mobility needs.

So the goal is clear: Design marketing strategies aimed at converting casual riders into annual members.

## Task and Scenario
So working as a junior data analyst for the marketing analytics team, my task is to understand how casual riders and annual members
use Cyclistic bikes differently. After evaluating the data, the team will make recommendations on how to convert casual riders into annual members.

## Data Source
I will use Cyclistic’s historical trip data to analyze and identify trends from jun 2022 to june 2023. So there is a csv file for every month in this period. The data can be downloaded [here](https://divvy-tripdata.s3.amazonaws.com/index.html)

This is public data that can be used to explore how different customer types are using Cyclistic bikes. But note that data-privacy issues prohibit from using riders’ personally identifiable information. This means that we won’t be able to connect pass purchases to credit card numbers to determine if casual riders live in the Cyclistic service area or if they have purchased multiple single passes.

## Description of Data
There are 12 files with naming convention of "YYYYMM-divvy-tripdata". As i mentioned before, each file includes information for one month.
These are the following columns which are alway the same for each file: ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat,end_lng and member_casual

# Process

NOTE: It was not possible to import the whole combined data into excel because it was too big. So in excel before the exploration process, i added the column "day_of_week" in each of the 12 files.
This column will be important later for my analysis

## Data Exploration
Before cleaning the data, i am checking out the data to see if i find any inconsistencies. For the Data exploration Process i used R.
Code is available HERE

### Observations

1. The table shows the datatype of all columns of the dataframe
   ![Image](images/datatype.png)

2. Number of NA Values per column
   ![image](images/NA_values.png)

3. There are no duplicate rows in the data.
4. Two unique values in the member_casual column. The only possible values for this column are "casual" and "member"
5. Columns of stations names and coordinates will be removed because they wont be relevant for the analysis.

## Data Cleaning and Data Manipulation
Code of the cleaning and manipulation process is HERE   

### Process
1. Removed following columns which are nor relevant for analysis: start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng
2. Renamed member_casual column to member_type which seemed more appropiate
3. Added column ride_duration and ride_duration_mins which is the time difference between ended_at and started_at
4. Filtered unplausible ride durations(everything longer than a day and less than a minute)
5. Removed 220.218 rows

## Data Analysis
Code of the analyzing process is HERE

Analyzing question: How do annual members and casual riders use Cyclistic bikes differently?



