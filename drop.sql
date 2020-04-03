/*
* CSY2038 Databases 2 - Assignment 2
* Group 5
* Alexander Turner (18416709), Daiana Gusatu (18424099), Laura Ghiorghisor (18408400)
*/

-- @C:\DB-AS2\drop.sql
-- @/Users/Laura/csy2038/DB-AS2/drop.sql




-- DROP FUNCTIONS (and testing procedures)




-- DROP FUNCTIONS
DROP FUNCTION func_staff_total;
DROP FUNCTION func_duration;
DROP FUNCTION func_xp_price_avg;
DROP FUNCTION func_takings_total;
DROP FUNCTION func_annual_takings_total;
DROP FUNCTION func_season;
DROP FUNCTION func_xp_name;
DROP FUNCTION func_sponsor_name;
DROP FUNCTION func_print_location_address;
DROP FUNCTION func_get_no_activities;
DROP FUNCTION func_make_upper;


-- Drop procedures
DROP PROCEDURE proc_print_sponsor_address;
DROP PROCEDURE proc_xp_sponsors;
DROP PROCEDURE proc_find_sponsor_by_address;
DROP PROCEDURE proc_list_xp_activities;
DROP PROCEDURE proc_calc_annual_takings;
DROP PROCEDURE proc_lowest_avg_price;
DROP PROCEDURE proc_highest_grossing;
DROP PROCEDURE proc_xp_duration;
DROP PROCEDURE proc_staff_total;
DROP PROCEDURE proc_start_end_date;
DROP PROCEDURE proc_print_experience_details;
DROP PROCEDURE proc_xp_season;

-- DROP Procedures used for testing
DROP PROCEDURE proc_upper;
DROP PROCEDURE proc_get_no_activities;
DROP PROCEDURE proc_print_location_address;
DROP PROCEDURE proc_test_season;
DROP PROCEDURE proc_sponsor_name;
DROP PROCEDURE proc_xp_name;
DROP PROCEDURE proc_xp_annual_takings_total;
DROP PROCEDURE proc_xp_takings_total;
DROP PROCEDURE proc_xp_price_avg;
DROP PROCEDURE proc_test_duration;
DROP PROCEDURE proc_staff_total;

-- DROP TRIGGERS

DROP TRIGGER trig_loc_insert_success;
DROP TRIGGER trig_xp_predicates;
DROP TRIGGER trig_pk_sponsor_no_update;
DROP TRIGGER trig_upper_firstname;
DROP TRIGGER trig_sponsors_reg_date;
DROP TRIGGER trig_security;
DROP TRIGGER trig_delete_sponsor;
DROP TRIGGER trig_schema_delete;
DROP TRIGGER trig_db_hello;
DROP TRIGGER trig_user_log;



-- DROP SEQUENCES
DROP SEQUENCE seq_tickets;
DROP SEQUENCE seq_experiences;
DROP SEQUENCE seq_experience_nature;
DROP SEQUENCE seq_locations;
DROP SEQUENCE seq_sponsors;

-- DROP FOREIGN KEYS
ALTER TABLE tickets
DROP CONSTRAINT fk_t_sponsors;

ALTER TABLE tickets
DROP CONSTRAINT fk_t_experiences;

ALTER TABLE experiences
DROP CONSTRAINT fk_e_locations;

ALTER TABLE experiences
DROP CONSTRAINT fk_e_experience_nature;

-- DROP PRIMARY KEYS
ALTER TABLE tickets
DROP CONSTRAINT pk_tickets;

ALTER TABLE sponsors
DROP CONSTRAINT pk_sponsors;

ALTER TABLE experience_nature
DROP CONSTRAINT pk_experience_nature;

ALTER TABLE locations
DROP CONSTRAINT pk_locations;


ALTER TABLE experiences
DROP CONSTRAINT pk_experiences;

ALTER TABLE userlog
DROP CONSTRAINT pk_userlog;


-- DROP CHECK, UNIQUE and DEFAULT CONSTRAINTS

ALTER TABLE sponsors
DROP CONSTRAINT ck_sponsor_surname;

ALTER TABLE sponsors
DROP CONSTRAINT ck_company_name;

ALTER TABLE experiences
DROP CONSTRAINT ck_season;

ALTER TABLE tickets
DROP CONSTRAINT ck_price;

ALTER TABLE sponsors
MODIFY registration_date DEFAULT NULL;

ALTER TABLE experience_nature
DROP CONSTRAINT uq_xp_nature_name;

-- DROP TABLES
DROP TABLE tickets;
DROP TABLE locations;
DROP TABLE sponsors;
DROP TABLE experience_nature;
DROP TABLE experiences;
DROP TABLE addresses;
DROP TABLE userlog;

-- DROP TYPES
DROP TYPE activity_table_type;
DROP TYPE activity_type;
DROP TYPE contact_varray_type;
DROP TYPE contact_type;
DROP TYPE date_varray_type;
DROP TYPE address_type;

-- COMMIT CHANGES
PURGE RECYCLEBIN;
COMMIT;
