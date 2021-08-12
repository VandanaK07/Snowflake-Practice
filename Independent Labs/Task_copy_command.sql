//Task in Snowflake:

--1. create a bucket in GCP. Create folder and place sample avro file there.
//2. create an Integration in snowflake. then Create a Stage, pointing to GCP stage location.
//3. use copy command to load data from stage to snowflake table IOT_AVRO_DATA
// this will load all avro files to this tables
COPY INTO IOT_AVRO_DATA
FROM @GOOGLE_BUCKET_SFHOL/iot_files/output
FILE_FORMAT = (TYPE = AVRO)
PATTERN = '*.avro';

//check if table loaded
select * from IOT_AVRO_DATA;

//4. automate the task of loading stage files to snowflake table
//remove data from table
TRUNCATE TABLE IOT_AVRO_DATA;

SELECT * FROM IOT_AVRO_DATA;

CREATE TASK MYTASK_UPLOADAVRO
    WAREHOUSE = COMPUTE_WH
    SCHEDULE = '5 MINUTE'
   AS
COPY INTO IOT_AVRO_DATA
FROM @GOOGLE_BUCKET_SFHOL/iot_files/output
FILE_FORMAT = (TYPE = AVRO)
PATTERN = '*.avro';

SHOW TASKS;

ALTER TASK MYTASK_UPLOADAVRO RESUME;

//CHECK IF TASK STARTED AND GET TASK INFO FROM INFORMATION_SCHEMA
SHOW TASKS;

SELECT * FROM 
TABLE(INFORMATION_SCHEMA.TASK_HISTORY(TASK_NAME => 'MYTASK_UPLOADAVRO' ))

SELECT * FROM IOT_AVRO_DATA;

ALTER TASK MYTASK_UPLOADAVRO SUSPEND;
SHOW TASKS;