USE ROLE DBO_TRAINING_MART_CONTRIBUTOR;
USE WAREHOUSE TRAINING_WH;
USE DATABASE TRAINING;
USE SCHEMA MART;

select * from training.raw.lender_holdings;

/* Returns a tables
    Uses variable binding
*/
CREATE OR REPLACE PROCEDURE TRAINING.MART.DEMO_2_PROC_RETURN_TABLE(table_name varchar)
RETURNS TABLE(property_key varchar)
LANGUAGE SQL
AS
$$
    DECLARE
        res RESULTSET;
        query varchar;
    BEGIN  
        query := 'SELECT concat_ws(''-'', property_id, borrower_entity_id, principal_entity_id) FROM IDENTIFIER(?) ORDER BY 1;';
        res := (EXECUTE IMMEDIATE :query USING (table_name));
        
        RETURN TABLE(res);
    END;
$$;

CALL DEMO_2_PROC_RETURN_TABLE('training.raw.lender_holdings');