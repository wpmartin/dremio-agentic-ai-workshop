SELECT 
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
    workshop.business.nyc_taxi_trips__formatted as t INNER JOIN workshop.business.nyc_weather__formatted as w ON t.pickup_date = w.calendar_date;