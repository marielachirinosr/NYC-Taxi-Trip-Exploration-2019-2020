-- 2019
-- Create or replace a table within the previously created schema.
-- The table will contain calculated data based on existing processed taxi data from 2019.
-- The calculations include trip duration, speed, day of the week, and time of day.
CREATE OR REPLACE TABLE `taxi-driver-projects.taxi_data_2019_calculated.taxi_data_2019_calculated`
AS
-- Selecting data from the existing processed taxi data from 2019 and performing calculations.
SELECT *,
  -- Calculate trip duration in HH:MM:SS format
  FORMAT_TIMESTAMP('%H:%M:%S', TIMESTAMP_SECONDS(TIMESTAMP_DIFF(tpep_dropoff_datetime, tpep_pickup_datetime, SECOND))) AS duration_trip_time,
  
  -- Calculate speed in miles per hour
  IF(
    UNIX_SECONDS(tpep_dropoff_datetime) - UNIX_SECONDS(tpep_pickup_datetime) > 0,
    trip_distance / (UNIX_SECONDS(tpep_dropoff_datetime) - UNIX_SECONDS(tpep_pickup_datetime)) * 3600,
    NULL
  ) AS speed_mph,
  
  -- Extract day of the week (number)
  EXTRACT(DAYOFWEEK FROM tpep_pickup_datetime) AS day_of_week_number,
  
  -- Extract day of the week (letters)
  FORMAT_DATE('%A', DATE(tpep_pickup_datetime)) AS day_of_week_letters,
  
  -- Determine time of day (Morning, Afternoon, Evening, Night)
  CASE
    WHEN EXTRACT(HOUR FROM tpep_pickup_datetime) BETWEEN 0 AND 5 THEN 'Night'
    WHEN EXTRACT(HOUR FROM tpep_pickup_datetime) BETWEEN 6 AND 11 THEN 'Morning'
    WHEN EXTRACT(HOUR FROM tpep_pickup_datetime) BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening'
  END AS time_of_day
FROM
  `taxi-driver-projects.taxi_data_2019_processed.taxi_data_2019_processed`;


-- 2020
-- Create or replace a table within the previously created schema.
-- The table will contain calculated data based on existing processed taxi data from 2020.
-- The calculations include trip duration, speed, day of the week, and time of day.
CREATE OR REPLACE TABLE `taxi-driver-projects.taxi_data_2020_calculated.q1_taxi_data_2020_calculated`
AS
-- Selecting data from the existing processed taxi data from 2020 and performing calculations.
SELECT *,
  -- Calculate trip duration in HH:MM:SS format
  FORMAT_TIMESTAMP('%H:%M:%S', TIMESTAMP_SECONDS(TIMESTAMP_DIFF(tpep_dropoff_datetime, tpep_pickup_datetime, SECOND))) AS duration_trip_time,
  
  -- Calculate speed in miles per hour
  IF(
    UNIX_SECONDS(tpep_dropoff_datetime) - UNIX_SECONDS(tpep_pickup_datetime) > 0,
    trip_distance / (UNIX_SECONDS(tpep_dropoff_datetime) - UNIX_SECONDS(tpep_pickup_datetime)) * 3600,
    NULL
  ) AS speed_mph,
  
  -- Extract day of the week (number)
  EXTRACT(DAYOFWEEK FROM tpep_pickup_datetime) AS day_of_week_number,
  
  -- Extract day of the week (letters)
  FORMAT_DATE('%A', DATE(tpep_pickup_datetime)) AS day_of_week_letters,
  
  -- Determine time of day (Morning, Afternoon, Evening, Night)
  CASE
    WHEN EXTRACT(HOUR FROM tpep_pickup_datetime) BETWEEN 0 AND 5 THEN 'Night'
    WHEN EXTRACT(HOUR FROM tpep_pickup_datetime) BETWEEN 6 AND 11 THEN 'Morning'
    WHEN EXTRACT(HOUR FROM tpep_pickup_datetime) BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening'
  END AS time_of_day
FROM
  `taxi-driver-projects.taxi_data_2020_processed.taxi_data_2020_processed`;