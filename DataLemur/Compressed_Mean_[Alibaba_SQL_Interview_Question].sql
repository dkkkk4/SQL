#Given query works fine
SELECT ROUND(SUM(order_occurrences*item_count)/SUM(order_occurrences)) as mean FROM items_per_order

#but this doesn't
SELECT ROUND(SUM(order_occurrences*item_count)/SUM(order_occurrences),1) as mean FROM items_per_order
#throws Error "function round(double precision, integer) does not exist (LINE: 1)"

#solution to above problem CAST() function
SELECT ROUND(CAST(SUM(order_occurrences*item_count)/SUM(order_occurrences) as numeric),1) as mean FROM items_per_order
