USE ROLE DBO_TRAINING_MART_CONTRIBUTOR;
USE WAREHOUSE TRAINING_WH;
USE DATABASE TRAINING;
USE SCHEMA MART;

/* Procedure with arguments, return value */
CREATE OR REPLACE PROCEDURE TRAINING.MART.DEMO_1_PROC(
    batch_id int,
    message varchar
) 
RETURNS VARCHAR NOT NULL
LANGUAGE SQL
AS
$$
DECLARE
    result varchar;
BEGIN
    SELECT CONCAT_WS(': ', :batch_id, :message) INTO :result;

    RETURN result;
END
$$;

CALL TRAINING.MART.DEMO_1_PROC(99, 'HELLO WORLD');


/* Procedure overloading */
CREATE OR REPLACE PROCEDURE TRAINING.MART.DEMO_1_PROC(
    process_name varchar,
    batch_id int,
    message varchar
) 
RETURNS VARCHAR NOT NULL
LANGUAGE SQL
AS
$$
DECLARE
    result varchar;
BEGIN
    SELECT CONCAT_WS('; ', 'Process: ' || :process_name, 'Batch: ' || :batch_id, 'Message: ' || :message) INTO :result;

    RETURN result;
END
$$;

CALL TRAINING.MART.DEMO_1_PROC('SNOWFLAKE', 99, 'HELLO WORLD');


select * from training.raw.lender_holdings;