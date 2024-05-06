USE ROLE DBO_TRAINING_RAW_READER;
USE WAREHOUSE TRAINING_WH;
USE DATABASE TRAINING;
USE SCHEMA RAW;


/* User Stage */
COPY INTO @~/unload/lender_holdings_unload.csv.gz
FROM LENDER_HOLDINGS
FILE_FORMAT = (
    TYPE = CSV    
)
HEADER = TRUE
OVERWRITE = TRUE
SINGLE = TRUE; 

LIST @~/unload pattern='';


--REMOVE @~/unload pattern='.*unload.*.csv_.*.';

/*
In SnowSQL:

GET @~/unload/lender_holdings_unload.csv.gz file://c:\data\starwood;
*/