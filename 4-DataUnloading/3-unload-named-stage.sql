USE ROLE DBO_TRAINING_RAW_CONTRIBUTOR;
USE WAREHOUSE TRAINING_WH;
USE DATABASE TRAINING;
USE SCHEMA RAW;

SHOW STAGES;
LIST @stage_training_raw;

SELECT * FROM TRAINING.RAW.LENDER_HOLDINGS;


/* Named Stage */
COPY INTO @stage_training_raw/unload/lender_holdings.csv.gz
FROM LENDER_HOLDINGS
FILE_FORMAT = (
    TYPE = CSV
)
HEADER = TRUE
OVERWRITE = TRUE
SINGLE = TRUE;

LIST @stage_training_raw/unload/ pattern='lender_holdings.*';


REMOVE @stage_training_raw/unload/ pattern='lender_holdings.*';

/*
In SnowSQL:

GET @stage_training_raw/unload/ file://c:\data\starwood\lender_holdings;
*/
