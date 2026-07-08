--4. City-wise total revenue
SELECT c.city,SUM(total_amount) as total_city_revenue
FROM customers c
JOIN sales s
ON c.customer_id=s.customer_id
GROUP BY c.city