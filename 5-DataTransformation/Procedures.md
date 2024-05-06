# Procedures

Created using SQL, but can be written using different handler languages, you can use programmatic constructs to perform branching and looping

1) [Procedures Overview](https://docs.snowflake.com/en/developer-guide/stored-procedure/stored-procedures-overview)
2) [Working with Procedures](https://docs.snowflake.com/en/developer-guide/stored-procedure/stored-procedures-usage)

### Languages
- Javascript
- Snowflake scripting - SQL ([Develpoper Guide](https://docs.snowflake.com/en/developer-guide/snowflake-scripting/index))
- Snowpark API (supports in-line and staged handlers)
  - Python
  - Java
  - Scala

### Development Considerations
- [Names and Overloading](https://docs.snowflake.com/en/developer-guide/udf-stored-procedure-naming-conventions)
  - Schema-level objects
  - Length, including the return type and names of all arguments, must not exceed 10kb
  - Maximum stack depth for nested procedures is 5, including the top-level procedure
  - Overloading a procedure by varying the arguments, the types of arguments or both
![image](/images/5-proc-overload.png)

- [Arguments](https://docs.snowflake.com/en/developer-guide/udf-stored-procedure-arguments)
  - Limited to 500
  - Specify the data type
  - Specify a default value to make an argument optional
    - **Note:** You cannot overload a procedure that has a single optional argument
![image](/images/5-proc-arguments.png)

- [Data Type Mappings](https://docs.snowflake.com/en/developer-guide/udf-stored-procedure-data-type-mapping)
  - SQL data types are converted between SQL and the handler types for arguments and return values

- [Staging Dependencies](https://docs.snowflake.com/en/developer-guide/upload-dependencies)
  - To leverage external code, the dependency can be uploaded to a stage
![image](/images/5-proc-deps.png)

- [Transactions](https://docs.snowflake.com/en/sql-reference/transactions#stored-procedures-and-transactions)
  - Procedures can contain one or more transactions
  - Transactions help ensure related SQL statements are committed or rolled back as a unit.
  - Snowflake does not support nested transactions
    - However, You can call a procedure that contains a transaction from inside a transaction.
      - Keep in mind that you cannot rollback the transaction inside the procedure from the calling transaction
![image](/images/5-proc-trx.png)
![image](/images/5-scoped-transactions-1.png)
![image](/images/5-scoped-transactions-2.png)
![image](/images/5-scoped-transactions-3.png)

### Usage Considerations
- Procedures have 2 privileges: **OWNERSHIP**, **USAGE**
- Determine whether the procedure should run with the Caller's rights or Owners's rights ([link](https://docs.snowflake.com/en/developer-guide/stored-procedure/stored-procedures-rights))
  - Default: owner's rights
- How should the procedure handle errors?
- Store the procedure in a source code repository
- Calling a procedure using the **CALL** command
  - Specify arguments by name or position
![image](/images/5-proc-call.png)
