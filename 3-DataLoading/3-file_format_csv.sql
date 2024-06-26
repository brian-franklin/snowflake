USE ROLE DBO_TRAINING_RAW_ADMIN;
USE DATABASE TRAINING;
USE SCHEMA RAW;

CREATE OR REPLACE FILE FORMAT TRAINING.RAW.FILE_FORMAT_CSV
  TYPE = CSV
  COMPRESSION = 'AUTO'
  FIELD_DELIMITER = ','
  RECORD_DELIMITER = '\n'
  SKIP_HEADER = 1
  FIELD_OPTIONALLY_ENCLOSED_BY = NONE
  TRIM_SPACE = TRUE
  ERROR_ON_COLUMN_COUNT_MISMATCH = TRUE
  ESCAPE = NONE
  ESCAPE_UNENCLOSED_FIELD = NONE
  DATE_FORMAT = 'AUTO'
  TIMESTAMP_FORMAT = 'AUTO'
  NULL_IF = ('')
  REPLACE_INVALID_CHARACTERS = TRUE
COMMENT = 'File format defintion for loading CSV files with skip header';

SHOW FILE FORMATS;