/*
* CSY2038 Databases 2 - Assignment 2
* Group 5
* Alexander Turner (18416709), Daiana Gusatu (18424099), Laura Ghiorghisor (18408400)
*/

-- @C:\DB-AS2\query.sql
-- @/Users/Laura/csy2038/DB-AS2/query.sql


-- Object table: addresses
SELECT * FROM addresses WHERE street = 'ANDERSON STREET';
-- 17 ALPHA HOUSE (...)

SELECT REF(a) FROM addresses a WHERE street = 'BENJAMIN STREET';
-- 0000280209CD5D6F6CBB9A474F926BF53A1FBEF5900526C1B0293C4BBEACC7A3461368029A018086160001




-- Object column: address in sponsor
SELECT deref(address) FROM locations;
--returns ADDRESS_TYPE(...)

SELECT address FROM sponsors;
-- returns ADDRESS_TYPE(...)

SELECT s.address.house_no, s.address.street, s.address.city, s.address.county, s.address.postcode, s.address.country
FROM sponsors s 
WHERE sponsor_id = 1;
-- 34 COPPER STREET  CAMBRIDGE (...)




-- Nested Table
-- Column Formatting
COLUMN experience_id HEADING ID
COLUMN experience_id FORMAT 999999
COLUMN experience_name HEADING xp|name
COLUMN experience_name FORMAT A20 WORD_WRAPPED
COLUMN no_staff_needed HEADING staff
COLUMN no_staff_needed FORMAT 999999
COLUMN cost HEADING cost
COLUMN cost FORMAT 999999
COLUMN activity_name FORMAT A25
COLUMN activity_date LIKE experience_name HEADING date
-- BREAK ON experience_id, or:
BREAK ON activity_name

-- multiple object query: simple varray and nested table
SELECT e.experience_id, e.experience_name, a.activity_name, a.cost, a.no_staff_needed, d.*
FROM experiences e, TABLE (e.activities) a, TABLE(a.activity_date) d
WHERE experience_id = 2; 


SELECT e.experience_id,  a.activity_name 
FROM experiences e, TABLE (e.activities) a 
WHERE a.activity_name LIKE '%DRINK%';
-- gives all experiences that include the string 'DRINK'

SELECT e.experience_id, COUNT(a.activity_name) 
FROM experiences e, TABLE (e.activities) a
GROUP BY experience_id;
-- gives the number of activities per experience




-- Simple VARRAY
SELECT ticket_number, d.*
FROM tickets t, TABLE (t.ticket_date) d
WHERE ticket_number = 1;




-- Varray 
-- Column formatting
-- CLEAR COLUMNS 
COLUMN sponsor_id FORMAT 999999
COLUMN postcode FORMAT A7 
COLUMN country FORMAT A10 
COLUMN firstname FORMAT A10 
COLUMN contact_form FORMAT A10 
COLUMN details FORMAT A10 WORD_WRAPPED
COLUMN comments FORMAT A10 WORD_WRAPPED
BREAK ON sponsor_id


SELECT sponsor_id, sponsor_firstname, s.address.postcode, s.address.country, c.contact_form, c.details, c.comments
FROM sponsors s, TABLE (s.contact) c
WHERE sponsor_id = 1;
-- prints address and contacts


SELECT sponsor_id, sponsor_firstname, c.*
FROM sponsors s, TABLE (s.contact) c
WHERE sponsor_id = 1;
-- prints all contacts




-- Queries with SQL functions
SELECT COUNT(*) FROM tickets 
WHERE sponsor_id = 1 AND experience_id = 1;
-- 1

SELECT MAX (price)
FROM tickets;
-- 260

SELECT MIN (price)
FROM tickets
WHERE experience_id = 4;
-- 45

SELECT AVG(a.no_staff_needed)
FROM experiences e, TABLE(e.activities) a
WHERE experience_id = 1;
-- 2

SELECT SUM(a.no_staff_needed)
FROM experiences e, TABLE(e.activities) a
WHERE experience_id = 4;
-- 4

