/*
================================================================
Create Database and Schemas
================================================================
Script Purpose:
	This script creates a new database named 'ProjectDWH' after checking if it already exists.
	If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas
	within the database: 'BRONZE', 'SILVER', 'GOLD'.

WARNING:
	Running this script will DROP the entire 'ProjectDWH' database if it exist.
	Therefore, all the data in the database will be PERMANENTLY DELETED. Proceed with CAUTION
	and ENSURE you have proper backups before running this script. 
*/


USE master;
GO

IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'ProjectDWH')
BEGIN
	ALTER DATABASE ProjectDWH SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE ProjectDWH
END;
GO

-- Create Database Warehouse
CREATE DATABASE ProjectDWH;

USE ProjectDWH

-- Create Bronze Schema
CREATE SCHEMA BRONZE;
GO

-- Create Silver Schema
CREATE SCHEMA SILVER;
GO

-- Create Gold Schema
CREATE SCHEMA GOLD;
GO
