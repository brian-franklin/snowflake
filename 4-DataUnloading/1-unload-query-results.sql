/*
In Snowsight...

1. Create a new SQL worksheet
2. Write/run a query

*/

USE ROLE DBO_TRAINING_RAW_READER;
USE WAREHOUSE TRAINING_WH;
USE DATABASE TRAINING;
USE SCHEMA RAW;

SELECT * FROM LENDER_HOLDINGS; 

/*

3. From the results pane
  - Click 'Download results'
  - Select a file type
4. Open the downloaded file 

*/