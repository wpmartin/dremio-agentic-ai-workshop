--Create NYC Taxi View with cleaned attribute names and values
SELECT 
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
            CAST(nyc_trips."passenger_count" AS INTEGER) AS passenger_count,
            CAST(nyc_trips."trip_distance_mi" AS FLOAT) AS trip_distance,
            CAST(nyc_trips."fare_amount" AS FLOAT) AS fare_amount,
            CAST(nyc_trips."tip_amount" AS FLOAT) AS tip_amount,
            CAST(nyc_trips."total_amount" AS FLOAT) AS total_amount
        FROM  Samples."samples.dremio.com"."NYC-taxi-trips-iceberg" AS nyc_trips
) nested_0;