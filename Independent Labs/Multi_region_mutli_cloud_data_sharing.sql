use role Accountadmin;

create database PRIMARYDB;

create schema PRIMARYDB.sch;

create table PRIMARYDB.sch.tableB
as select col1, col2, col3 
from SOURCEDB.sch.tableA where col2 = 'value';

create secure view PRIMARYDB.sch.view1
as
select * from  PRIMARYDB.sch.tableB;

create stream myStream on table SOURCEDB.sch.tableA append_only = true;

create task myTask1
warehouse = COMPUTE_WH
schedule = '5 minute'
when SYSTEM$STREAM_HAS_DATA('myStream')
as
	insert into PRIMARYDB.sch.tableB
	(col1, col2, col3) 
	select col1, col2, col3 from 
	SOURCEDB.sch.tableA
	from myStream
	where METADATA$ACTION = 'INSERT';
	
alter database PRIMARYDB enable replication to 
accounts REGION2.ACCOUNT2;

create database SECONDARYDB
as replica of REGION1.ACCOUNT1.PRIMARYDB;


create task myTask2
warehouse = COMPUTE_WH
schedule = '5 minute'
as
	alter database SECONDARYDB refresh;
	
alter task myTask2 resume;

create share share1;

grant usage on database SECONDARYDB to share share1;

grant usage on schema SECONDARYDB.sch to share share1;

grant select on view SECONDARYDB.sch.view1 to share share1;

alter share share1 add accounts = CONSUMERACCOUNT;
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
