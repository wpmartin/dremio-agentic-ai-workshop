CREATE FOLDER IF NOT EXISTS workshop.bronze;
CREATE OR REPLACE VIEW workshop.bronze.trips_raw AS SELECT * FROM Samples."samples.dremio.com"."NYC-taxi-trips.csv";

-- Create silver and gold folders in the workshop catalog
CREATE FOLDER IF NOT EXISTS workshop.silver;
CREATE FOLDER IF NOT EXISTS workshop.gold;

-- Create raw copies of the sample weather datasets in the bronze-layer
CREATE OR REPLACE VIEW workshop.bronze.nyc_weather_raw AS SELECT * FROM Samples."samples.dremio.com"."NYC-weather.csv";
CREATE OR REPLACE VIEW workshop.bronze.sf_weather_raw AS SELECT * FROM Samples."samples.dremio.com"."SF weather 2018-2019.csv";

-- Create silver-layer trips View with cleaned attribute names
CREATE OR REPLACE VIEW workshop.silver.trips AS SELECT 
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
            passenger_count,
            trip_distance_mi AS trip_distance,
            fare_amount,
            tip_amount,
            total_amount
        FROM  workshop.bronze.trips_raw AS nyc_trips
) nested_0;

-- Create silver-layer weather View with cleaned attribute names and data types
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

-- Create gold-layer trips View enriched with weather data
CREATE OR REPLACE VIEW workshop.gold.trips_enriched AS SELECT 
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
    workshop.silver.trips as t INNER JOIN workshop.silver.nyc_weather as w ON t.pickup_date = w.calendar_date
    LIMIT 30000000;
