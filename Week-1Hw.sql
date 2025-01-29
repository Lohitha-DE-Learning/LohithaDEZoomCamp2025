DROP TABLE IF EXISTS green_taxi_trips;

CREATE TABLE green_taxi_trips (
    VendorID INT,
    lpep_pickup_datetime TIMESTAMP,
    lpep_dropoff_datetime TIMESTAMP,
    store_and_fwd_flag VARCHAR(1),
    RatecodeID INT,
    PULocationID INT,
    DOLocationID INT,
    passenger_count INT,
    trip_distance NUMERIC,
    fare_amount NUMERIC,
    extra NUMERIC,
    mta_tax NUMERIC,
    tip_amount NUMERIC,
    tolls_amount NUMERIC,
    ehail_fee NUMERIC, 
    improvement_surcharge NUMERIC,
    total_amount NUMERIC,
    payment_type INT,
    trip_type INT,
    congestion_surcharge NUMERIC
);

CREATE TABLE taxi_zones (
    location_id INT PRIMARY KEY,
    borough VARCHAR(100),
    zone VARCHAR(100),
    service_zone VARCHAR(100)
);


COPY green_taxi_trips FROM '/tmp/green_tripdata_2019-10.csv' DELIMITER ',' CSV HEADER;

COPY taxi_zones FROM '/tmp/taxi_zone_lookup.csv' DELIMITER ',' CSV HEADER;

SELECT * FROM green_taxi_trips LIMIT 10;

SELECT * FROM taxi_zones LIMIT 10;

-- Question 3. Trip Segmentation Count

SELECT *
FROM green_taxi_trips
WHERE DATE(lpep_pickup_datetime) <> DATE(lpep_dropoff_datetime);

SELECT
    SUM(CASE WHEN trip_distance <= 1 THEN 1 ELSE 0 END) AS up_to_1_mile,
    SUM(CASE WHEN trip_distance > 1 AND trip_distance <= 3 THEN 1 ELSE 0 END) AS between_1_and_3_miles,
    SUM(CASE WHEN trip_distance > 3 AND trip_distance <= 7 THEN 1 ELSE 0 END) AS between_3_and_7_miles,
    SUM(CASE WHEN trip_distance > 7 AND trip_distance <= 10 THEN 1 ELSE 0 END) AS between_7_and_10_miles,
    SUM(CASE WHEN trip_distance > 10 THEN 1 ELSE 0 END) AS over_10_miles
FROM
    green_taxi_trips
WHERE
    lpep_pickup_datetime >= '2019-10-01' AND
    lpep_pickup_datetime < '2019-11-01' AND
    lpep_dropoff_datetime >= '2019-10-01' AND
    lpep_dropoff_datetime < '2019-11-01';

--Question 4. Longest trip for each day

WITH longest_trips AS (
    SELECT
        DATE(lpep_pickup_datetime) AS pickup_date,
        MAX(trip_distance) AS longest_distance
    FROM
        green_taxi_trips
    GROUP BY
        DATE(lpep_pickup_datetime)
)
SELECT
    pickup_date
FROM
    longest_trips
ORDER BY
    longest_distance DESC
LIMIT 1;


--Question 5. Three biggest pickup zones

SELECT
    tz.zone AS pickup_zone,
    SUM(t.total_amount) AS total_amount_sum
FROM
    green_taxi_trips t
JOIN
    taxi_zones tz ON t.PULocationID = tz.location_id
WHERE
    DATE(t.lpep_pickup_datetime) = '2019-10-18'
GROUP BY
    tz.zone
HAVING
    SUM(t.total_amount) > 13000
ORDER BY
    total_amount_sum DESC;

--Question 6. Largest tip

SELECT tz.zone AS dropoff_zone, MAX(gt.tip_amount) AS max_tip
FROM green_taxi_trips gt
JOIN taxi_zones tz ON gt.DOLocationID = tz.location_id
WHERE gt.lpep_pickup_datetime >= '2019-10-01 00:00:00'
  AND gt.lpep_pickup_datetime < '2019-11-01 00:00:00'
  AND gt.PULocationID = (SELECT location_id FROM taxi_zones WHERE zone = 'East Harlem North')
GROUP BY tz.zone
ORDER BY max_tip DESC
LIMIT 1;






