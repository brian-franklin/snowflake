/*
    This should be executed for each inbound data share database.
*/
--use role accountadmin;
--Create Database from Share
--CREATE DATABASE <name> FROM SHARE <share>;

set db_name = '<name>';
set role_name = CONCAT($db_name, '_SHARE_READER');

use role securityadmin;
--Create Share Reader Role
CREATE ROLE IF NOT EXISTS IDENTIFIER($role_name);

--Grants
GRANT IMPORTED PRIVILEGES ON DATABASE IDENTIFIER($db_name) TO ROLE IDENTIFIER($role_name);
