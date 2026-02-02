-- SELECT 123 AS static_number

-- SELECT 'meow' AS static_string

/*
SELECT id ,
first_name,
'New Customer' AS customer_type
FROM customers


*/
-- QUERY 1
/*
SELECT *
FROM customers
WHERE country = 'Germany'
*/
-- QUERY 2
 -- SELECT * FROM orders


--☝️☝️ select only one query and press execute


/* Create a new table called persons
with columns : id,person_name,birth_date, and phone */

CREATE TABLE persons (
	id INT NOT NULL,
	person_name VARCHAR(50) NOT NULL,
	birth_date DATE,
	phone VARCHAR(15) NOT NULL,
	CONSTRAINT pk_persons PRIMARY KEY (id)
)

-- ADD a new column called email to the persons table

ALTER TABLE persons
ADD email VARCHAR(50) NOT NULL

SELECT * FROM persons

-- REMOVE the column phone from the persons table
ALTER TABLE persons
DROP COLUMN phone

SELECT * FROM persons

-- Delete the table persons from the table

DROP TABLE persons