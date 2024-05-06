# User Management

Roles and Users can be managed in Snowsight through the UI or using SQL.

Primary SQL commands are:

- [CREATE USER](https://docs.snowflake.com/en/sql-reference/sql/create-user)
- [ALTER USER](https://docs.snowflake.com/en/sql-reference/sql/alter-user)

```sql
SHOW USERS;

DESC USER <username>;
```

When creating a new user...

- Be sure to set MUST_CHANGE_PASSWORD = TRUE
- Consider providing values for the following properties
  - Login Name if not using User Name for login
  - Display Name
  - First Name and Last Name
  - Email
  - Default Role, Default Warehouse and Default Namespace

### Disable User

In Snowsight, select Admin -> Users & Roles

Click ... for the user -> select Disable User

In SQL:

```sql
ALTER USER <username> SET DISABLED = TRUE;
```

## Password Reset

Users can change their password using Snowsight. Locked out users require another with the ALTER USER privilege to set a new password.
Use **ALTER USER** on the user with **MUST_CHANGE_PASSWORD = TRUE**, or using:

```sql
ALTER USER <username> RESET PASSWORD;
```

Generates a URL valid for 4 hours for the users to reset their password.

Note: Only a user with the ACCOUNTADMIN role can reset the password for another ACCOUNTADMIN user when locked out.

----

## Federated Authentication

- Can still allow login using username and password (if a login name and password are set for the user)
- Snowflake allows Account and Security Admins to create users with passwords
- It is not recommended to allow users to maintain separate Snowflake credentials
  
**Create users with no password to disable Snowflake authentication. This forces the user through federated authentication.**

- Users with the ACCOUNTADMIN role SHOULD have Snowflake passwords to allow access even when federated auth is unavailable.
- When creating other users, set the MUST_CHANGE_PASSWORD option = FALSE

![image](/images/rbac-federated-auth.png)

## Granting accessing to new users with RBAC

- Once a user is created, they will need to be granted the roles created in the RBAC security model.
- When adding an entirely new group of users that require additional database roles, be sure to create the new roles in the RBAC model and then grant the appropriate roles to the new users

Useful SQL to review existing RBAC security model:

```sql
USE ROLE SECURITYADMIN;

-- all roles
SHOW ROLES;

-- List all account-level privileges granted to roles
SHOW GRANTS ON ACCOUNT;

-- List users and roles to which a ROLE has been granted
SHOW GRANTS OF ROLE DBO_TRAINING_RAW_CONTRIBUTOR;

-- List roles granted to a USER
SHOW GRANTS TO USER <username>;

-- List roles and privileges granted to a ROLE
SHOW GRANTS TO ROLE DBO_TRAINING_RAW_CONTRIBUTOR;

-- List all privileges on new objects within databases and schemas
SHOW FUTURE GRANTS TO ROLE DBO_TRAINING_RAW_CONTRIBUTOR;

-- List all privileges on new objects in a database to roles
SHOW FUTURE GRANTS IN DATABASE TRAINING;

-- List all privileges on new objects in a database schema to roles
SHOW FUTURE GRANTS IN SCHEMA TRAINING.RAW;
```
