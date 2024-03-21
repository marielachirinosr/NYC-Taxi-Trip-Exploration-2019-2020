-- 2019
-- Create or replace a table within the previously created schema.
-- The table will contain processed taxi data from 2019.
-- The data is filtered based on various conditions to ensure data integrity.
CREATE OR REPLACE TABLE `taxi-driver-projects.taxi_data_2019_processed.taxi_data_2019_processed`
AS
-- The following Common Table Expression combines data from multiple monthly tables into one.
WITH Q1_taxi_data_2019 AS (
  SELECT * FROM `taxi-driver-projects.taxi_data_2019.taxi_data_2019_01`
  UNION ALL
  SELECT * FROM `taxi-driver-projects.taxi_data_2019.taxi_data_2019_02`
  UNION ALL
  SELECT * FROM `taxi-driver-projects.taxi_data_2019.taxi_data_2019_03`
)
-- Select distinct records from the combined data satisfying specified conditions.
SELECT DISTINCT * FROM Q1_taxi_data_2019
WHERE
  -- Filters records for the year 2019.
  EXTRACT(YEAR FROM tpep_pickup_datetime) = 2019
  -- Filters out records with missing or invalid values for various columns.
  AND VendorID IS NOT NULL 
  AND tpep_pickup_datetime IS NOT NULL 
  AND tpep_dropoff_datetime IS NOT NULL 
  AND passenger_count IS NOT NULL AND passenger_count BETWEEN 1 AND 5 
  AND trip_distance IS NOT NULL AND trip_distance > 0.1 
  AND RatecodeID IS NOT NULL 
  AND store_and_fwd_flag IS NOT NULL 
  AND PULocationID IS NOT NULL AND PULocationID NOT IN (264, 265) 
  AND DOLocationID IS NOT NULL AND DOLocationID NOT IN (264, 265) 
  AND payment_type IS NOT NULL 
  AND fare_amount IS NOT NULL 
  AND extra IS NOT NULL 
  AND mta_tax IS NOT NULL 
  AND tip_amount IS NOT NULL 
  AND tolls_amount IS NOT NULL 
  AND improvement_surcharge IS NOT NULL 
  AND total_amount IS NOT NULL 
  AND congestion_surcharge IS NOT NULL
-- Limits the number of records to 120,000.
LIMIT 120000;


-- 2020
-- Create or replace a table within the previously created schema.
-- The table will contain processed taxi data from 2020.
-- The data is filtered based on various conditions to ensure data integrity.
CREATE OR REPLACE TABLE `taxi-driver-projects.taxi_data_2020_processed.taxi_data_2020_processed`
AS
-- The following Common Table Expression (CTE) combines data from multiple monthly tables into one.
WITH Q1_taxi_data_2020 AS (
  SELECT * FROM `taxi-driver-projects.taxi_data_2020.taxi_data_2020_01`
  UNION ALL
  SELECT * FROM `taxi-driver-projects.taxi_data_2020.taxi_data_2020_02`
  UNION ALL
  SELECT * FROM `taxi-driver-projects.taxi_data_2020.taxi_data_2020_03`
)
-- Select distinct records from the combined data satisfying specified conditions.
SELECT DISTINCT * FROM Q1_taxi_data_2020
WHERE
  -- Filters records for the year 2020.
  EXTRACT(YEAR FROM tpep_pickup_datetime) = 2020
  -- Filters out records with missing or invalid values for various columns.
  AND VendorID IS NOT NULL 
  AND tpep_pickup_datetime IS NOT NULL 
  AND tpep_dropoff_datetime IS NOT NULL 
  AND passenger_count IS NOT NULL AND passenger_count BETWEEN 1 AND 5 
  AND trip_distance IS NOT NULL AND trip_distance > 0.1 
  AND RatecodeID IS NOT NULL 
  AND store_and_fwd_flag IS NOT NULL 
  AND PULocationID IS NOT NULL AND PULocationID NOT IN (264, 265) 
  AND DOLocationID IS NOT NULL AND DOLocationID NOT IN (264, 265) 
  AND payment_type IS NOT NULL 
  AND fare_amount IS NOT NULL 
  AND extra IS NOT NULL 
  AND mta_tax IS NOT NULL 
  AND tip_amount IS NOT NULL 
  AND tolls_amount IS NOT NULL 
  AND improvement_surcharge IS NOT NULL 
  AND total_amount IS NOT NULL 
  AND congestion_surcharge IS NOT NULL
-- Limits the number of records to 120,000.
LIMIT 120000;