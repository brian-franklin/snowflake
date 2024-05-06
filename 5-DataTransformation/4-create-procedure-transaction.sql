/*
  NOTE: Snowflake does not support nested transactions
  However, You can call a procedure that contains a transaction from inside a transaction.
  (Keep in mind that you cannot rollback the transaction inside the procedure from the calling transaction)
*/

USE ROLE DBO_TRAINING_MART_CONTRIBUTOR;
USE WAREHOUSE TRAINING_WH;
USE DATABASE TRAINING;
USE SCHEMA MART;

CREATE OR REPLACE TABLE demo_transaction (
    id int
    ,name varchar 
);

/* Procedure with transactions */
CREATE OR REPLACE PROCEDURE TRAINING.MART.DEMO_3_PROC_TRANSACTIONS() 
RETURNS INT
LANGUAGE SQL
AS
$$
BEGIN
    INSERT INTO demo_transaction VALUES (1, 'outer begin');

    BEGIN TRANSACTION;
        INSERT INTO demo_transaction VALUES (2, 'inner begin'), (3, 'inner begin');
        INSERT INTO demo_transaction VALUES (2, 'inner end'), (3, 'inner end');
    COMMIT;

    BEGIN TRANSACTION;
        INSERT INTO demo_transaction VALUES (4, 'inner begin'), (5, 'inner begin');
        INSERT INTO demo_transaction VALUES (4, 'inner end'), (5, 'inner end');
    ROLLBACK;

    INSERT INTO demo_transaction VALUES (1, 'outer end');    
END;
$$;

CALL TRAINING.MART.DEMO_3_PROC_TRANSACTIONS();

SELECT * FROM demo_transaction;