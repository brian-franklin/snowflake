/*
  Required variables:
    db_name
    schema_name
    namespace
		curr_user
*/
set db_name = 'TRAINING';
set schema_name = 'MART';
set namespace = concat_ws('.', $db_name, $schema_name);
set curr_user = CURRENT_USER();

USE ROLE SYSADMIN;
USE WAREHOUSE TRAINING_WH;

--Create Database
CREATE DATABASE IF NOT EXISTS IDENTIFIER($db_name);
USE DATABASE IDENTIFIER($db_name);

--Create Schema
CREATE SCHEMA IF NOT EXISTS IDENTIFIER($schema_name);
USE SCHEMA IDENTIFIER($schema_name);

USE ROLE SECURITYADMIN;

-- CREATE ROLES
--Schema Roles
set s_reader = concat_ws('_', 'DBO', $db_name, $schema_name, 'READER');
set s_contributor = concat_ws('_', 'DBO', $db_name, $schema_name, 'CONTRIBUTOR');
set s_admin = concat_ws('_', 'DBO', $db_name, $schema_name, 'ADMIN');
CREATE ROLE IF NOT EXISTS IDENTIFIER($s_reader);
CREATE ROLE IF NOT EXISTS IDENTIFIER($s_contributor);
CREATE ROLE IF NOT EXISTS IDENTIFIER($s_admin);

--Database Roles
set d_reader = concat_ws('_', 'DBO', $db_name, 'READER');
set d_contributor = concat_ws('_', 'DBO', $db_name, 'CONTRIBUTOR');
set d_admin = concat_ws('_', 'DBO', $db_name, 'ADMIN');
CREATE ROLE IF NOT EXISTS IDENTIFIER($d_reader);
CREATE ROLE IF NOT EXISTS IDENTIFIER($d_contributor);
CREATE ROLE IF NOT EXISTS IDENTIFIER($d_admin);

--ALL_DB Roles
CREATE ROLE IF NOT EXISTS DBO_ALL_DB_READER;
CREATE ROLE IF NOT EXISTS DBO_ALL_DB_CONTRIBUTOR;
CREATE ROLE IF NOT EXISTS DBO_ALL_DB_ADMIN;


-- ROLE GRANTS
--Schema Hierarchy
GRANT ROLE IDENTIFIER($s_reader) TO ROLE IDENTIFIER($s_contributor);
GRANT ROLE IDENTIFIER($s_contributor) TO ROLE IDENTIFIER($s_admin);
--Schema to Database
GRANT ROLE IDENTIFIER($s_reader) TO ROLE IDENTIFIER($d_reader);
GRANT ROLE IDENTIFIER($s_contributor) TO ROLE IDENTIFIER($d_contributor);
GRANT ROLE IDENTIFIER($s_admin) TO ROLE IDENTIFIER($d_admin);
--Database Hierarchy
GRANT ROLE IDENTIFIER($d_reader) TO ROLE IDENTIFIER($d_contributor);
GRANT ROLE IDENTIFIER($d_contributor) TO ROLE IDENTIFIER($d_admin);
--Database to All_DB
GRANT ROLE IDENTIFIER($d_reader) TO ROLE DBO_ALL_DB_READER;
GRANT ROLE IDENTIFIER($d_contributor) TO ROLE DBO_ALL_DB_CONTRIBUTOR;
GRANT ROLE IDENTIFIER($d_admin) TO ROLE DBO_ALL_DB_ADMIN;
--ALL_DB Hierarchy
GRANT ROLE DBO_ALL_DB_READER TO ROLE DBO_ALL_DB_CONTRIBUTOR;
GRANT ROLE DBO_ALL_DB_CONTRIBUTOR TO ROLE DBO_ALL_DB_ADMIN;
--ALL_DB to SYSADMIN
GRANT ROLE DBO_ALL_DB_ADMIN TO ROLE SYSADMIN;
	


-- OBJECT GRANTS
USE ROLE SECURITYADMIN;

--READ
	GRANT USAGE ON DATABASE IDENTIFIER($db_name) TO ROLE IDENTIFIER($s_reader);
	GRANT USAGE,MONITOR ON SCHEMA IDENTIFIER($namespace) TO ROLE IDENTIFIER($s_reader);
	GRANT SELECT ON ALL VIEWS IN SCHEMA IDENTIFIER($namespace) TO ROLE IDENTIFIER($s_reader);
	GRANT SELECT ON ALL TABLES IN SCHEMA IDENTIFIER($namespace) TO ROLE IDENTIFIER($s_reader);
	GRANT SELECT ON ALL EXTERNAL TABLES IN SCHEMA IDENTIFIER($namespace) TO ROLE IDENTIFIER($s_reader);
	GRANT SELECT ON ALL MATERIALIZED VIEWS IN SCHEMA IDENTIFIER($namespace) TO ROLE IDENTIFIER($s_reader);
	GRANT USAGE ON ALL STAGES IN SCHEMA IDENTIFIER($namespace) TO ROLE IDENTIFIER($s_reader);
	GRANT USAGE ON ALL FILE FORMATS IN SCHEMA IDENTIFIER($namespace) TO ROLE IDENTIFIER($s_reader);
	GRANT SELECT ON ALL STREAMS IN SCHEMA IDENTIFIER($namespace) TO ROLE IDENTIFIER($s_reader);

	--FUTURE
	GRANT SELECT ON FUTURE VIEWS IN SCHEMA IDENTIFIER($namespace) TO ROLE IDENTIFIER($s_reader);
	GRANT SELECT ON FUTURE TABLES IN SCHEMA IDENTIFIER($namespace) TO ROLE IDENTIFIER($s_reader);
	GRANT SELECT ON FUTURE EXTERNAL TABLES IN SCHEMA IDENTIFIER($namespace) TO ROLE IDENTIFIER($s_reader);
	GRANT SELECT ON FUTURE MATERIALIZED VIEWS IN SCHEMA IDENTIFIER($namespace) TO ROLE IDENTIFIER($s_reader);
	GRANT USAGE ON FUTURE STAGES IN SCHEMA IDENTIFIER($namespace) TO ROLE IDENTIFIER($s_reader);
	GRANT READ ON FUTURE STAGES IN SCHEMA IDENTIFIER($namespace) TO ROLE IDENTIFIER($s_reader);
	GRANT USAGE ON FUTURE FILE FORMATS IN SCHEMA IDENTIFIER($namespace) TO ROLE IDENTIFIER($s_reader);
	GRANT SELECT ON FUTURE STREAMS IN SCHEMA IDENTIFIER($namespace) TO ROLE IDENTIFIER($s_reader);


--CONTRIBUTOR
	GRANT INSERT, UPDATE, DELETE, TRUNCATE ON ALL TABLES IN SCHEMA IDENTIFIER($namespace)  TO ROLE IDENTIFIER($s_contributor);
	GRANT USAGE ON ALL PROCEDURES IN SCHEMA IDENTIFIER($namespace)  TO ROLE IDENTIFIER($s_contributor);
	GRANT CREATE VIEW ON SCHEMA IDENTIFIER($namespace) TO ROLE IDENTIFIER($s_contributor);
	GRANT CREATE TABLE ON SCHEMA IDENTIFIER($namespace) TO ROLE IDENTIFIER($s_contributor);
	GRANT CREATE TEMPORARY TABLE ON SCHEMA IDENTIFIER($namespace) TO ROLE IDENTIFIER($s_contributor);
	GRANT CREATE PROCEDURE ON SCHEMA IDENTIFIER($namespace) TO ROLE IDENTIFIER($s_contributor);

  --FUTURE
	GRANT INSERT, UPDATE, DELETE, TRUNCATE ON FUTURE TABLES IN SCHEMA IDENTIFIER($namespace) TO ROLE IDENTIFIER($s_contributor);
	GRANT READ, WRITE ON FUTURE STAGES IN SCHEMA IDENTIFIER($namespace) TO ROLE IDENTIFIER($s_contributor);
	GRANT USAGE ON FUTURE PROCEDURES IN SCHEMA IDENTIFIER($namespace)  TO ROLE IDENTIFIER($s_contributor);

	
--ADMIN
	GRANT ALL PRIVILEGES ON SCHEMA IDENTIFIER($namespace) TO ROLE IDENTIFIER($s_admin);
	GRANT USAGE ON ALL PROCEDURES IN SCHEMA IDENTIFIER($namespace) TO ROLE IDENTIFIER($s_admin);
	GRANT USAGE ON ALL FUNCTIONS IN SCHEMA IDENTIFIER($namespace) TO ROLE IDENTIFIER($s_admin);
	GRANT CREATE EXTERNAL TABLE ON SCHEMA IDENTIFIER($namespace) TO ROLE IDENTIFIER($s_admin);
	GRANT CREATE FILE FORMAT ON SCHEMA IDENTIFIER($namespace) TO ROLE IDENTIFIER($s_admin);
	GRANT CREATE FUNCTION ON SCHEMA IDENTIFIER($namespace) TO ROLE IDENTIFIER($s_admin);
	GRANT CREATE MASKING POLICY ON SCHEMA IDENTIFIER($namespace) TO ROLE IDENTIFIER($s_admin);
	GRANT CREATE MATERIALIZED VIEW ON SCHEMA IDENTIFIER($namespace) TO ROLE IDENTIFIER($s_admin);
	GRANT CREATE PIPE ON SCHEMA IDENTIFIER($namespace) TO ROLE IDENTIFIER($s_admin);
	GRANT CREATE PROCEDURE ON SCHEMA IDENTIFIER($namespace) TO ROLE IDENTIFIER($s_admin);
	GRANT CREATE ROW ACCESS POLICY ON SCHEMA IDENTIFIER($namespace) TO ROLE IDENTIFIER($s_admin);
	GRANT CREATE SEQUENCE ON SCHEMA IDENTIFIER($namespace) TO ROLE IDENTIFIER($s_admin);
	GRANT CREATE STAGE ON SCHEMA IDENTIFIER($namespace) TO ROLE IDENTIFIER($s_admin);
	GRANT CREATE STREAM ON SCHEMA IDENTIFIER($namespace) TO ROLE IDENTIFIER($s_admin);
	GRANT CREATE TAG ON SCHEMA IDENTIFIER($namespace) TO ROLE IDENTIFIER($s_admin);
	GRANT CREATE TASK ON SCHEMA IDENTIFIER($namespace) TO ROLE IDENTIFIER($s_admin);
	
  --FUTURE
	GRANT USAGE ON FUTURE PROCEDURES IN SCHEMA IDENTIFIER($namespace) TO ROLE IDENTIFIER($s_admin);
	GRANT USAGE ON FUTURE FUNCTIONS IN SCHEMA IDENTIFIER($namespace) TO ROLE IDENTIFIER($s_admin);	


-- Warehouse usage
GRANT ROLE TRAINING_WH_USAGE TO ROLE IDENTIFIER($s_reader);
	
select 'DATABASE SCHEMA CREATED: ' || $namespace as message;

-- Assign user to All Admin role
GRANT ROLE DBO_ALL_DB_ADMIN TO USER IDENTIFIER($curr_user);

-- Assign access to TRAINING.RAW
select $s_contributor;
GRANT ROLE DBO_TRAINING_RAW_READER TO ROLE IDENTIFIER($s_contributor);