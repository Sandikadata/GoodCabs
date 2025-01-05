SELECT
    d.city_name,
    COUNT(ft.trip_id) AS total_trips,
    ROUND(AVG(ft.fare_amount) / NULLIF(AVG(ft.distance_travelled_km), 0), 2) AS avg_fare_per_km,
    ROUND(AVG(ft.fare_amount), 2) AS avg_fare_per_trip,
    CONCAT(
        ROUND(
            (COUNT(ft.trip_id) * 100.0) / SUM(COUNT(ft.trip_id)) OVER (),
            2
        ),
        ' %'
    ) AS contribution_to_total_trip
FROM
    fact_trips ft
JOIN
    dim_city d ON ft.city_id = d.city_id
GROUP BY
    d.city_name
ORDER BY
    total_trips DESC;
