--Create NYC Weather View
SELECT 
        station,
        location_name,
        TO_DATE(nested_0."date", 'YYYY-MM-DD', 1) AS calendar_date,
        average_wind,
        precipitation,
        snow,
        snow_depth,
        temp_max,
        temp_min
FROM   (SELECT 
                station,
                name AS location_name,
                CASE WHEN LENGTH(SUBSTR(nyc_weather."date", 1, 10)) > 0 THEN SUBSTR(nyc_weather."date", 1, 10) ELSE NULL END AS "date",
                CASE WHEN nyc_weather."awnd" != '' THEN CAST(nyc_weather."awnd" AS FLOAT) ELSE NULL END AS average_wind,
                CAST(nyc_weather."prcp" AS FLOAT) AS precipitation,
                CAST(nyc_weather."snow" AS FLOAT) AS snow,
                CAST(nyc_weather."snwd" AS FLOAT) AS snow_depth,
                CAST(nyc_weather."tempmax" AS FLOAT) AS temp_max,
                CAST(nyc_weather."tempmin" AS FLOAT) AS temp_min
        FROM   Samples."samples.dremio.com"."NYC-weather.csv" AS nyc_weather
) nested_0;