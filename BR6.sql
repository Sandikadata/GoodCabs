with passenger_table as (
select
c.city_name,
d.month_name,
fp.city_id,
sum(fp.total_passengers) as total_passengers,
sum(fp.repeat_passengers) as repeat_passengers
from
fact_passenger_summary fp
join
dim_city c on fp.city_id=c.city_id
join
dim_date d on fp.month=d.start_of_month
group by
c.city_name,d.month_name,fp.city_id
)
select
pt.city_name,
pt.month_name,
pt.total_passengers,
pt.repeat_passengers,
round(
coalesce(pt.repeat_passengers *100/pt.total_passengers,0),2
) as monthly_repeat_passenger_rate,
round(
coalesce(
sum(pt.repeat_passengers) over (partition by pt.city_name)*100/
sum(pt.total_passengers) over (partition by pt.city_name),
0
),2
) as city_repeat_passenger_rate
from 
passenger_table pt
order by
pt.city_name, pt.month_name;
