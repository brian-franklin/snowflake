/*
  Snowsight - create table from file

0. Change your role to 'DBO_TRAINING_RAW_CONTRIBUTOR'
1. Select Databases
2. Select RAW schema from the TRAINING database
3. Click 'Create' -> 'Table' -> 'From file'
4. Browse for the file, 'LENDER_HOLDINGS_SAMPLE.CSV'
  - confirm the correct namespace: TRAINING.RAW
  - Enter a name, 'LENDER_HOLDINGS'
  - Click 'next'
5. Confirm
  - file format: 'csv'
  - Select on error: 'only load valid data'
  - columns
6. Click 'Show SQL', notice...
  - temporary file format
  - the from location is using a stage on the schema
  - the on error setting
7. Click 'Hide SQL'
8. Click 'Load'
9. Click 'Done'
10. Notice the privileges on the new table
  - future grants applied
*/
/*
  Create table with SQL, then load from Snowsight

1. New worksheet and copy in script
2. IMPORTANT
  - setting the correct role
3. Run the script
4. Select Databases
2. Select RAW schema from the TRAINING database
3. Select the lender_holdings table -> click 'Load Data'
4. Browse for the csv file -> 'Next'
5. File format options
  - header: skip first line
  - trim space: true
  On Error: only load valid data
6. Click 'Load'
*/

USE ROLE DBO_TRAINING_RAW_CONTRIBUTOR;
USE WAREHOUSE TRAINING_WH;

USE DATABASE TRAINING;
USE SCHEMA RAW;

CREATE OR REPLACE TRANSIENT TABLE "TRAINING"."RAW"."LENDER_HOLDINGS" (
    PROPERTYNAME VARCHAR,
    ADDRESS_TX VARCHAR,
    PRINCIPAL_ENTITY_ID NUMBER(38, 0),
    PRINCIPAL_ENTITY_TX VARCHAR,
    BORROWER_ENTITY_ID NUMBER(38, 0),
    BORROWER_ENTITY_TX VARCHAR,
    BORROWER_INVESTOR_GROUP_TX VARCHAR,
    BORROWER_INVESTOR_TYPE_TX VARCHAR,
    PROPERTY_ID NUMBER(38, 0),
    DEAL_ID NUMBER(38, 0),
    LOAN_ID NUMBER(38, 0),
    LOAN_ASSET_ID NUMBER(38, 0),
    LOAN_STATUS VARCHAR,
    PROPERTY_MAIN_TYPE_TX VARCHAR,
    PROPERTY_RCA_MARKET_TX VARCHAR,
    PROPERTY_CITY_TX VARCHAR,
    PROPERTY_STATE_PROV_TX VARCHAR,
    PROPERTY_COUNTRY_TX VARCHAR,
    LOAN_ORIG_DT TIMESTAMP_NTZ,
    LOAN_PURPOSE VARCHAR,
    LOAN_AMT_MILLIONS_USD NUMBER(38, 2),
    LOAN_TYPE_TX VARCHAR,
    ORIGINAL_LOAN_MATURITY_DT TIMESTAMP_NTZ,
    UPCOMING_MATURITY_DT VARCHAR,
    LOAN_TERM_MONTHS NUMBER(38, 0),
    LENDER_INTEREST_RATE_NB NUMBER(38, 4),
    LENDER_INT_RATE_TYPE_TX VARCHAR,
    VARIABLE_RATE_INDEX_TX VARCHAR,
    VARIABLE_RATE_SPREAD_NB VARCHAR,
    VARIABLE_RATE_INDEX_OTHER_NOTES_TX VARCHAR,
    LENDER_COMMENTS_TX VARCHAR,
    LOAN_INT_METHOD_TX VARCHAR,
    LOAN_CROSS_DEFAULT_FG BOOLEAN,
    LOAN_PI_PAYMENT_AMT NUMBER(38, 0),
    LOAN_ORIG_IO_TERMS_NB NUMBER(38, 0),
    LOAN_INT_METHOD_IO_TX VARCHAR,
    LOAN_AMORT_ORIG_NB NUMBER(38, 0),
    LOAN_DSCR_NB VARCHAR,
    LOAN_LTV_ORIG_NB VARCHAR,
    LOAN_PREPAY_TX VARCHAR,
    MORT_BROKERAGE_NAME VARCHAR,
    BUYER_ASSUMED_DEBT_FG BOOLEAN,
    CMBS_FG BOOLEAN
);

SELECT * FROM LENDER_HOLDINGS;