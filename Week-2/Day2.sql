CREATE TABLE owners (
    owner_id VARCHAR(10) PRIMARY KEY,
    owner_name VARCHAR(20) NOT NULL,
    address VARCHAR(20),
    phone_no BIGINT,
    email_id VARCHAR(20)
);

CREATE TABLE customers (
    customer_id VARCHAR(10) PRIMARY KEY,
    customer_name VARCHAR(20) NOT NULL,
    address VARCHAR(20),
    phone_no BIGINT,
    email_id VARCHAR(20)
);

CREATE TABLE cars (
    car_id VARCHAR(10) PRIMARY KEY,
    car_name VARCHAR(20) NOT NULL,
    car_type VARCHAR(20) NOT NULL,
    owner_id VARCHAR(10) NOT NULL,
    FOREIGN KEY (owner_id) REFERENCES owners(owner_id)
);

CREATE TABLE rentals (
    rental_id VARCHAR(10) PRIMARY KEY,
    customer_id VARCHAR(10) NOT NULL,
    car_id VARCHAR(10) NOT NULL,
    pickup_date DATE,
    return_date DATE,
    km_driven INT,
    fare_amount DOUBLE(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (car_id) REFERENCES cars(car_id)
);



--Questions

--Write a query to display car id, car name and owner id of all the cars whose car type is 'Hatchback' or 'SUV'.  Sort the result based on car id.
SELECT car_id,car_name,owner_id From cars
Where car_type='Hatchback' OR car_type='SUV'
Order by car_id

--Write a query to display car id, car name and car type of Maruthi company 'Sedan' type cars.  Sort the result based on car id.
SELECT car_id, car_name, car_type
FROM cars
WHERE car_name LIKE 'Maruthi%'
  AND car_type = 'Sedan'
ORDER BY car_id;

--Refer to the given schema. Assume, CARS table has been already created. Write an appropriate query for the given requirement.  
--Requirement 1: Add a new column Car_Regno VARCHAR(10)  to the Cars table.
ALTER TABLE cars
ADD Car_Regno VARCHAR(10);

--Refer to the given schema.

--Write a query to create the Owners table with the specified columns and constraints.

--*Note: Letters in bold represents the table name*

--*Note: Maintain the same sequence of column order, as specified in the question description*
CREATE TABLE owners (
    owner_id VARCHAR(10) PRIMARY KEY,
    owner_name VARCHAR(20),
    address VARCHAR(20),
    phone_no BIGINT,
    email_id VARCHAR(20)
);


--Refer to the given schema diagram. Insert the below records into Rentals Table. Assume the rentals table has been already created.
INSERT INTO rentals
(rental_id, customer_id, car_id, pickup_date, return_date, km_driven, fare_amount)
VALUES
('R001','C007','V004','2018-03-10','2018-03-10',800,9000),
('R002','C001','V007','2018-03-11','2018-03-12',200,3000),
('R003','C007','V003','2018-04-15','2018-04-15',100,1500),
('R004','C007','V001','2018-05-16','2018-05-18',1000,10000),
('R005','C004','V005','2018-05-10','2018-05-12',900,11000),
('R006','C004','V006','2018-05-20','2018-05-21',200,2500);

--write a query to display car id, car name, car type of cars which was not taken for rent.  Sort the result based on car id.
SELECT car_id, car_name, car_type
FROM cars
WHERE car_id NOT IN (
    SELECT car_id
    FROM rentals
)
ORDER BY car_id;

--or
SELECT c.car_id, c.car_name, c.car_type
FROM cars c
LEFT JOIN rentals r
ON c.car_id = r.car_id
WHERE r.car_id IS NULL
ORDER BY c.car_id;


--Write a query to display the customer id, customer name and contact details of customers.
--If address is missing, display the email id. If both address and email is missing then display ‘NA’.
--Give an alias name as CONTACT_DETAILS.Sort the results based on customer id in ascending order.

SELECT customer_id,
       customer_name,
       COALESCE(address, email_id, 'NA') AS CONTACT_DETAILS
FROM customers
ORDER BY customer_id;

--or

SELECT customer_id,
       customer_name,
       CASE
           WHEN address IS NOT NULL THEN address
           WHEN email_id IS NOT NULL THEN email_id
           ELSE 'NA'
       END AS CONTACT_DETAILS
FROM customers
ORDER BY customer_id;


--Write a query to display distinct owner id, owner name, address, and phone no of owners who owns 'Maruthi' company car. Sort the result based on owner id.
SELECT DISTINCT o.owner_id,
       o.owner_name,
       o.address,
       o.phone_no
FROM owners o
JOIN cars c
ON o.owner_id = c.owner_id
WHERE c.car_name LIKE 'Maruthi%'
ORDER BY o.owner_id;


--Write a query to display rental id, car id, customer id and km driven of rentals taken during 'AUGUST 2019'.  Sort the result based on rental id.
SELECT rental_id,
       car_id,
       customer_id,
       km_driven
FROM rentals
WHERE pickup_date BETWEEN '2019-08-01' AND '2019-08-31'
ORDER BY rental_id;

--or
SELECT rental_id,
       car_id,
       customer_id,
       km_driven
FROM rentals
WHERE MONTH(pickup_date) = 8
  AND YEAR(pickup_date) = 2019
ORDER BY rental_id;


--

