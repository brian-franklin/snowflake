/*
    Requires AccountAdmin privileges.
    
    This should be executed one time in each account to instantiate the admin roles.
*/

USE ROLE securityadmin;

CREATE ROLE IF NOT EXISTS TASK_ADMIN;
CREATE ROLE IF NOT EXISTS POLICY_ADMIN;
CREATE ROLE IF NOT EXISTS TAG_ADMIN;

GRANT ROLE TASK_ADMIN TO ROLE ACCOUNTADMIN;
GRANT ROLE POLICY_ADMIN TO ROLE ACCOUNTADMIN;
GRANT ROLE TAG_ADMIN TO ROLE ACCOUNTADMIN;

-- set the active role to ACCOUNTADMIN before granting the account-level privileges to the new role
USE ROLE accountadmin;

--TASK_ADMIN
GRANT EXECUTE TASK, EXECUTE MANAGED TASK ON ACCOUNT TO ROLE TASK_ADMIN;
--POLICY_ADMIN
GRANT APPLY ROW ACCESS POLICY ON ACCOUNT TO ROLE POLICY_ADMIN;
GRANT APPLY MASKING POLICY ON ACCOUNT TO ROLE POLICY_ADMIN;
--TAG_ADMIN
GRANT APPLY TAG ON ACCOUNT TO ROLE TAG_ADMIN;