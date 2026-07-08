-- Customers with no orders

SELECT c.*
FROM customers c
LEFT JOIN sales s
ON c.customer_id = s.customer_id
WHERE s.customer_id IS NULL;