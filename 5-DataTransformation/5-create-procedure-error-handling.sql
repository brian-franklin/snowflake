USE ROLE DBO_TRAINING_MART_CONTRIBUTOR;
USE WAREHOUSE TRAINING_WH;
USE DATABASE TRAINING;
USE SCHEMA MART;


CREATE OR REPLACE TABLE demo_error_handling (
    value int 
);

/* Procedure with transaction & rollback */
CREATE OR REPLACE PROCEDURE TRAINING.MART.DEMO_4_PROC_EXCEPTION(my_val varchar) 
RETURNS INT
LANGUAGE SQL
AS
$$
BEGIN
    INSERT INTO demo_error_handling VALUES (1);
    INSERT INTO demo_error_handling VALUES (:my_val);
    exception
        WHEN statement_error THEN
            RETURN OBJECT_CONSTRUCT('Error type', 'STATEMENT_ERROR',
                                    'SQLCODE', sqlcode,
                                    'SQLERRM', sqlerrm,
                                    'SQLSTATE', sqlstate);
END;
$$;

CALL DEMO_4_PROC_EXCEPTION('bl');

select * from demo_error_handling;

/* Procedure with transaction & rollback */
CREATE OR REPLACE PROCEDURE TRAINING.MART.DEMO_3_PROC_TRANSACTION_EXCEPTION(my_val varchar) 
RETURNS INT
LANGUAGE SQL
AS
$$
BEGIN
    BEGIN TRANSACTION;
        INSERT INTO demo_error_handling VALUES (1);
        INSERT INTO demo_error_handling VALUES (:my_val);
    COMMIT;
    EXCEPTION
        WHEN OTHER THEN
            ROLLBACK;
END;
$$;

CALL DEMO_3_PROC_TRANSACTION_EXCEPTION('bl');

select * from demo_error_handling;

declare
    my_val varchar := 'blah';
begin
    INSERT INTO demo_error_handling VALUES (1);
    INSERT INTO demo_error_handling VALUES (:my_val);
    exception
        WHEN statement_error THEN
            RETURN OBJECT_CONSTRUCT('Error type', 'STATEMENT_ERROR',
                                    'SQLCODE', sqlcode,
                                    'SQLERRM', sqlerrm,
                                    'SQLSTATE', sqlstate);
end;
