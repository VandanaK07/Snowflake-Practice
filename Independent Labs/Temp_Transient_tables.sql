--In addition to Temporary tables(local temporary tables), Snowflake supports creating certain other database objects as temporary (e.g. stages). These objects follow the same semantics (i.e. they are session-based, persisting only for the remainder of the session).

--temporary tables belong to a specified database and schema; however, because they are session-based

--you can create temporary and non-temporary tables with the same name within the same schema

-- temporary table takes precedence in the session over any other table with the same name in the same schema.

--For the duration of the existence of a temporary table, the data stored in the table contributes to the overall storage charges that Snowflake bills your account.

--Transient tables are similar to permanent tables with the key difference that they do not have a Fail-safe period.

--transient tables contribute to the overall storage charges that Snowflake bills your account; however, because transient tables do not utilize Fail-safe, there are no Fail-safe costs 

--Snowflake also supports creating transient databases and schemas. All tables created in a transient schema, as well as all schemas created in a transient database, are transient by definition.

--Because transient tables do not have a Fail-safe period, they provide a good option for managing the cost of very large tables used to store transitory data; however, the data in these tables cannot be recovered after the Time Travel retention period passes.    For example, if a system failure occurs in which a transient table is dropped or lost, after 1 day, the data is not recoverable by you or Snowflake. As such, we recommend using transient tables only for data that does not need to be protected against failures or data that can be reconstructed outside of Snowflake.