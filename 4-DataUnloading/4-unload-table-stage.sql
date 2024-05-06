USE ROLE DBO_TRAINING_RAW_CONTRIBUTOR;
USE WAREHOUSE TRAINING_WH;
USE DATABASE TRAINING;
USE SCHEMA RAW;

SHOW STAGES;
LIST @%lender_holdings;

SELECT * FROM TRAINING.RAW.LENDER_HOLDINGS;


/* Named Stage */
COPY INTO @%lender_holdings/unload/lender_holdings.csv.gz
FROM LENDER_HOLDINGS
FILE_FORMAT = (
    TYPE = CSV
)
HEADER = TRUE
OVERWRITE = TRUE
SINGLE = TRUE;

LIST @%lender_holdings/unload/ pattern='lender_holdings.*';


REMOVE @%lender_holdings/unload/ pattern='lender_holdings.*';

/*
In SnowSQL:

GET @%lender_holdings/unload/ file://c:\data\starwood\lender_holdings;
*/
