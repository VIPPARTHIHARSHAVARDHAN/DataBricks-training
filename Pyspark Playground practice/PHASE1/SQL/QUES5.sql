--5) Average order amount per customer

SELECT customer_id,AVG(total_amount) 
FROM sales
GROUP BY customer_id