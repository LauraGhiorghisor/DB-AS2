/*
* CSY2038 Databases 2 - Assignment 2
* Group 5
* Alexander Turner (18416709), Daiana Gusatu (18424099), Laura Ghiorghisor (18408400)
*/

-- @C:\DB-AS2\functions.sql
-- @/Users/Laura/csy2038/DB-AS2/functions.sql
-- @C:\Users\Daiana\Desktop\functions.txt

SET SERVEROUTPUT ON



-- func_staff_total
CREATE OR REPLACE FUNCTION func_staff_total (in_xp_id IN experiences.experience_id%TYPE) RETURN NUMBER IS

vn_staff_no NUMBER(3);

BEGIN

SELECT SUM(a.no_staff_needed)
INTO vn_staff_no
FROM experiences e, TABLE (e.activities) a
WHERE experience_id = in_xp_id;


RETURN vn_staff_no;

END func_staff_total;
/
SHOW ERRORS;

-- procedure to test func_staff_total
CREATE OR REPLACE PROCEDURE proc_staff_total IS

BEGIN 

	DBMS_OUTPUT.PUT_LINE ('The total number of staff required for experience of id 1 is ' || func_staff_total(1));

END proc_staff_total;
/
EXECUTE proc_staff_total




-- func_duration
CREATE OR REPLACE FUNCTION func_duration (in_start_date DATE, in_end_date DATE) RETURN NUMBER IS

vn_months NUMBER(5);

BEGIN

vn_months := MONTHS_BETWEEN(in_start_date, in_end_date);
DBMS_OUTPUT.PUT_LINE(vn_months);
RETURN FLOOR(vn_months/24);

END func_duration;
/
SHOW ERRORS;

-- procedure to test func_duration
CREATE OR REPLACE PROCEDURE proc_test_duration IS

BEGIN 

	DBMS_OUTPUT.PUT_LINE ('Duration is ' || func_duration('01-JAN-1991', '02-JAN-1991'));

END proc_test_duration;
/
EXECUTE proc_test_duration







--Minimum price for an experience
CREATE OR REPLACE FUNCTION func_xp_price_min
RETURN NUMBER IS 
      vn_price_min NUMBER(9,2);
	
	  BEGIN
	       SELECT MIN(price)
		   INTO vn_price_min
		   FROM tickets;

		   RETURN vn_price_min;

	  END func_xp_price_min;
/
		   
SHOW ERRORS;

--Procedure to test function func_xp_price_min
CREATE OR REPLACE PROCEDURE proc_xp_price_min IS

    vn_min_price NUMBER(9,2);
	vv_xp_name experiences.experience_name%TYPE;

BEGIN
    vn_min_price := func_xp_price_min;

SELECT experience_name 
INTO vv_xp_name
FROM experiences 
WHERE experience_id IN (
	SELECT  experience_id
	FROM tickets
	WHERE price = vn_min_price);

	DBMS_OUTPUT.PUT_LINE ('Minimum price is ' || vn_min_price || ' for the experience ' || vv_xp_name);
END proc_xp_price_min;
/
EXECUTE proc_xp_price_min

SHOW ERRORS;



-- Total of tickets takings per experience

CREATE OR REPLACE FUNCTION func_takings_total (in_xp_id IN experiences.experience_id%TYPE) 
RETURN NUMBER IS

vn_takings_total NUMBER(20);
	  
BEGIN
SELECT SUM(price)
INTO vn_takings_total
FROM tickets
WHERE experience_id = in_xp_id;
		   
RETURN vn_takings_total;

END func_takings_total;
/
		  
SHOW ERRORS;

--Procedure to test function func_takings_total
CREATE OR REPLACE PROCEDURE proc_xp_takings_total IS
	
BEGIN

	DBMS_OUTPUT.PUT_LINE ('The current takings are  ' || func_takings_total(1) || ' for the given experience.');

END proc_xp_takings_total;
/
EXECUTE proc_xp_takings_total

SHOW ERRORS;




-- Geat season based on date
CREATE OR REPLACE FUNCTION func_season(in_date DATE)
RETURN VARCHAR2 IS
      vv_season experiences.season%TYPE;
	  BEGIN

	    IF EXTRACT(MONTH from in_date) IN (12,1,2) 
		THEN vv_season := 'WINTER';
		ELSIF EXTRACT(MONTH from in_date) IN (3,4,5) 
		THEN vv_season := 'SPRING';
		ELSIF EXTRACT(MONTH from in_date) IN (6,7,8) 
		THEN vv_season := 'WINTER';
		ELSE  vv_season := 'AUTUMN';
		END IF;

	RETURN vv_season;

END func_season;
/
SHOW ERRORS;

-- must use CURSORS here


-- CREATE OR REPLACE PROCEDURE proc_get_season(in_xp_id IN experiences.experience_id%TYPE) IS

--     vc_date DATE;

-- 	  BEGIN

-- 	  date_varray DATE := DATE('01-MAR-2020', '01-APR-2021');
-- 		-- SELECT d.*
-- 		-- FROM experiences e, TABLE (e.activities) a, TABLE(a.activity_date) d)
-- 		-- WHERE experience_id = in_xp_id);

-- 	vc_date := date_varray(1);

-- 	DBMS_OUTPUT.PUT_LINE ('The season for the given experience is ' || func_season(vc_date));
	
-- 	END proc_get_season;
-- /
-- EXEC proc_get_season(1);

-- SHOW ERRORS;	  






--Display country for a selected city

CREATE OR REPLACE FUNCTION func_address_sponsors(in_address VARCHAR2) 
RETURN VARCHAR2 IS
      vc_location VARCHAR2(20);
	  BEGIN
           SELECT s.address.country
	       INTO vc_location
	       FROM sponsors s
	       WHERE s.address.city = in_address;
	       RETURN vc_location;
	  END func_address_sponsors;
/
SHOW ERRORS;


--Procedure to test function func_xp_price_min
CREATE OR REPLACE PROCEDURE proc_address_sponsors(in_address VARCHAR2) IS
vc_location VARCHAR2(20);
	
BEGIN
    vc_location := func_address_sponsors(in_address);
	DBMS_OUTPUT.PUT_LINE (vc_location);
END proc_get_address;
/
EXEC proc_address_sponsors('KETTERING')

SHOW ERRORS; 






 
--Return number of activities in an experience
CREATE OR REPLACE FUNCTION func_get_activities(in_experience_name IN experiences.experience_name%TYPE)
RETURN NUMBER IS
      vn_activities NUMBER(2);
      BEGIN
	     SELECT COUNT(a.activity_name)
	     INTO vn_activities
	     FROM experiences e,
	     TABLE (e.activities) a
	     WHERE e.experience_name = in_experience_name;
	     RETURN vn_activities;
	  END;
/

SHOW ERRORS;
 
--Procedure to test function func_get_activities 
CREATE OR REPLACE PROCEDURE proc_activities(in_experience_name IN experiences.experience_name%TYPE) IS
vn_activities NUMBER(2);
	
BEGIN
    vn_activities := func_get_activities(in_experience_name);
	DBMS_OUTPUT.PUT_LINE ('There are ' || vn_activities || ' activities in the experience ' || in_experience_name);

END proc_activities;
/
EXEC proc_activities('COMEDY NIGHT')

SHOW ERRORS; 






--Display description for a location
CREATE OR REPLACE FUNCTION func_description_location(in_address VARCHAR2) 
RETURN VARCHAR2 IS
      vc_description VARCHAR2(200);
	  BEGIN
           SELECT l.description
	       INTO vc_description
	       FROM locations l
	       WHERE l.address.city = in_address;
	       RETURN vc_description;
	  END func_description_location;
/
SHOW ERRORS;


--Procedure to test function func_description_location
CREATE OR REPLACE PROCEDURE proc_description_location(in_address VARCHAR2) IS
vc_description VARCHAR2(200);
	
BEGIN
    vc_description := func_description_location(in_address);
	DBMS_OUTPUT.PUT_LINE (vc_description);
END proc_description_location;
/
EXEC proc_description_location('BATH')

SHOW ERRORS; 

























