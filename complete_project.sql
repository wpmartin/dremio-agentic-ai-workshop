-- Create bronze, silver, and gold folders in the workshop catalog
CREATE FOLDER IF NOT EXISTS workshop.bronze;
CREATE FOLDER IF NOT EXISTS workshop.silver;
CREATE FOLDER IF NOT EXISTS workshop.gold;

-- Create raw copies of the sample datasets as Tables in the bronze-layer
CREATE TABLE IF NOT EXISTS workshop.bronze.nyc_trips_raw AS SELECT * FROM Samples."samples.dremio.com"."NYC-taxi-trips.csv";
CREATE TABLE IF NOT EXISTS workshop.bronze.nyc_weather_raw AS SELECT * FROM Samples."samples.dremio.com"."NYC-weather.csv";
CREATE TABLE IF NOT EXISTS workshop.bronze.sf_weather_raw AS SELECT * FROM Samples."samples.dremio.com"."SF weather 2018-2019.csv";

-- Create silver-layer "nyc_trips" View with cleaned attribute names
-- [convert string attributes to appropriate data types, split pickup_datetime into pickup_date and pickup_time, rename "trip_distance_mi" attribute]
CREATE OR REPLACE VIEW workshop.silver.nyc_trips AS SELECT 
    TO_TIME(pickup_time, 'HH24:MI:SS', 1) AS pickup_time,
    TO_DATE(pickup_date, 'YYYY-MM-DD', 1) AS pickup_date,
    passenger_count,
    trip_distance,
    fare_amount,
    tip_amount,
    total_amount
FROM   (SELECT 
            CASE WHEN LENGTH(SUBSTR(nyc_trips."pickup_datetime", 12, LENGTH(nyc_trips."pickup_datetime") - 15)) > 0 THEN SUBSTR(nyc_trips."pickup_datetime", 12, LENGTH(nyc_trips."pickup_datetime") - 15) ELSE NULL END AS pickup_time,
            CASE WHEN LENGTH(SUBSTR(nyc_trips."pickup_datetime", 1, 10)) > 0 THEN SUBSTR(nyc_trips."pickup_datetime", 1, 10) ELSE NULL END AS pickup_date,
            CAST(nyc_trips."passenger_count" AS INT) AS passenger_count,
            CAST(nyc_trips."trip_distance_mi" AS FLOAT) AS trip_distance,
            CAST(nyc_trips."fare_amount" AS FLOAT) AS fare_amount,
            CAST(nyc_trips."tip_amount" AS FLOAT) AS tip_amount,
            CAST(nyc_trips."total_amount" AS FLOAT) AS total_amount
        FROM  workshop.bronze.nyc_trips_raw AS nyc_trips
) nested_0;

-- Create silver-layer "nyc_weather" View with cleaned attribute names and data types
-- [convert string columns to float, handle null values in awnd, rename attributes to be human-readable, reformat date attribute]
CREATE OR REPLACE VIEW workshop.silver.nyc_weather AS SELECT 
        station,
        location_name,
        TO_DATE(calendar_date, 'YYYY-MM-DD', 1) AS calendar_date,
        average_wind,
        precipitation,
        snow,
        snow_depth,
        temp_max,
        temp_min
FROM   (SELECT 
                station,
                name AS location_name,
                CASE WHEN LENGTH(SUBSTR(nyc_weather."date", 1, 10)) > 0 THEN SUBSTR(nyc_weather."date", 1, 10) ELSE NULL END AS calendar_date,
                CASE WHEN nyc_weather."awnd" != '' THEN CAST(nyc_weather."awnd" AS FLOAT) ELSE NULL END AS average_wind,
                CAST(nyc_weather."prcp" AS FLOAT) AS precipitation,
                CAST(nyc_weather."snow" AS FLOAT) AS snow,
                CAST(nyc_weather."snwd" AS FLOAT) AS snow_depth,
                CAST(nyc_weather."tempmax" AS FLOAT) AS temp_max,
                CAST(nyc_weather."tempmin" AS FLOAT) AS temp_min
        FROM   workshop.bronze.nyc_weather_raw AS nyc_weather
) nested_0;

-- Create gold-layer "enriched_trips" View enriched with weather data
-- [join the silver nyc_trips and nyc_weather datasets]
CREATE OR REPLACE VIEW workshop.gold.nyc_trips_enriched AS SELECT 
    location_name,
    pickup_date,
    pickup_time,
    passenger_count,
    trip_distance,
    fare_amount,
    tip_amount,
    total_amount,
    average_wind,
    precipitation,
    snow,
    snow_depth,
    temp_max,
    temp_min
FROM 
    workshop.silver.nyc_trips as t INNER JOIN workshop.silver.nyc_weather as w ON t.pickup_date = w.calendar_date
    LIMIT 30000000;
