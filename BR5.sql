WITH monthly_city_revenue AS (
    SELECT 
        c.city_name,
        d.month_name,
        SUM(ft.fare_amount) AS monthly_revenue
    FROM fact_trips ft
    JOIN dim_city c ON ft.city_id = c.city_id
    JOIN dim_date d ON ft.date = d.date
    GROUP BY c.city_name, d.month_name
),
city_total_revenue AS (
    SELECT 
        city_name,
        SUM(monthly_revenue) AS city_total_revenue
    FROM monthly_city_revenue
    GROUP BY city_name
),
highest_revenue_month AS (
    SELECT
        mcr.city_name,
        mcr.month_name AS highest_revenue_month,
        mcr.monthly_revenue AS revenue,
        ROUND((mcr.monthly_revenue * 100 / ctr.city_total_revenue), 2) AS percentage_contribution
    FROM monthly_city_revenue mcr
    JOIN city_total_revenue ctr ON mcr.city_name = ctr.city_name
    WHERE mcr.monthly_revenue = (
        SELECT 
            MAX(monthly_revenue)
        FROM monthly_city_revenue mcr_sub
        WHERE mcr_sub.city_name = mcr.city_name
    )
)
SELECT * FROM highest_revenue_month;
