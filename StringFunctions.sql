-- CONCAT, UPPER , LOWER, TRIM, REPLACR

-- LEN

-- LEFT, RIGHT, SUBSTRING

-- CONCAT

-- Concatanate first name and country into one column

SELECT 
first_name,
country,
CONCAT(first_name,'-', country) AS name_country
FROM customers 

-- LOWER & UPPER

-- convert the first name to lowercase

SELECT 
first_name,
CONCAT(first_name,'-', country) AS name_country,
LOWER(first_name) AS lower_name
FROM customers

-- convert the first name to luppercase

SELECT 
first_name,
CONCAT(first_name,'-', country) AS name_country,
LOWER(first_name) AS lower_name,
UPPER(first_name) AS upper_name
FROM customers



-- TRIM ----

-- Find customers whose first name contains leading or trailing spaces

SELECT 
first_name,
TRIM(first_name) AS trim_name
FROM customers


SELECT first_name
FROM customers 
WHERE first_name <> TRIM(first_name)


SELECT first_name,
LEN(first_name) AS len_name,
LEN(TRIM(first_name))  AS len_trim_name,
LEN(first_name) - LEN(TRIM(first_name)) AS flag
FROM customers 
WHERE LEN(first_name) <> LEN(TRIM(first_name))



-- REPLACE


-- Remove dashes (-) from a phone numbeer

SELECT  
'123-456-7890' AS phone,
REPLACE('123-456-7890','-','') AS clean_phone

-- Replace FILE extence from txt to csv

SELECT 
'report.txt' AS old_filename,
REPLACE('report.txt', '.txt', '.csv') AS new_filename




---- LEN ----

-- Calculate the length of each cusomer's first name

SELECT 
first_name,
LEN(first_name) AS len_name
FROM customers



--- LEFT & RIGHT ---

-- Retrieve the first two characters of each first name

SELECT 
first_name,
LEFT(TRIM(first_name),2) AS first_2_char
FROM customers

-- Retrieve the last two characters of each first name


SELECT 
first_name,
LEFT(TRIM(first_name),2) AS first_2_char,
RIGHT(TRIM(first_name),2) AS last_2_char
FROM customers


-- SUBSTRING(VALUE, START. LENGTH)--

-- Retrieve a list of customers first names removing the first character

SELECT 
first_name,
SUBSTRING(TRIM(first_name), 2,LEN(first_name)) AS sub_name
FROM customers
