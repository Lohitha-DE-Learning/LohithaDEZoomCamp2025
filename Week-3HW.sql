-- ------------- CREATE EXTERNAL TABLE -------------
-- External Table Setup: This table reads the data directly from GCS in Parquet format.
CREATE EXTERNAL TABLE `dtc-de-zoomcamp-lv.yellow_taxi_data.yellow_taxi_trips_external`
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://dezoomcamp_hw3_2025_lv/yellow_tripdata_2024-*.parquet']
);

-- ------------- CREATE MATERIALIZED TABLE -------------
-- Materialized Table Setup: Create a materialized table from the external table for better performance.
CREATE TABLE `dtc-de-zoomcamp-lv.yellow_taxi_data.yellow_taxi_trips_materialized`
AS
SELECT * 
FROM `dtc-de-zoomcamp-lv.yellow_taxi_data.yellow_taxi_trips_external`;

-- Question 1:
-- Query to count the total number of records in the External Table.
SELECT COUNT(*) AS total_records
FROM `dtc-de-zoomcamp-lv.yellow_taxi_data.yellow_taxi_trips_external`;

-- Query to count the total number of records in the Materialized Table.
SELECT COUNT(*) AS total_records
FROM `dtc-de-zoomcamp-lv.yellow_taxi_data.yellow_taxi_trips_materialized`;

-- Question 2:
-- Query to count the distinct number of PULocationIDs for the entire dataset on the External Table.
SELECT COUNT(DISTINCT PULocationID) AS distinct_pulocationid_external
FROM `dtc-de-zoomcamp-lv.yellow_taxi_data.yellow_taxi_trips_external`;

-- Query to count the distinct number of PULocationIDs for the entire dataset on the Materialized Table.
SELECT COUNT(DISTINCT PULocationID) AS distinct_pulocationid_materialized
FROM `dtc-de-zoomcamp-lv.yellow_taxi_data.yellow_taxi_trips_materialized`;

-- Question 3:
-- Query to retrieve the PULocationID from the materialized table.
SELECT PULocationID
FROM `dtc-de-zoomcamp-lv.yellow_taxi_data.yellow_taxi_trips_materialized`;

-- Query to retrieve the PULocationID and DOLocationID from the materialized table.
SELECT PULocationID, DOLocationID
FROM `dtc-de-zoomcamp-lv.yellow_taxi_data.yellow_taxi_trips_materialized`;

-- Question 4:
-- Query to count how many records have a fare_amount of 0.
SELECT COUNT(*) AS zero_fare_count
FROM `dtc-de-zoomcamp-lv.yellow_taxi_data.yellow_taxi_trips_materialized`
WHERE fare_amount = 0;

-- Question 5:
-- Creating an optimized table partitioned by tpep_dropoff_datetime and clustered by VendorID.
CREATE TABLE `dtc-de-zoomcamp-lv.yellow_taxi_data.yellow_taxi_trips_optimized`
PARTITION BY DATE(tpep_dropoff_datetime)  -- Partition by date part of tpep_dropoff_datetime
CLUSTER BY VendorID  -- Cluster by VendorID for optimized queries filtering by VendorID
AS
SELECT *
FROM `dtc-de-zoomcamp-lv.yellow_taxi_data.yellow_taxi_trips_materialized`;

-- Question 6:
-- Query to retrieve the distinct VendorIDs between tpep_dropoff_datetime 2024-03-01 and 2024-03-15.
-- First using the materialized table:
SELECT DISTINCT VendorID
FROM `dtc-de-zoomcamp-lv.yellow_taxi_data.yellow_taxi_trips_materialized`
WHERE tpep_dropoff_datetime BETWEEN '2024-03-01' AND '2024-03-15';

-- Now using the partitioned and clustered table created in Question 5:
SELECT DISTINCT VendorID
FROM `dtc-de-zoomcamp-lv.yellow_taxi_data.yellow_taxi_trips_optimized`
WHERE tpep_dropoff_datetime BETWEEN '2024-03-01' AND '2024-03-15';

