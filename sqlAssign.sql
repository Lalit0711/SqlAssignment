-- Q1.--------------
CREATE TABLE employees (
    emp_id INT PRIMARY KEY NOT NULL,
    emp_name TEXT NOT NULL,
    age INT CHECK (age >= 18),
    email TEXT UNIQUE,
    salary DECIMAL(10,2) DEFAULT 30000
);



-- Q2.Explain the purpose of constraints and how they help maintain data integrity in a database. Provide examples of common types of constraints.---------------
-- Ans. -- Constraints are rules applied to columns in a database table to ensure accuracy, consistency, and reliability of the stored data.
-- They act like guardrails that prevent invalid or inconsistent data from entering the database.
-- PRIMARY KEY
CREATE TABLE Students (
  student_id INT PRIMARY KEY,
  student_name VARCHAR(50)
);

-- FOREIGN KEY
CREATE TABLE Enrollments (
  enroll_id INT PRIMARY KEY,
  student_id INT,
  FOREIGN KEY (student_id) REFERENCES Students(student_id)
);

-- UNIQUE
CREATE TABLE Users (
  user_id INT PRIMARY KEY,
  email VARCHAR(100) UNIQUE
);

-- NOT NULL
CREATE TABLE Employees (
  emp_id INT PRIMARY KEY,
  emp_name VARCHAR(50) NOT NULL
);



-- Q3. Why would you apply the NOT NULL constraint to a column? Can a primary key contain NULL values? Justify your answer.
-- Ans. -- We apply the **NOT NULL** constraint to a column when we want to ensure that a value must always be provided and cannot be left empty. 
-- For example, in a student record, the `student_name` should never be NULL. A **Primary Key** cannot contain NULL values because it uniquely identifies 
-- each row in a table. If NULL were allowed, it would break uniqueness since NULL represents "unknown" and multiple rows could have NULL,
-- making them indistinguishable. Hence, a Primary Key must always be **unique** and **NOT NULL** to maintain data integrity.



-- Q4. Explain the steps and SQL commands used to add or remove constraints on an existing table. Provide an example for both adding and removing a constraint.
-- Ans. 
-- 1. Add a Constraint
ALTER TABLE table_name
ADD CONSTRAINT constraint_name PRIMARY KEY (column_name);

-- Add UNIQUE constraint
ALTER TABLE Customers
ADD CONSTRAINT unique_email UNIQUE (email);

-- 2. Remove a Constraint
ALTER TABLE table_name
DROP CONSTRAINT constraint_name;

-- Remove UNIQUE constraint
ALTER TABLE Customers
DROP CONSTRAINT unique_email;



-- Q5.  Explain the consequences of attempting to insert, update, or delete data in a way that violates constraints. Provide an example of an error message that might occur when violating a constraint.
-- Ans. If you try to insert, update, or delete data that violates a constraint, the database will reject the operation and return an error.
 -- For example, inserting a NULL value into a NOT NULL column or adding a duplicate value into a UNIQUE column will fail.
 -- Similarly, deleting a parent row that is referenced by a FOREIGN KEY will be blocked to maintain referential integrity.
-- These safeguards prevent invalid or inconsistent data.
-- ERROR 1062 (23000): Duplicate entry 'test@example.com' for key 'uq_email'




-- Q6. -------------------
-- Ans.
ALTER TABLE products
ADD CONSTRAINT pk_product PRIMARY KEY (product_id);

ALTER TABLE products
ALTER COLUMN price SET DEFAULT 50.00;

ALTER TABLE products
ALTER price SET DEFAULT 50.00;




-- Q7. Write a query to fetch the student_name and class_name for each student using an INNER JOIN.------------------------
-- Ans. 
SELECT s.student_name, c.class_name
FROM Students s
INNER JOIN Classes c
ON s.class_id = c.class_id;




-- Q8. -----Consider the following three tables:.....
SELECT 
    o.order_id,
    c.customer_name,
    p.product_name
FROM 
    Products p
LEFT JOIN 
    Orders o ON p.order_id = o.order_id
LEFT JOIN 
    Customers c ON o.customer_id = c.customer_id;





-- Q9. Write a query to find the total sales amount for each product using an INNER JOIN and the SUM() function.
SELECT 
    p.product_name,
    SUM(s.amount) AS total_sales
FROM 
    Sales s
INNER JOIN 
    Products p ON s.product_id = p.product_id
GROUP BY 
    p.product_name;





-- Q10. Write a query to display the order_id, customer_name, and the quantity of products ordered by each customer using an INNER JOIN between all three tables.
SELECT 
    o.order_id,
    c.customer_name,
    od.quantity
FROM 
    Orders o
INNER JOIN 
    Customers c ON o.customer_id = c.customer_id
INNER JOIN 
    Order_Details od ON o.order_id = od.order_id;




-- SQL Commands===============================================================================================================



-- 1-Identify the primary keys and foreign keys in maven movies db. Discuss the differences
USE mavenmovies;

-- For primery key.
SELECT TABLE_NAME, COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'mavenmovies'
  AND CONSTRAINT_NAME = 'PRIMARY';

-- For foreign keys.
SELECT TABLE_NAME, COLUMN_NAME, 
       REFERENCED_TABLE_NAME, REFERENCED_COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'mavenmovies'
  AND REFERENCED_TABLE_NAME IS NOT NULL;



-- 2- List all details of actor------------
DESCRIBE actor;
SELECT * FROM actor;
SELECT * FROM actor
ORDER BY actor_id;




-- 3. List all customer information from DB.----------------
DESCRIBE customers;
SELECT * FROM customer;




-- 4. List different countries-------------------------------
SELECT * FROM country;
SELECT DISTINCT country FROM country;



-- 5. Display all active customers.----------------------
SELECT * FROM customer
WHERE active = 1;



-- 6. List of all rental IDs for customer with ID 1.-------------
SELECT rental_id
FROM rental
WHERE customer_id = 1;




-- 7.Display all the films whose rental duration is greater than 5 .--------------------
SELECT *
FROM film
WHERE rental_duration > 5;
 



-- 8. List the total number of films whose replacement cost is greater than $15 and less than $20-----------------
SELECT COUNT(*) AS total_films
FROM film
WHERE replacement_cost > 15 AND replacement_cost < 20;




-- Display the count of unique first names of actors.--------------------
SELECT COUNT(DISTINCT first_name) AS unique_first_names
FROM actor;




-- Display the first 10 records from the customer table .-----------
SELECT *
FROM customer
LIMIT 10;



-- Display the names of the first 5 movies which are rated as ‘G’.-----------------
SELECT title
FROM film
WHERE rating = 'G'
LIMIT 5;



-- Find all customers whose first name starts with "a".--------------
SELECT *
FROM customer
WHERE first_name LIKE 'a%';



-- Display the list of first 4 cities which start and end with ‘a’ .-------------
SELECT city
FROM city
WHERE city LIKE 'a%a'
LIMIT 4;



-- Find all customers whose first name have "NI" in any position.-----------
SELECT *
FROM customer
WHERE first_name LIKE '%NI%';


--  Find all customers whose first name have "r" in the second position ------------
SELECT *
FROM customer
WHERE first_name LIKE '_r%';



-- Find all customers whose first name starts with "a" and are at least 5 characters in length.--------
SELECT *
FROM customer
WHERE first_name LIKE 'a%' 
  AND LENGTH(first_name) >= 5;



-- 19.Find all customers whose first name starts with "a" and ends with "o".--------------------
SELECT *
FROM customer
WHERE first_name LIKE 'a%o';


-- 20. Get the films with pg and pg-13 rating using IN operator------------
SELECT *
FROM film
WHERE rating IN ('PG', 'PG-13');



-- 21.Get the films with length between 50 to 100 using between operator.-------------
SELECT *
FROM film
WHERE length BETWEEN 50 AND 100;



-- 22. Get the top 50 actors using limit operator.------------------
SELECT *
FROM actors
LIMIT 50;



-- 23. Get the distinct film ids from inventory table-----------------------
SELECT DISTINCT film_id
FROM inventory;




-- Functions===========================================================================================================================

-- Basic Aggregate Functions:-==========================================

-- Q1. Retrieve the total number of rentals made in the Sakila database.
SELECT COUNT(*) AS total_rentals
FROM rental;


-- Q2. Find the average rental duration (in days) of movies rented from the Sakila database.
SELECT AVG(rental_duration) AS avg_rental_duration
FROM film;



-- Q3. Display the first name and last name of customers in uppercase.
SELECT UPPER(first_name) AS first_name_upper,
       UPPER(last_name) AS last_name_upper
FROM customer;



-- Q4. Extract the month from the rental date and display it alongside the rental ID.
SELECT rental_id,
       MONTH(rental_date) AS rental_month
FROM rental;



-- Q5. Retrieve the count of rentals for each customer (display customer ID and the count of rentals).
SELECT customer_id,
       COUNT(*) AS rental_count
FROM rental
GROUP BY customer_id;



-- Q6. Find the total revenue generated by each store.
SELECT store_id,
       SUM(amount) AS total_revenue
FROM payment
GROUP BY store_id;



-- Q7. Determine the total number of rentals for each category of movies.
SELECT c.name AS category_name,
       COUNT(r.rental_id) AS total_rentals
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY c.name
ORDER BY total_rentals DESC;

  

-- Q8. Find the average rental rate of movies in each language.
SELECT l.name AS language,
       AVG(f.rental_rate) AS avg_rental_rate
FROM film f
JOIN language l ON f.language_id = l.language_id
GROUP BY l.name
ORDER BY avg_rental_rate DESC;


-- joins ===============================================================================

-- Q9. Display the title of the movie, customer s first name, and last name who rented it.
SELECT f.title AS movie_title,
       c.first_name AS customer_first_name,
       c.last_name AS customer_last_name
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN customer c ON r.customer_id = c.customer_id;



-- Q10. Retrieve the names of all actors who have appeared in the film "Gone with the Wind."
SELECT a.first_name,
       a.last_name
FROM actors a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
WHERE f.title = 'Gone with the Wind';



-- Q11. Retrieve the customer names along with the total amount they've spent on rentals.
SELECT c.first_name,
       c.last_name,
       SUM(p.amount) AS total_spent
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
JOIN rental r ON p.rental_id = r.rental_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC;



-- Q12. List the titles of movies rented by each customer in a particular city (e.g., 'London').
SELECT c.first_name,
       c.last_name,
       f.title AS movie_title
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE ci.city = 'London'
ORDER BY c.customer_id, f.title;



-- Advanced Joins and GROUP BY-============================================================

-- Q13. Display the top 5 rented movies along with the number of times they've been rented.
SELECT f.title AS movie_title,
       COUNT(r.rental_id) AS times_rented
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
ORDER BY times_rented DESC
LIMIT 5;



-- Q14. Determine the customers who have rented movies from both stores (store ID 1 and store ID 2).
SELECT c.customer_id,
       c.first_name,
       c.last_name
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
WHERE i.store_id IN (1, 2)
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(DISTINCT i.store_id) = 2;



-- Windows Function===========================================================================================

-- 1. Rank the customers based on the total amount they've spent on rentals.

SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(p.amount) AS total_spent,
    RANK() OVER (ORDER BY SUM(p.amount) DESC) AS rank_by_spent
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY rank_by_spent;


-- 2. Calculate the cumulative revenue generated by each film over time. 

SELECT 
    f.title AS movie_title,
    r.rental_date,
    SUM(p.amount) OVER (
        PARTITION BY f.film_id 
        ORDER BY r.rental_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_revenue
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
ORDER BY f.title, r.rental_date;



-- 3.  Determine the average rental duration for each film, considering films with similar lengths.
SELECT length,
       AVG(rental_duration) AS avg_rental_duration,
       COUNT(*) AS number_of_films
FROM film
GROUP BY length
ORDER BY length;


-- 4. Identify the top 3 films in each category based on their rental counts. 

SELECT *
FROM (
    SELECT 
        c.name AS category_name,
        f.title AS movie_title,
        COUNT(r.rental_id) AS rental_count,
        RANK() OVER (PARTITION BY c.category_id ORDER BY COUNT(r.rental_id) DESC) AS rank_in_category
    FROM category c
    JOIN film_category fc ON c.category_id = fc.category_id
    JOIN film f ON fc.film_id = f.film_id
    JOIN inventory i ON f.film_id = i.film_id
    JOIN rental r ON i.inventory_id = r.inventory_id
    GROUP BY c.category_id, c.name, f.film_id, f.title
) AS ranked_films
WHERE rank_in_category <= 3
ORDER BY category_name, rank_in_category;


-- 5. Calculate the difference in rental counts between each customer's total rentals and the average rentals across all customers.

SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(r.rental_id) AS total_rentals,
    AVG(COUNT(r.rental_id)) OVER () AS avg_rentals,
    COUNT(r.rental_id) - AVG(COUNT(r.rental_id)) OVER () AS diff_from_avg
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY diff_from_avg DESC;



-- 6. Find the monthly revenue trend for the entire rental store over time

SELECT 
    DATE_FORMAT(payment_date, '%Y-%m') AS month,
    SUM(amount) AS monthly_revenue
FROM payment
GROUP BY month
ORDER BY month;



-- 7.  Identify the customers whose total spending on rentals falls within the top 20% of all customers

SELECT customer_id,
       first_name,
       last_name,
       total_spent
FROM (
    SELECT 
        c.customer_id,
        c.first_name,
        c.last_name,
        SUM(p.amount) AS total_spent,
        CUME_DIST() OVER (ORDER BY SUM(p.amount) DESC) AS cum_dist
    FROM customer c
    JOIN payment p ON c.customer_id = p.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name
) AS ranked_customers
WHERE cum_dist <= 0.20
ORDER BY total_spent DESC;



-- 8. Calculate the running total of rentals per category, ordered by rental count.

SELECT 
    c.name AS category_name,
    f.title AS movie_title,
    COUNT(r.rental_id) AS rental_count,
    SUM(COUNT(r.rental_id)) OVER (
        PARTITION BY c.category_id 
        ORDER BY COUNT(r.rental_id) DESC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total_rentals
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY c.category_id, c.name, f.film_id, f.title
ORDER BY c.name, rental_count DESC;



-- 9. Find the films that have been rented less than the average rental count for their respective categories.

SELECT *
FROM (
    SELECT 
        c.name AS category_name,
        f.title AS movie_title,
        COUNT(r.rental_id) AS rental_count,
        AVG(COUNT(r.rental_id)) OVER (PARTITION BY c.category_id) AS avg_rentals_per_category
    FROM category c
    JOIN film_category fc ON c.category_id = fc.category_id
    JOIN film f ON fc.film_id = f.film_id
    JOIN inventory i ON f.film_id = i.film_id
    LEFT JOIN rental r ON i.inventory_id = r.inventory_id
    GROUP BY c.category_id, c.name, f.film_id, f.title
) AS film_rentals
WHERE rental_count < avg_rentals_per_category
ORDER BY category_name, rental_count;



-- 10.  Identify the top 5 months with the highest revenue and display the revenue generated in each month.

SELECT 
    DATE_FORMAT(payment_date, '%Y-%m') AS month,
    SUM(amount) AS total_revenue
FROM payment
GROUP BY month
ORDER BY total_revenue DESC
LIMIT 5;




-- Normalisation & CTE===================================================================================================================================



-- 1. First Normal Form (1NF):----------------------------------------------------------------------------------------------------------
-- a. Identify a table in the Sakila database that violates 1NF. Explain how you
-- would normalize it to achieve 1NF.

-- Consider a hypothetical table customer that stores multiple phone numbers in a single column:
-- In this table, the phone_numbers column contains multiple values in one field (comma-separated), which violates 1NF because the column is not atomic.
-- Normalization to Achieve 1NF:
-- To normalize this table to 1NF, we need to separate the multi-valued attribute into a new table so that each phone number has its own row while still linking it to
-- the customer.This can be achieved by creating a new table customer_phone:
CREATE TABLE customer_phone (
    customer_id INT,
    phone_number VARCHAR(20),
    PRIMARY KEY (customer_id, phone_number),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
) ENGINE=InnoDB;

-- Each field now contains a single, atomic value.
-- To achieve 1NF, any multi-valued or repeating fields must be split into separate tables, ensuring that all attributes are atomic and properly linked via foreign keys. 
-- This improves data integrity and makes the database easier to query and maintain.






-- 2. Second Normal Form (2NF):
-- a. Choose a table in Sakila and describe how you would determine whether it is in 2NF. If it violates 2NF, explain the steps to normalize it.

-- A table is in Second Normal Form (2NF) if: It is already in First Normal Form (1NF).
-- All non-key attributes are fully functionally dependent on the entire primary key, meaning there are no partial dependencies on a part of a composite key.
-- Consider a hypothetical table film_actor (linking films and actors) that has extra details
-- Normalization to Achieve 2NF:
CREATE TABLE film_actor (
    actor_id INT,
    film_id INT,
    PRIMARY KEY(actor_id, film_id),
    FOREIGN KEY(actor_id) REFERENCES actor(actor_id),
    FOREIGN KEY(film_id) REFERENCES film(film_id)
) ENGINE=InnoDB;

-- Step 2: Move actor details to the actor table:
-- | actor_id | first_name | last_name |
-- Step 3: Move film details to the film table:
-- | film_id | title | description | release_year | ... |
-- The table is now in 2NF, and partial dependencies are removed.




-- 3. Third Normal Form (3NF):
-- a. Identify a table in Sakila that violates 3NF. Describe the transitive dependencies
-- present and outline the steps to normalize the table to 3NF

-- Consider a hypothetical table customer with the following columns:
-- | customer_id | first_name | last_name | city | country | country_code |
-- Primary key: customer_id
-- Non-key attributes: first_name, last_name, city, country, country_code
-- Transitive Dependency Check:
-- country_code depends on country, not directly on customer_id.
-- This is a transitive dependency:
-- customer_id → country → country_code
-- Conclusion: Because country_code depends on another non-key attribute (country), this table violates 3NF.

-- Normalization to Achieve 3NF:
CREATE TABLE country (
    country_id INT PRIMARY KEY,
    country_name VARCHAR(50),
    country_code VARCHAR(10)
) ENGINE=InnoDB;

CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    city VARCHAR(50),
    country_id INT,
    FOREIGN KEY (country_id) REFERENCES country(country_id)
) ENGINE=InnoDB;

-- The table is now in 3NF, and transitive dependencies are removed.






-- 4. Normalization Process:
-- a. Take a specific table in Sakila and guide through the process of normalizing it from the initial unnormalized form up to at least 2NF.

-- Normalization Process
-- Step 1: Identify an Unnormalized Table (UNF)
-- Consider a hypothetical table customer_orders in MavenMovies that stores customer and rental information together:

-- Problems (violating 1NF and 2NF):
-- phone_numbers contains multiple values in a single field → violates 1NF.
-- Customer and film details are repeated across multiple rows, causing redundancy.
-- Non-key attributes like customer_name depend only on part of a composite key (e.g., customer_id) → violates 2NF.

-- Step 2: Normalize to First Normal Form (1NF)
-- Objective: Make all columns atomic and remove repeating groups.
-- Solution: Split phone_numbers into a separate table:
CREATE TABLE customer_phone (
    customer_id INT,
    phone_number VARCHAR(20),
    PRIMARY KEY (customer_id, phone_number),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
) ENGINE=InnoDB;


-- Step 3: Normalize to Second Normal Form (2NF)
-- Objective: Remove partial dependencies in tables with composite keys.
-- Step 3a: Create a linking table for rentals:
CREATE TABLE rental (
    rental_id INT PRIMARY KEY,
    customer_id INT,
    film_id INT,
    rental_date DATE,
    payment_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (film_id) REFERENCES film(film_id)
) ENGINE=InnoDB;

-- Step 3b: Separate film details into the film table:
-- | film_id | film_title | description | release_year | ... |
-- Result:
-- All non-key attributes in each table now depend fully on the primary key.
-- Partial dependencies are removed.
-- Tables customer, customer_phone, film, and rental are in 2NF.






-- 5. CTE Basics:
-- a. Write a query using a CTE to retrieve the distinct list of actor names and the number of films they have acted in from the actor and film_actor tables.

WITH actor_films AS (
    SELECT 
        a.actor_id,
        CONCAT(a.first_name, ' ', a.last_name) AS actor_name,
        COUNT(fa.film_id) AS film_count
    FROM actor a
    JOIN film_actor fa ON a.actor_id = fa.actor_id
    GROUP BY a.actor_id, a.first_name, a.last_name
)
SELECT actor_name, film_count
FROM actor_films
ORDER BY film_count DESC;




-- 6.CTE with Joins:
-- a. Create a CTE that combines information from the film and language tables to display the film title, language name, and rental rate.

WITH film_language AS (
    SELECT 
        f.film_id,
        f.title AS film_title,
        l.name AS language_name,
        f.rental_rate
    FROM film f
    JOIN language l ON f.language_id = l.language_id
)
SELECT film_title, language_name, rental_rate
FROM film_language
ORDER BY film_title;
 
 
 

-- 7. CTE for Aggregation:
-- a. Write a query using a CTE to find the total revenue generated by each customer (sum of payments) from the customer and payment tables.
WITH customer_revenue AS (
    SELECT 
        c.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        SUM(p.amount) AS total_revenue
    FROM customer c
    JOIN payment p ON c.customer_id = p.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name
)
SELECT customer_name, total_revenue
FROM customer_revenue
ORDER BY total_revenue DESC;



-- 8. CTE with Window Functions:
-- a. Utilize a CTE with a window function to rank films based on their rental duration from the film table.

WITH film_rank AS (
    SELECT 
        title AS film_title,
        rental_duration,
        RANK() OVER (ORDER BY rental_duration DESC) AS rental_rank
    FROM film
)
SELECT film_title, rental_duration, rental_rank
FROM film_rank
ORDER BY rental_rank;



-- 9. CTE and Filtering:
-- a. Create a CTE to list customers who have made more than two rentals, and then join this CTE with the
-- customer table to retrieve additional customer details.
WITH frequent_customers AS (
    SELECT 
        customer_id,
        COUNT(rental_id) AS rental_count
    FROM rental
    GROUP BY customer_id
    HAVING COUNT(rental_id) > 2
)
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.email,
    fc.rental_count
FROM frequent_customers fc
JOIN customer c ON fc.customer_id = c.customer_id
ORDER BY fc.rental_count DESC;




-- 10. CTE for Date Calculations:
-- a. Write a query using a CTE to find the total number of rentals made each month, considering the rental_date from the rental table

WITH monthly_rentals AS (
    SELECT 
        DATE_FORMAT(rental_date, '%Y-%m') AS rental_month,
        COUNT(rental_id) AS total_rentals
    FROM rental
    GROUP BY DATE_FORMAT(rental_date, '%Y-%m')
)
SELECT rental_month, total_rentals
FROM monthly_rentals
ORDER BY rental_month;




-- 11 CTE and Self-Join:
-- a. Create a CTE to generate a report showing pairs of actors who have appeared in the same film together, using the film_actor table.

WITH actor_pairs AS (
    SELECT 
        fa1.film_id,
        fa1.actor_id AS actor1_id,
        fa2.actor_id AS actor2_id
    FROM film_actor fa1
    JOIN film_actor fa2 
        ON fa1.film_id = fa2.film_id
        AND fa1.actor_id < fa2.actor_id
)
SELECT 
    CONCAT(a1.first_name, ' ', a1.last_name) AS actor1_name,
    CONCAT(a2.first_name, ' ', a2.last_name) AS actor2_name,
    fp.film_id
FROM actor_pairs fp
JOIN actor a1 ON fp.actor1_id = a1.actor_id
JOIN actor a2 ON fp.actor2_id = a2.actor_id
ORDER BY fp.film_id, actor1_name, actor2_name;




-- 12.  CTE for Recursive Search:
-- a. Implement a recursive CTE to find all employees in the staff table who report to a specific manager, considering the reports_to column

WITH RECURSIVE employee_hierarchy AS (
    -- Anchor member: top-level manager (replace 1 with the manager's staff_id)
    SELECT 
        staff_id,
        first_name,
        last_name,
        reports_to
    FROM staff
    WHERE staff_id = 1

    UNION ALL

    -- Recursive member: employees reporting to the previous level
    SELECT 
        s.staff_id,
        s.first_name,
        s.last_name,
        s.reports_to
    FROM staff s
    JOIN employee_hierarchy eh
        ON s.reports_to = eh.staff_id
)
SELECT staff_id, first_name, last_name, reports_to
FROM employee_hierarchy
ORDER BY staff_id;





