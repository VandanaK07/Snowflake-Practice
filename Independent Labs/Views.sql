//A view allows the result of a query to be accessed as if it were a table.

//A view can be used almost anywhere that a table can be used (joins, subqueries, etc.).

A CREATE VIEW command can use a fully-qualified, partly-qualified, or unqualified table name:

CREATE VIEW V1 
AS
SELECT COL1, COL2 FROM DB.SCH.TBL;

The results of Non-Materialized are not stored for future use. So, Performance is slower than with materialized views.

-- What you can write inside a view query:
Selecting some (or all) columns in a table.
Selecting a specific range of data in table columns.
Joining data from two or more tables.

--A materialized view’s results are stored, almost as though the results were a table. This allows faster access, but requires storage space and active maintenance, both of which incur additional costs.

Both non-materialized and materialized views can be defined as secure, including improved data privacy and data sharing.

Recursive Views (Non-materialized Views Only)
A non-materialized view can be recursive (i.e. the view can refer to itself).

--ways 
Use of recursion in views is similar to the use of recursion in recursive CTEs. In fact, a view can be defined with a recursive CTE. 
Instead of using a recursive CTE, you can create a recursive view with the keyword RECURSIVE