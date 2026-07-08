--6.Customers with more than one order
SELECT customer_id,count(customer_id) as total_orders FROM sales
GROUP BY customer_id
HAVING total_orders>1