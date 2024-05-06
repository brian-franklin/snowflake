/*

Use Snow SQL CLI to load the file to the named stage:

PUT file://c:\data\starwood\rome_hotels.json @STAGE_TRAINING_RAW;

*/

-- Use Snowsight or SQL below to load the data into a table
/*
 Snowsight
  - Set role to DBO_TRAINING_RAW_CONTRIBUTOR
  - Navigate to the stage
  - Find the file rome_hotels.json.gz -> click the dots to 'Load data into a table'
  - Create new table, 'ROME_HOTELS'
  - Format: JSON
  - Format Options:
    - Strip outer array: true
  - On Error: only load valid data
  - Schema:
    - airbnb_com: variant
    - booking_com: variant
    - hotels_com: variant

*/

-- SQL

USE ROLE DBO_TRAINING_RAW_CONTRIBUTOR;
USE WAREHOUSE TRAINING_WH;

USE DATABASE TRAINING;
USE SCHEMA RAW;

CREATE TABLE TRAINING.RAW.ROME_HOTELS (
  airbnbhotels VARIANT NULL
  ,bookinghotels VARIANT NULL
  ,hotelscomhotels VARIANT NULL
);

COPY INTO TRAINING.RAW.ROME_HOTELS
FROM @TRAINING.RAW.STAGE_TRAINING_RAW
FILES = ('rome_hotels.json.gz')
FILE_FORMAT = (
    TYPE=JSON,
    STRIP_OUTER_ARRAY=TRUE,
    REPLACE_INVALID_CHARACTERS=TRUE,
    DATE_FORMAT=AUTO,
    TIME_FORMAT=AUTO,
    TIMESTAMP_FORMAT=AUTO
)
MATCH_BY_COLUMN_NAME=CASE_INSENSITIVE
ON_ERROR=CONTINUE;

SELECT * FROM ROME_HOTELS LIMIT 100;

/* Example Query of JSON data*/
SELECT airbnbhotels
    ,t.value:title::string as TITLE
    ,t.value:subtitles[0]::string as SUBTITLE
    ,t.value:link::string as URL
    ,t.value:rating::string as RATING
    ,t.value:price:currency::string as CURRENCY
FROM ROME_HOTELS
,lateral flatten(input => airbnbhotels) t
where t.value:title::string = 'Apartment in Rome'
limit 100;