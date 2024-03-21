-- 2019
-- Create or replace a table within the previously created schema.
-- The table will contain extended data including pickup and dropoff zones for taxi data from 2019.
CREATE OR REPLACE TABLE `taxi-driver-projects.taxi_data_2019_extended.taxi_data_2019_extended` AS (
  SELECT
    a.*,
    b.Borough AS PUBorough,
    b.Zone AS PUZone,
    b.service_zone AS PUServiceZone,
    c.Borough AS DOBorough,
    c.Zone AS DOZone,
    c.service_zone AS DOServiceZone,
    EXTRACT(YEAR FROM tpep_pickup_datetime) AS pickup_year,
    EXTRACT(MONTH FROM tpep_pickup_datetime) AS pickup_month
  FROM
    `taxi-driver-projects.taxi_data_2019_calculated.taxi_data_2019_calculated` a
  LEFT JOIN
    `taxi-driver-projects.taxi_zone.taxi_zone` b
  ON
    a.PULocationID = b.LocationID
  LEFT JOIN
    `taxi-driver-projects.taxi_zone.taxi_zone` c
  ON
    a.DOLocationID = c.LocationID
);


-- 2020
-- Create or replace a table within the previously created schema.
-- The table will contain extended data including pickup and dropoff zones for taxi data from 2020.
CREATE OR REPLACE TABLE `taxi-driver-projects.taxi_data_2020_extended.q1_taxi_data_2020_extended` AS (
  SELECT
    a.*,
    b.Borough AS PUBorough,
    b.Zone AS PUZone,
    b.service_zone AS PUServiceZone,
    c.Borough AS DOBorough,
    c.Zone AS DOZone,
    c.service_zone AS DOServiceZone,
    EXTRACT(YEAR FROM tpep_pickup_datetime) AS pickup_year,
    EXTRACT(MONTH FROM tpep_pickup_datetime) AS pickup_month
  FROM
    `taxi-driver-projects.taxi_data_2020_calculated.q1_taxi_data_2020_calculated` a
  LEFT JOIN
    `taxi-driver-projects.taxi_zone.taxi_zone` b
  ON
    a.PULocationID = b.LocationID
  LEFT JOIN
    `taxi-driver-projects.taxi_zone.taxi_zone` c
  ON
    a.DOLocationID = c.LocationID
);