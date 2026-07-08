--#1)Total order amount for each customer
SELECT customer_id,SUM(total_amount) AS total_order_amount
FROM sales
GROUP BY customer_id;