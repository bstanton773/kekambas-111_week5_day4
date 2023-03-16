-- Stored Procedures!
SELECT *
FROM customer
WHERE loyalty_member = TRUE;


-- If you don't have loyalty_member column, execute the following:
--ALTER TABLE customer
--ADD COLUMN loyalty_member;

-- Reset all customer loyalty to False
UPDATE customer 
SET loyalty_member = FALSE;


-- Create a Procedure thta will set anyone who has spent >= $100 to loyalty_member=TRUE

-- Query to get the customers who have spent >= 100
SELECT customer_id, SUM(amount)
FROM payment 
GROUP BY customer_id 
HAVING SUM(amount) >= 100;

-- Update the customer table to have those customers who have spent >= 100 as loyalty members
UPDATE customer
SET loyalty_member = TRUE 
WHERE customer_id IN (
	SELECT customer_id
	FROM payment 
	GROUP BY customer_id 
	HAVING SUM(amount) >= 100
);


-- Put that into a stored procedure
CREATE OR REPLACE PROCEDURE update_loyalty_status(loyalty_min NUMERIC(5,2) DEFAULT 100.00)
LANGUAGE plpgsql
AS $$
BEGIN
	UPDATE customer
	SET loyalty_member = TRUE 
	WHERE customer_id IN (
		SELECT customer_id
		FROM payment 
		GROUP BY customer_id 
		HAVING SUM(amount) >= loyalty_min
	);
END;
$$;

-- Execute the Procedure with CALL 
CALL update_loyalty_status();

SELECT *
FROM customer
WHERE loyalty_member = TRUE;


-- Find a customer who is close to the minimum
SELECT customer_id, SUM(amount)
FROM payment 
GROUP BY customer_id 
HAVING SUM(amount) BETWEEN 95 AND 100;

SELECT *
FROM customer 
WHERE customer_id = 554;

-- Add a new payment of 4.99 with that customer to push them over the threshold
INSERT INTO payment(customer_id, staff_id, rental_id, amount, payment_date)
VALUES(554, 1, 1, 4.99, '2023-03-16 13:26:34');

-- Call the procedure again
CALL update_loyalty_status();

SELECT *
FROM customer 
WHERE customer_id = 554;


-- Create a procedure to add new rows to a table
SELECT *
FROM actor;


INSERT INTO actor(first_name, last_name, last_update)
VALUES('Brian', 'Stanton', NOW());

SELECT *
FROM actor 
ORDER BY actor_id DESC;


CREATE OR REPLACE PROCEDURE add_actor(first_name VARCHAR, last_name VARCHAR)
LANGUAGE plpgsql
AS $$
BEGIN 
	INSERT INTO actor(first_name, last_name, last_update)
	VALUES(first_name, last_name, NOW());
END;
$$;

CALL add_actor('Tom', 'Cruise');
CALL add_actor('Tom', 'Hanks');

-- To delete a procedure, we use DROP
DROP PROCEDURE IF EXISTS add_actor;



