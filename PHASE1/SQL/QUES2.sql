--Top 3 customers by total spend
SELECT customer_id,SUM(total_amount) AS TOTAL_SPENT
FROM sales
GROUP BY customer_id
ORDER BY TOATAL_SPENT DESC
LIMIT 3;