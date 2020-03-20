/*
* CSY2038 Databases 2 - Assignment 2
* Group 5
* Alexander Turner (18416709), Daiana Gusatu (18424099), Laura Ghiorghisor (18408400)
*/

-- @C:\DB-AS2\drop.sql
-- @/Users/Laura/csy2038/DB-AS2/drop.sql


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

-- DROP CHECK, UNIQUE and DEFAULT CONSTRAINTS

ALTER TABLE sponsors
DROP CONSTRAINT ck_sponsor_firstname;

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
