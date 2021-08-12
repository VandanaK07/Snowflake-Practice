--CREATE DATABASE:
	--during clone		or
	--database on top of share		or
	--creating replica
	
--Standard database:
	create or replace database if not exists TARGETDB 
	clone SOURCEDB;
--Shared database:
	create database TARGETDB from share ACCOUNT1.SHARE1;
--Database Replication:
	create database TARGETDB as replica of REGION1.ACCOUNT1.SOURCEDB;
	
-- As a best practice for Database Replication and Failover, we recommend giving each secondary database the same name as its primary database. This practice supports referencing fully-qualified objects (i.e. '<db>.<schema>.<object>') by other objects in the same database, such as querying a fully-qualified table name in a view.

-- If a secondary database has a different name from the primary database, then these object references would break in the secondary database.

--Transient databases do not have a Fail-safe period so they do not incur additional storage costs once they leave Time Travel. All schemas (and consequently all tables) created in a transient database are transient.
create or replace transient database if not exists PRIMARYDB;

--Modifies the properties for an existing database
	--renaming database
		alter database PRIMARYDB
		rename to SECONDARYDB;
	--swaping db objects, privileges etc
		alter database PRIMARYDB
		swap with SECONDARYDB;
	--setting paramter value
		ALTER database PRIMARYDB
		set DATA_RETENTION_TIME_IN_DAYS = 10;
	--unseting paramter value
		ALTER database PRIMARYDB
		unset DATA_RETENTION_TIME_IN_DAYS ;
	--enabling database replication
		alter database PRIMARYDB enable replication to 
		accounts region1.account1.PRIMARYDB;
	--disabling database replication
		alter database PRIMARYDB
		disable replication;
--Show all databases that you have privileges to view in your account:
show databases;
--Show all databases that you have privileges to view in the system, including dropped databases
show databases history;
--Restore the most recent version of a dropped database:
undrop database mytestdb2;

--Database replication uses Snowflake-provided compute resources instead of your own virtual warehouse to copy objects and data.



















