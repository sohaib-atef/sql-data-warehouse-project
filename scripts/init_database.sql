/*
===========================
Create Database and Schemas
===========================

Script Purpose:
    This script creates a new database named 'DataWarehouse' after checking existence.
    If the database exists, it will be dropped and recreated again. Additionally, the script sets
    up three schemas within teh database: 'bronze', 'silver' & 'gold'.

!!! WARNING !!!
    Running this script will drop the entire 'DataWarehouse' database if exists!
    All data in the database will be permanently deleted. Proceed with caution and
    ensure you've proper backups before running this script!
*/

USE master;
GO

-- Drop and recreate the 'DataWarehouse' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
    ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouse;
END;
GO

-- Create the 'DataWarehouse' database
CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO


-- Create schemas
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
