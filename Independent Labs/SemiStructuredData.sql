//INSERT INTO tblName select * from tblName;
// CREATE TABLE tblName as Select * from tblName;

/*Snowflake loads semi-structured data into a single VARIANT column. Alternatively, using a COPY INTO table statement with data transformation, you can extract selected columns from a staged data file into separate table columns.
ORC is a binary format, Used to store Hive data.
Avro is an open-source data serialization and RPC framework originally developed for use with Apache Hadoop.
Parquet is a compressed, efficient columnar data representation designed for projects in the Hadoop ecosystem.
Parquet is a binary format.
XML is a markup language that defines a set of rules for encoding documents.
The VARIANT data type imposes a 16 MB (compressed) size limit on individual rows.

If you aren’t sure yet what types of operations you’ll perform on your semi-structured data, we recommend storing it in a VARIANT column for now.

When extracting key-values from a VARIANT column, cast the values to the desired data type (using the :: notation) to avoid unexpected results.*/

--In a VARIANT column, NULL values are stored as a string containing the word “null”. This behavior allows distinguishing “null” values from values that are absent, which produce a SQL NULL. e.g.
select 
    parse_json(null) as "SQL NULL", 
    parse_json('null') as "JSON NULL", 
    parse_json('{ "a": null }'):a as "ANOTHER JSON NULL", -- String "null"
    parse_json('{ "a": null }'):b as "ABSENT VALUE"; --SQL NULL

--//starting the warehouse could take up to five minutes
	
	
select src:device_type
  from raw_source;

+-----------------+
| SRC:DEVICE_TYPE |
|-----------------|
| "server"        |
+-----------------+
--The column name is case-insensitive but element names, or keys, are case-sensitive.

--//FLATTEN is a table function that produces a lateral view of a VARIANT, OBJECT, or ARRAY column. In this step, we’ll use the function to create two tables with different levels of flattening.
--1.
select value:f :: number
from raw_source,
lateral flatten(input => src:events);
--2.
select src:device_type:: string,
src:version, value
from raw_source, 
lateral flatten(input => src:events);
--3. -- semi flattened table example
create or replace table flattened_source as
select src:device_type:: string as device_type,
src:version as version, 
value as events
from raw_source, 
lateral flatten(input => src:events);
--4. -- Fully flattened table example
create or replace table events as
  select
    src:device_type::string                             as device_type
  , src:version::string                                 as version
  , value:f::number                                     as f
  , value:rv::variant                                   as rv
  , value:t::number                                     as t
  , value:v.ACHZ::number                                as achz
  , value:v.ACV::number                                 as acv
  , value:v.DCA::number                                 as dca
  , value:v.DCV::number                                 as dcv
  , value:v.ENJR::number                                as enjr
  , value:v.ERRS::number                                as errs
  , value:v.MXEC::number                                as mxec
  , value:v.TMPI::number                                as tmpi
  , value:vd::number                                    as vd
  , value:z::number                                     as z
  from
    raw_source
  , lateral flatten ( input => SRC:events );
  
 
--Snowflake does not enforce the primary key constraint. Rather, the constraint serves as metadata identifying the natural key in the Information Schema.



---*******************************************************************************
When you log out of the interface, Snowflake cancels all in-progress queries (i.e. queries that have not yet completed) in your open worksheets; however, your worksheets remain open and no work is lost. When you next log into the interface, you can resume your work in any open worksheets.

MFA is a built-in Snowflake feature (available for all Snowflake Editions). This second form of authentication is provided by the Duo Mobile application.By default, MFA is not enabled for individual Snowflake users. If you wish to use MFA for more secure login, you must enroll using the Snowflake web interface.

If you are unable to log into Snowflake due to an MFA issue (e.g. you don’t have access to your phone), please contact one of your account administrators. They can temporarily disable MFA, so that you can log in, or they can disable MFA for you, which effectively cancels your enrollment.
ALTER USER … SET DISABLE_MFA = TRUE

A preview of Snowsight, the SQL Worksheets replacement designed for data analysis, was introduced in June 2020. We encourage you to take this opportunity to familiarize yourself with the new features and functionality. Snowsight is enabled by default for account administrators (i.e. users with ACCOUNTADMIN role) only. To enable Snowsight for all roles, an account administrator must log into the new web interface and explicitly enable support. Note that preview features are intended for evaluation and testing purposes and are not recommended for use in production.


























