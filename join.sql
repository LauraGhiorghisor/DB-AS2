/*
* CSY2038 Databases 2 - Assignment 2
* Group 5
* Alexander Turner (18416709), Daiana Gusatu (18424099), Laura Ghiorghisor (18408400)
*/

-- @C:\DB-AS2\join.sql
-- @/Users/Laura/csy2038/DB-AS2/join.sql
-- @C:\Users\Daiana\Desktop\joins.txt

--Joins

--2 Table Join
SELECT l.location_id, l.address, e.experience_name, e.season
FROM locations l
JOIN experiences e
ON l.location_id = e.location_id
WHERE e.location_id = 1;
--Returns 1 row

--3 Table Join
SELECT sponsors.sponsor_id, sponsors.sponsor_surname, experiences.experience_name
FROM sponsors
JOIN tickets
ON sponsors.sponsor_id = tickets.sponsor_id
JOIN experiences
ON experiences.experience_id = tickets.experience_id;
--Returns 5 rows

--Full Outer Join
SELECT experience_nature.experience_nature_id, experience_nature.experience_nature_name, experiences.experience_name, locations.location_id
FROM experience_nature
FULL OUTER JOIN experiences
ON experience_nature.experience_nature_id = experiences.experience_nature_id
FULL OUTER JOIN locations
ON experiences.location_id = locations.location_id
ORDER BY location_id;
--Returns 5 rows

--LEFT JOIN
SELECT e.experience_id, e.experience_name, t.price
FROM experiences e
LEFT JOIN tickets t
ON e.experience_id = t.experience_id
WHERE price > 100.00
AND e.experience_name LIKE 'H%';
--Returns 1 row

--Right Join
SELECT en.experience_nature_name, e.experience_id, e.experience_name, e.activities
FROM experiences e
RIGHT JOIN experience_nature en
ON e.experience_nature_id = en.experience_nature_id
WHERE e.experience_id = 4;
--Returns 1 row

--UNION
SELECT e.experience_id, e.location_id
FROM experiences e
UNION
SELECT t.ticket_number, t.price
FROM tickets t
WHERE t.price < 300 AND t.price > 40;
--7 rows returned

SELECT sponsor_id
FROM sponsors
WHERE sponsor_surname LIKE 'D_'
UNION
SELECT ticket_number
FROM tickets
WHERE experience_id > 2
AND price > 20;
--Returns 6 rows

SELECT house_no, postcode, country
FROM addresses
MINUS(
      SELECT s.address.street, s.address.city, s.address.county
	  FROM sponsors s
	  WHERE s.address.county != 'CAMBRIDGESHIRE'
	  UNION 
	  SELECT l.address.street, l.address.city, l.address.county
	  FROM locations l
	  WHERE L.address.county != 'CAMBRIDGESHIRE');
--Returns 5 rows

SELECT house_no, street, postcode
FROM addresses
INTERSECT(
          SELECT l.address.street, l.address.city, l.address.county
		  FROM locations l 
		  WHERE l.address.street = 'DOLBY STREET'
		  UNION
		  SELECT s.address.street, s.address.city, s.address.county
	      FROM sponsors s);
--No rows returned


--SUB-QUERIES

--Union based on address
SELECT a.city, a.country
FROM addresses a
WHERE country NOT IN(
     SELECT l.address.city
	 FROM locations l
	 UNION
	 SELECT s.address.city
	 FROM sponsors s
	 WHERE country = 'UK');
--5 rows returned

--Exists value from a Join	 
SELECT e.experience_id, e.activities
FROM experiences e
WHERE EXISTS(
             SELECT t.ticket_number, t.price, s.sponsor_surname
			 FROM sponsors s
			 JOIN tickets t
			 ON s.sponsor_id = t.sponsor_id
			 WHERE t.price > 150
			 AND s.sponsor_firstname IS NOT NULL);
--3 rows returned

--Sponsors not in Addresses		 
SELECT s.sponsor_id, s.sponsor_surname, s.contact	
FROM sponsors s
WHERE s.address.city NOT IN(
			         SELECT l.address.street
                     FROM locations l
					 WHERE l.address.country = 'UK')
ORDER BY s.sponsor_id;
--Returns 5 rows

--Nested Varray query					 
SELECT t.ticket_number, t.price
FROM tickets t
WHERE EXISTS(
             SELECT s.sponsor_id, c.contact_form, c.details
             FROM sponsors s,
             TABLE (s.contact) c
             WHERE s.sponsor_id = 3);	
--Returned 6 rows			 
					 
SELECT VALUE (e)
FROM THE(
         SELECT activities
		 FROM experiences
		 WHERE experience_id = 1) e;
--Returns 2 activity types
             			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 


