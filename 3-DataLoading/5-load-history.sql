USE ROLE DBO_TRAINING_RAW_CONTRIBUTOR;
USE WAREHOUSE TRAINING_WH;

USE DATABASE TRAINING;
USE SCHEMA RAW;

SELECT  *
FROM information_schema.load_history
ORDER BY last_load_time DESC
LIMIT 10;


/* List and remove staged files */
LIST @~;
LIST @stage_training_raw;

REMOVE @~;
REMOVE @stage_training_raw;