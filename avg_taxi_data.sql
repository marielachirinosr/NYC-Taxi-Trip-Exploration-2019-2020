-- 2019 
-- Create or replace a table within the previously created schema.
-- The table will contain average data for taxi trips from 2019.
CREATE OR REPLACE TABLE `taxi-driver-projects.taxi_data_2019_avgs.taxi_data_2019_avgs`
AS
SELECT
  EXTRACT(YEAR FROM tpep_pickup_datetime) AS pickup_year,
  EXTRACT(MONTH FROM tpep_pickup_datetime) AS pickup_month,
  EXTRACT(DAYOFWEEK FROM tpep_pickup_datetime) AS day_of_week,
  COUNT(*) AS trip_count,
  AVG(fare_amount) AS avg_fare_amount,
  AVG(tip_amount) AS avg_tip_amount,
  time_of_day
FROM
  `taxi-driver-projects.taxi_data_2019_extended.taxi_data_2019_extended`
WHERE
  EXTRACT(MONTH FROM tpep_pickup_datetime) IN (1, 2, 3)
GROUP BY
  pickup_year, pickup_month, day_of_week, time_of_day;


-- 2020
-- Create or replace a table within the previously created schema.
-- The table will contain average data for taxi trips from the first quarter (Q1) of 2020.
CREATE OR REPLACE TABLE `taxi-driver-projects.taxi_data_2020_avgs.q1_taxi_data_2020_avgs`
AS
SELECT
  EXTRACT(YEAR FROM tpep_pickup_datetime) AS pickup_year,
  EXTRACT(MONTH FROM tpep_pickup_datetime) AS pickup_month,
  EXTRACT(DAYOFWEEK FROM tpep_pickup_datetime) AS day_of_week,
  COUNT(*) AS trip_count,
  AVG(fare_amount) AS avg_fare_amount,
  AVG(tip_amount) AS avg_tip_amount,
  time_of_day
FROM
  `taxi-driver-projects.taxi_data_2020_extended.q1_taxi_data_2020_extended`
WHERE
  EXTRACT(MONTH FROM tpep_pickup_datetime) IN (1, 2, 3)
GROUP BY
  pickup_year, pickup_month, day_of_week, time_of_day;