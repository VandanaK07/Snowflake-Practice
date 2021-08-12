--***********************************************MFA:************************************************
Snowflake supports multi-factor authentication (i.e. MFA) to provide increased login security for users connecting to Snowflake. MFA support is provided as an integrated Snowflake feature, powered by the Duo Securityservice, which is managed completely by Snowflake.
MFA is enabled on a per-user basis
At a minimum, Snowflake strongly recommends that all users with the ACCOUNTADMIN role be required to use MFA.

The Duo application service communicates through TCP port 443.

Managing MFA:
1. MINS_TO_BYPASS_MFA
2. DISABLE_MFA:
	DISABLE_MFA is not a column in any Snowflake table or view. After an account administrator executes the ALTER USER command to set DISABLE_MFA to TRUE, the value for the EXT_AUTHN_DUO property is automatically set to FALSE. 
	To verify that MFA is disabled for a given user, execute a DESCRIBE USER statement and check the value for the EXT_AUTHN_DUO property.

MFA login is designed primarily for connecting to Snowflake through the web inteface, but is also fully-supported by SnowSQL and the Snowflake JDBC and ODBC drivers and Python.

--************************************************OAuth:************************************************

Snowflake supports the OAuth 2.0protocol for authentication and authorization.
OAuth is an open-standard protocol that allows supported clients authorized access to Snowflake without sharing or storing user login credentials.
This is known as delegated authorization, because a user authorizes the client to act on their behalf to retrieve their data. 
Snowflake offers two OAuth pathways: 
	1. Snowflake OAuth and 
	2. External OAuth.
Snowflake enables OAuth for clients through integrations. An integration is a Snowflake object that provides an interface between Snowflake andthird-party services. 
OAuth Concepts:
	Authorization Server
	Access Token : Access tokens have a short life; typically 10 minutes.
	Refresh Token
	Resource Server
	Confidential and Public Clients
Snowflake OAuth Partner Applications:
	1.Tableau Desktop / Server / Online
	2.Looker
External OAuth Partner Applications:
	1.Microsoft Power BI

Snowflake supports OAuth with Federated Authentication & SSO (single sign-on) using any identity provider (IdP) supported by Snowflake.
You can use network policies with Snowflake OAuth only. The External OAuth security integration does not support setting a separate network policy.

If a network policy per user or account is set and you are using a service that runs in a different location (e.g. Microsoft Power BI Service), you will not be able to connect to Snowflake.


OAuth with Clients, Drivers, and Connectors:
	SnowSQL
	Python
	Go
	JDBC
	ODBC
	Spark Connector
	.NET Driver
	Node.js Driver

--************************************************NETWORK POLICIES:************************************************
Network policies allow restricting access to your account based on user IP address. Effectively, a network policy enables you to create an IP allowed list, as well as an IP blocked list, if desired.

Account-level network policy management can be performed through either the web interface or SQL.

User-level network policy management can be formed using SQL.

If a user is associated to both an account-level and user-level network policy, the user-level policy takes precedence.

By default, Snowflake allows users to connect to the service from any computer or device IP address.

Only security administrators (i.e. users with the SECURITYADMIN role) or higher or a role with the global CREATE NETWORK POLICY privilege can create network policies. Network policies currently support only Internet Protocol version 4 (i.e. IPv4) addresses.

When creating or editing network policies using the web interface, enclosing Network Policy Properties in single quotes is not required; however, when using SQL, network policy properties must be enclosed in single quotes.

	use role securityadmin;
	create network policy mypolicy1 allowed_ip_list=('192.168.1.0/24') blocked_ip_list=('192.168.1.99');

	desc network policy mypolicy1;	
	


	https://docs.snowflake.com/en/sql-reference/sql/create-network-policy.html#usage-notes
