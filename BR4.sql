WITH city_passenger_totals AS (
    SELECT 
        c.city_name,
        SUM(ps.new_passengers) AS total_new_passengers
    FROM fact_passenger_summary ps
    JOIN dim_city c ON ps.city_id = c.city_id
    GROUP BY c.city_name
),
rank_cities AS (
    SELECT
        city_name,
        total_new_passengers,
        RANK() OVER (ORDER BY total_new_passengers DESC) AS rank_highest,
        RANK() OVER (ORDER BY total_new_passengers ASC) AS rank_lowest
    FROM city_passenger_totals
),
categorized_cities AS (
    SELECT
        city_name,
        total_new_passengers,
        CASE
            WHEN rank_highest <= 3 THEN 'TOP 3'
            WHEN rank_lowest <= 3 THEN 'Bottom 3'
            ELSE NULL
        END AS city_category
    FROM rank_cities
)
SELECT * FROM categorized_cities;
