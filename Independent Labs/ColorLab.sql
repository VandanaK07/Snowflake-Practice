USE ROLE SYSADMIN;
USE WAREHOUSE COMPUTE_WH;
USE DATABASE DEMO_DB;
USE SCHEMA PUBLIC;

CREATE SEQUENCE COLOR_UID_SEQ
START 1 INCREMENT 1;

CREATE TABLE COLORS(
COLOR_UID NUMBER(5),
COLOR_NAME VARCHAR(20));

INSERT INTO "DEMO_DB"."PUBLIC"."COLORS" VALUES 
(COLOR_UID_SEQ.NEXTVAL, 'RED'),
(COLOR_UID_SEQ.NEXTVAL, 'YELLOW'),
(COLOR_UID_SEQ.NEXTVAL, 'BLACK'),
(COLOR_UID_SEQ.NEXTVAL, 'BLUE'),
(COLOR_UID_SEQ.NEXTVAL, 'PINK');

SELECT * FROM "DEMO_DB"."PUBLIC"."COLORS";


//LAB 2
CREATE FILE FORMAT "DEMO_DB"."PUBLIC".COLOR_CSV
TYPE = 'CSV' 
COMPRESSION = 'AUTO' 
FIELD_DELIMITER = ',' 
RECORD_DELIMITER = '\n' 
SKIP_HEADER = 1 
FIELD_OPTIONALLY_ENCLOSED_BY = 'NONE' 
TRIM_SPACE = FALSE 
ERROR_ON_COLUMN_COUNT_MISMATCH = TRUE 
ESCAPE = 'NONE' 
ESCAPE_UNENCLOSED_FIELD = '\134' 
DATE_FORMAT = 'AUTO' 
TIMESTAMP_FORMAT = 'AUTO' 
NULL_IF = ('\\N');

select count(*) from "DEMO_DB"."PUBLIC"."COLORS";
select max(color_uid) from "DEMO_DB"."PUBLIC"."COLORS";


//setting up your RSA KEY Pair Hands-on

//Task in Snowflake:

//1. create a bucket in GCP. Create folder and place sample avro file there.
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

create table "DEMO_DB"."PUBLIC"."test"
(
a variant,
b time);


show databases history;

create database test;

drop database test;

undrop database test;


create temporary table "DEMO_DB"."PUBLIC"."temptbl"
(id int, name varchar(10));

insert into  "DEMO_DB"."PUBLIC"."temptbl" values (1,'a');

create table "DEMO_DB"."PUBLIC"."temptbl"
(id int, name varchar(10));

insert into  "DEMO_DB"."PUBLIC"."permtbl" values (1,'b');
drop table "DEMO_DB"."PUBLIC"."temptbl";


create view employee_hierarchy (title, employee_id, manager_id, "MGR_EMP_ID (SHOULD BE SAME)", "MGR TITLE") as (
   with recursive employee_hierarchy_cte (title, employee_id, manager_id, "MGR_EMP_ID (SHOULD BE SAME)", "MGR TITLE") as (
      -- Start at the top of the hierarchy ...
      select title, employee_id, manager_id, null as "MGR_EMP_ID (SHOULD BE SAME)", 'President' as "MGR TITLE"
        from employees
        where title = 'President'
      union all
      -- ... and work our way down one level at a time.
      select employees.title, 
             employees.employee_id, 
             employees.manager_id, 
             employee_hierarchy_cte.employee_id as "MGR_EMP_ID (SHOULD BE SAME)", 
             employee_hierarchy_cte.title as "MGR TITLE"
        from employees inner join employee_hierarchy_cte
       where employee_hierarchy_cte.employee_id = employees.manager_id
   )
   select * 
      from employee_hierarchy_cte
);


create table "DEMO_DB"."PUBLIC"."AFHCON_JSON_DIRECT_LOAD"(
JSON_DATA VARIANT);

SELECT * FROM "DEMO_DB"."PUBLIC"."AFHCON_JSON_DIRECT_LOAD";

select JSON_DATA:DBVersion, from "DEMO_DB"."PUBLIC"."AFHCON_JSON_DIRECT_LOAD",LATERAL FLATTEN (input=>JSON_DATA);







select * from "SNOWFLAKE_SAMPLE_DATA"."TPCDS_SF100TCL"."CATALOG_RETURNS";









