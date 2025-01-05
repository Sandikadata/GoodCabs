SELECT
    c.city_name,
    d.month_name,
    COUNT(ft.trip_id) AS actual_trips,
    mt.total_target_trips AS target_trips,
    CASE
        WHEN COUNT(ft.trip_id) > mt.total_target_trips THEN 'Above Target'
        ELSE 'Below Target'
    END AS performance_status,
    CONCAT(
    ROUND(
        ((COUNT(ft.trip_id) - mt.total_target_trips) * 100.0 / mt.total_target_trips),
        2),
        "%"
		)AS percentage_difference
FROM
    fact_trips ft
JOIN
    dim_city c ON ft.city_id = c.city_id
JOIN
    dim_date d ON ft.date = d.date
 JOIN
targets_db.monthly_target_trips mt
on c.city_id=mt.city_id
and d.start_of_month=mt.month
group by c.city_name,
         d.month_name,
         mt.total_target_trips,
         d.start_of_month
         order by
         c.city_name,
         month(d.start_of_month);
            