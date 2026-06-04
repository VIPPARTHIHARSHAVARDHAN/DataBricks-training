CREATE TABLE customers (
    customer_id VARCHAR(10) PRIMARY KEY,
    customer_name VARCHAR(20),
    address VARCHAR(20),
    phone_no BIGINT,
    email_id VARCHAR(20)
);
CREATE TABLE delivery_partners (
    partner_id VARCHAR(10) PRIMARY KEY,
    partner_name VARCHAR(20),
    phone_no BIGINT,
    rating INT
);
CREATE TABLE hotel_details (
    hotel_id VARCHAR(10) PRIMARY KEY,
    hotel_name VARCHAR(20),
    hotel_type VARCHAR(20),
    rating INT
);
CREATE TABLE orders (
    order_id VARCHAR(10) PRIMARY KEY,
    customer_id VARCHAR(10),
    hotel_id VARCHAR(10),
    partner_id VARCHAR(10),
    order_date DATE,
    order_amount INT,
    
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (hotel_id) REFERENCES hotel_details(hotel_id),
    FOREIGN KEY (partner_id) REFERENCES delivery_partners(partner_id)
);

--Questions
--Refer to the schema. Write a query to display the customer mail details. Display the details in the below format.

--Give an alias name as CUSTOMER_MAIL_INFO. Sort the result in ascending order.

--> For Example: 

--    Customer_id - 'CUST001'

--    Email_id - 'mano@hotmail.com'

--> Sample Output:

 --   CUSTOMER_MAIL_INFO
 --   CUST001 mail id is mano@hotmail.com
SELECT CONCAT(customer_id,' mail id is ',email_id) AS CUSTOMER_MAIL_INFO
FROM customers
ORDER BY customer_id;



--Write a query to display partner id, partner name, phone number of delivery partners whose rating is between 3 to 5, sort the result based on partner id.
SELECT partner_id,
       partner_name,
       phone_no
FROM delivery_partners
WHERE rating BETWEEN 3 AND 5
ORDER BY partner_id;


--Refer to the schema. Write a query to display the hotel name along with the type. Display the details in the below format.

--Give an alias name as `hotel_info`. Sort the result in descending order.

--> For Example: 

--    Hotel_name - 'A2B'

--    Hotel_type - 'VEG'

--Sample Output:

--| hotel_info | 
--| ---------- |
--| A2B is a VEG hotel |
SELECT CONCAT(hotel_name, ' is a ', hotel_type, ' hotel') AS hotel_info
FROM hotel_details
ORDER BY hotel_info DESC;


--Write a query to display hotel id, hotel name and hotel type of hotels which has not taken any orders in the month of 'MAY 19'. Sort the result based on hotel id in ascending order.

--> HINT: Use Hotel_details and Orders tables to retrieve records. Eg: order_date= 2019-05-12

--*NOTE: Maintain the same sequence of column order, as specified in the question description*

SELECT hotel_id,
       hotel_name,
       hotel_type
FROM hotel_details
WHERE hotel_id NOT IN (
    SELECT hotel_id
    FROM orders
    WHERE order_date BETWEEN '2019-05-01' AND '2019-05-31'
)
ORDER BY hotel_id;



--Write a query to display distinct hotel id, hotel name, and rating of hotels that have taken order in the month of July. Sort the result based on hotel id in ascending order.

--> (HINT: Use Hotel_details and  Orders tables to retrieve records.Order date='2019-07-14')

--*NOTE: Maintain the same sequence of column order, as specified in the question description*
SELECT DISTINCT h.hotel_id,
       h.hotel_name,
       h.rating
FROM hotel_details h
JOIN orders o
ON h.hotel_id = o.hotel_id
WHERE o.order_date BETWEEN '2019-07-01' AND '2019-07-31'
ORDER BY h.hotel_id;


--Write a query to display the hotel id, hotel name, and count of orders placed for each hotel where the total number of orders is greater than 5.
SELECT o.hotel_id,
       h.hotel_name,
       COUNT(o.order_id) AS no_of_orders
FROM orders o
JOIN hotel_details h
ON o.hotel_id = h.hotel_id
GROUP BY o.hotel_id, h.hotel_name
HAVING COUNT(o.order_id) > 5
ORDER BY o.hotel_id;



--Write a query to change the data type of the field customer_id in Customers table to int.
ALTER TABLE customers
MODIFY customer_id INT;


--Write appropriate query/queries for the given requirement. Assume, Hotel_Details table has been already created.

--Requirement 1: Change the name of the existing field Rating to Hotel_Rating in the  Hotel_Details table.


ALTER TABLE hotel_details
RENAME COLUMN Rating TO Hotel_Rating;


--Update records based on the given requirement.

--> Requirement 1: update the phone no of the Customers whose id is 'CUST1004' to the new phone no  '9876543210'

UPDATE customers
SET phone_no = 9876543210
WHERE customer_id = 'CUST1004';


--Write a query to display order_date, total order amount in each day. Give an alias name for total order amount as ‘TOTAL_SALE’. Sort the result based on order_date.
SELECT order_date,
       SUM(order_amount) AS TOTAL_SALE
FROM orders
GROUP BY order_date
ORDER BY order_date;


--Write a query to display partner id,partner name and review of the delivery partner, give alias name for partner review as 'REVIEW', sort the result based on partner id in ascending order.

--*Note: Review is based on the following condition*

  --  IF rating>=4 then 'GOOD'

  --  IF rating between >=2 and <4 then 'AVERAGE'

  --  IF rating <2 then 'WORST'
SELECT partner_id,
       partner_name,
       CASE
           WHEN rating >= 4 THEN 'GOOD'
           WHEN rating >= 2 AND rating < 4 THEN 'AVERAGE'
           ELSE 'WORST'
       END AS REVIEW
FROM delivery_partners
ORDER BY partner_id;

--Write a query to display order id, customer name, hotel name, and order amount of all orders. Sort the result based on order id in ascending order.

--> HINT: Use Customers, Hotel_details and Orders tables to retrieve records.
SELECT o.order_id,
       c.customer_name,
       h.hotel_name,
       o.order_amount
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
JOIN hotel_details h
ON o.hotel_id = h.hotel_id
ORDER BY o.order_id;




