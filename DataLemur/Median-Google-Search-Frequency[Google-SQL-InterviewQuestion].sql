
with maintbl as (SELECT *,
SUM(num_users) OVER(order by searches rows BETWEEN unbounded preceding and current row) as running_total_of_users,
SUM(num_users) OVER() as total_users,
lead(searches) OVER(order by searches) as next_searches 
FROM search_frequency),

derived as (select *, case when running_total_of_users = total_users/2 then ROUND((searches+next_searches)/2.0,1)
else next_searches end as median
from maintbl 
where running_total_of_users<=total_users/2)

select MAX(median) as median
from derived 
