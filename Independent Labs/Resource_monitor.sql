--Resource monitors can be created through either the web interface or SQL; however, only account administrators (i.e. users with the ACCOUNTADMIN role) can create resource monitors.

/*
You must assign at least one warehouse to a resource monitor or set the monitor at the account level for it to begin monitoring/tracking credit usage:
	In the web interface, you are required to do this at creation time.
	In SQL, you must create the resource monitor first, then assign one or more warehouses to it by executing ALTER WAREHOUSE as a separate, additional step.
Also, to receive notifications when resource monitor actions are triggered, you must enable notifications in your preferences in the web interface.

By default, credit usage tracking resets back to 0 at the beginning of each calendar month, matching the Snowflake billing cycle.
By default, a resource monitor starts tracking assigned warehouses as soon as it is created, at the current timestamp.
The schedule of a resource monitor can be customized to reset at an interval (such as daily, weekly, or annually) relative to a designated start date.

*/

CREATE [ OR REPLACE ] RESOURCE MONITOR <name> WITH
                      [ CREDIT_QUOTA = <number> ]
                      [ FREQUENCY = { MONTHLY | DAILY | WEEKLY | YEARLY | NEVER } ]
                      [ START_TIMESTAMP = { <timestamp> | IMMEDIATELY } ]
                      [ END_TIMESTAMP = <timestamp> ]
                      [ TRIGGERS triggerDefinition [ ON <threshold> PERCENT DO { SUSPEND | SUSPEND_IMMEDIATE | NOTIFY }] ];
					  
ALTER WAREHOUSE MYWH IF EXISTS SET RESOURCE MONITOR = RSRC_MONTR;

e.g 
CREATE RESOURCE MONITOR "MY_RESOURCE_MANAGER" 
WITH CREDIT_QUOTA = 2, 
frequency = 'MONTHLY', 
start_timestamp = '2021-03-18 20:00 IST', 
end_timestamp = null 
 TRIGGERS 
 ON 92 PERCENT DO SUSPEND 
 ON 95 PERCENT DO SUSPEND_IMMEDIATE 
 ON 90 PERCENT DO NOTIFY 
 ON 90 PERCENT DO NOTIFY 
 ON 90 PERCENT DO NOTIFY 
 ON 90 PERCENT DO NOTIFY 
 ON 90 PERCENT DO NOTIFY;
ALTER WAREHOUSE "INTL_WH" SET RESOURCE_MONITOR = "MY_RESOURCE_MANAGER";


--************** DATA PROTECTION IN SNOWFLAKE: Replication and Failover/Failback,Time Travel, Fail-Safe, and Zero-Copy Cloning **************
For Time Travel, we need Sysadmin Role.

Introduction to Database Replication: 
https://docs.snowflake.com/en/user-guide/database-replication-intro.html

Introduction to Business Continuity and Disaster Recovery: https://docs.snowflake.com/en/user-guide/database-failover-intro.html#introduction-to-business-continuity-and-disaster-recovery

Sharing Data Securely Across Regions and Cloud Platforms: 
https://docs.snowflake.com/en/user-guide/secure-data-sharing-across-regions-plaforms.html

Optional Reading
Database Replication Considerations:
https://docs.snowflake.com/en/user-guide/database-replication-considerations.html



Navigate to the feature demonstration videos:
https://docs.snowflake.com/en/other-resources.html#feature-demonstration-videos
and watch two short videos :
Data Protection with Time Travel in Snowflake (3:21)
A Quick Look at Zero-copy Cloning (3:50)

Understanding & Using Time Travel:
https://docs.snowflake.com/en/user-guide/data-time-travel.html
Understanding & Viewing Fail-Safe:
https://docs.snowflake.com/en/user-guide/data-failsafe.html
Cloning Tables, Schemas, and Databases: 
https://docs.snowflake.com/en/user-guide/tables-storage-considerations.html#cloning-tables-schemas-and-databases

Snowflake's failover capabilities:
Must have Snowflake Business Critical Edition or higher
Must have an account in the region where you wish to share replicated data






-- set the active role to ACCOUNTADMIN before granting the EXECUTE TASK privilege to the new role
use role accountadmin;

grant execute task on account to role taskadmin;



?sv=2020-02-10&ss=bfqt&srt=sco&sp=rwdlacupx&se=2021-05-31T18:26:12Z&st=2021-03-23T10:26:12Z&spr=https&sig=y6cdJMaea0BwqF4xX9ykNNZntxZfX38F2h9qigGk0j0%3D
































