// Snowflake refers to the location of data files in cloud storage as a stage. 

// The COPY INTO <table> command used for both bulk and continuous data loads (i.e. Snowpipe)

// Stage object holds:
	-- location of stage
	-- access creds
	-- file format
	
CREATE STAGE;

// Some data transfer billing charges may apply when loading data from files in a cloud storage service in a different region or cloud platform from your Snowflake account

// Upload files to any of the internal stage types from your local file system using the PUT command.

// Bulk loading relies on user-provided virtual warehouses, which are specified in the COPY statement. WHEREAS Snowpipe uses compute resources provided by Snowflake (i.e. a serverless compute model). These Snowflake-provided resources are automatically resized and scaled up or down as required, and are charged and itemized using per-second billing.

File size Guidelines:
//The number of load operations that run in parallel cannot exceed the number of data files to be loaded.

Delimited files:
//To optimize the number of parallel operations for a load, we recommend aiming to produce data files roughly 100-250 MB (or larger) in size compressed.

//Loading very large files (e.g. 100 GB or larger) is not recommended.

Semi-structured Data Size Limitations:
The VARIANT data type imposes a 16 MB (compressed) size limit on individual rows.

Parquet Data Size Limitations:
//Currently, data loads of large Parquet files (e.g. greater than 3 GB) could time out. Split large files into files 1 GB in size (or smaller) for loading.

Preparing Delimited Text Files:
//For Flat Files: default Char set =  UTF-8, others you can specify explicitly

Dedicating Separate Warehouses to Load and Query Operations:
//Loading large data sets can affect query performance. We recommend dedicating separate warehouses for loading and querying operations to optimize performance for each.

Organizing Data by Path:
//Organizing your data files by path lets you copy any fraction of the partitioned data into Snowflake with a single command
