	#NTILE()
with product_total_revenue as (SELECT product_id, round(sum(cost_to_customer_per_qty *quantity),2) as total_cost,
FROM `steel-totality-402116.farmers_market.customer_purchases`
group by 1)

select *, ntile(5) over(order by total_cost desc) as prodcut_tier
from product_total_revenue
order by 3 

	#ROW_NUMBER()
SELECT product_id, (cost_to_customer_per_qty *quantity) as total_cost, 
row_number() over(partition by product_id order by cost_to_customer_per_qty *quantity desc) as row_number
FROM `steel-totality-402116.farmers_market.customer_purchases`


	#RANK() and DENSE_RANK()
SELECT product_id, round(cost_to_customer_per_qty *quantity,2) as total_cost, 
rank() over(partition by product_id order by cost_to_customer_per_qty *quantity desc) as rankk,
dense_rank() over(partition by product_id order by cost_to_customer_per_qty *quantity desc) as rankk
FROM `steel-totality-402116.farmers_market.customer_purchases`

	#NTH_VALUE
SELECT product_id, round(cost_to_customer_per_qty *quantity,2) as total_cost, 
dense_rank() over(partition by product_id order by cost_to_customer_per_qty *quantity desc) as rankk,
NTH_VALUE(product_id, 3) OVER(PARTITION BY product_id order by cost_to_customer_per_qty *quantity desc range between unbounded preceding and unbounded following) as  third_costly_order_product
FROM `steel-totality-402116.farmers_market.customer_purchases`

#keep in mind that "unbounded following" has to be specified else null will be shown for 1st and 2nd values of total_cost, 

	#Moving_average
with main as (SELECT market_date, round(SUM(cost_to_customer_per_qty *quantity)) as total_cost
FROM `steel-totality-402116.farmers_market.customer_purchases`
GROUP BY 1)

select market_date, total_cost, round(AVG(total_cost) OVER(partition by extract(month from market_date) order by market_date rows between 5 preceding and current row),1) as  Fiveday_moving_average_of_total_cost
from main
order by 1


