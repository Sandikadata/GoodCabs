SELECT
    c.city_name,
    ROUND(SUM(CASE WHEN t.trip_count = 2 THEN t.repeat_passenger_count END) * 100.0 / SUM(t.repeat_passenger_count), 2) AS "2-Trips",
    ROUND(SUM(CASE WHEN t.trip_count = 3 THEN t.repeat_passenger_count END) * 100.0 / SUM(t.repeat_passenger_count), 2) AS "3-Trips",
    ROUND(SUM(CASE WHEN t.trip_count = 4 THEN t.repeat_passenger_count END) * 100.0 / SUM(t.repeat_passenger_count), 2) AS "4-Trips",
    ROUND(SUM(CASE WHEN t.trip_count = 5 THEN t.repeat_passenger_count END) * 100.0 / SUM(t.repeat_passenger_count), 2) AS "5-Trips",
    ROUND(SUM(CASE WHEN t.trip_count = 6 THEN t.repeat_passenger_count END) * 100.0 / SUM(t.repeat_passenger_count), 2) AS "6-Trips",
    ROUND(SUM(CASE WHEN t.trip_count = 7 THEN t.repeat_passenger_count END) * 100.0 / SUM(t.repeat_passenger_count), 2) AS "7-Trips",
    ROUND(SUM(CASE WHEN t.trip_count = 8 THEN t.repeat_passenger_count END) * 100.0 / SUM(t.repeat_passenger_count), 2) AS "8-Trips",
    ROUND(SUM(CASE WHEN t.trip_count = 9 THEN t.repeat_passenger_count END) * 100.0 / SUM(t.repeat_passenger_count), 2) AS "9-Trips",
    ROUND(SUM(CASE WHEN t.trip_count = 10 THEN t.repeat_passenger_count END) * 100.0 / SUM(t.repeat_passenger_count), 2) AS "10-Trips"
FROM
    dim_repeat_trip_distribution t
JOIN
    dim_city c ON t.city_id = c.city_id
GROUP BY
    c.city_name
ORDER BY
    c.city_name;
