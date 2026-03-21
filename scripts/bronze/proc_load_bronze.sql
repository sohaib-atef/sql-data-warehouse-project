/*
Stored Procedure: Load Bronze Layer (Source -> Bronze)

Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files.
    It performs teh following actions:
        - Truncate the bronze tables before loading data.
        - Uses the 'BULK INSERT' command to load data from csv files to bronze tables.

Parameters:
    None.
        - This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
*/

CREATE OR ALTER PROCEDURE [bronze].[load_bronze] AS
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
    BEGIN TRY
        SET @batch_start_time = GETDATE();
        PRINT '==============================================';
        PRINT 'Loading Bronze Layer...';
        PRINT '==============================================';

-- First Sourse: CRM
        PRINT '----------------------------------------------';
        PRINT 'Loading CRM Tables...';
        PRINT '----------------------------------------------';

-- 1.1. Truncating data from [bronze].[crm_cust_info]...
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.crm_cust_info';
        TRUNCATE TABLE [bronze].[crm_cust_info];

-- Inserting data into [bronze].[crm_cust_info]...
        PRINT '>> Inserting Data Into: bronze.crm_cust_info';
        BULK INSERT [bronze].[crm_cust_info]
        FROM 'D:\Education\Data with Baraa\sql\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
        WITH (
            FIRSTROW = 2
            ,FIELDTERMINATOR = ','
            ,TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> ----------------';

-- 1.2. Truncating data from [bronze].[crm_prd_info]...
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.crm_prd_info';
        TRUNCATE TABLE [bronze].[crm_prd_info];

-- Inserting data into [bronze].[crm_prd_info]...
        PRINT '>> Inserting Data Into: bronze.crm_prd_info';
        BULK INSERT [bronze].[crm_prd_info]
        FROM 'D:\Education\Data with Baraa\sql\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
        WITH (
            FIRSTROW = 2
            ,FIELDTERMINATOR = ','
            ,TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> ----------------';

-- 1.3. Truncating data from [bronze].[crm_sales_details]...
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.crm_sales_details';
        TRUNCATE TABLE [bronze].[crm_sales_details];

-- Inserting data into [bronze].[crm_sales_details]...
        PRINT '>> Inserting Data Into: bronze.crm_sales_details';
        BULK INSERT [bronze].[crm_sales_details]
        FROM 'D:\Education\Data with Baraa\sql\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
        WITH (
            FIRSTROW = 2
            ,FIELDTERMINATOR = ','
            ,TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> ----------------';

-- Second Sourse: ERP
        PRINT '----------------------------------------------';
        PRINT 'Loading ERP Tables...';
        PRINT '----------------------------------------------';
        
-- 2.1. Truncating data from [bronze].[erp_cust_az12]...
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.erp_cust_az12';
        TRUNCATE TABLE [bronze].[erp_cust_az12];

-- Inserting data into [bronze].[erp_cust_az12]...
        PRINT '>> Inserting Data Into: bronze.erp_cust_az12';
        BULK INSERT [bronze].[erp_cust_az12]
        FROM 'D:\Education\Data with Baraa\sql\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
        WITH (
            FIRSTROW = 2
            ,FIELDTERMINATOR = ','
            ,TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> ----------------';

-- 2.2. Truncating data from [bronze].[crm_sales_details]...
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.erp_loc_a101';
        TRUNCATE TABLE [bronze].[erp_loc_a101];

-- Inserting data into [bronze].[erp_loc_a101]...
        PRINT '>> Inserting Data Into: bronze.erp_loc_a101';
        BULK INSERT [bronze].[erp_loc_a101]
        FROM 'D:\Education\Data with Baraa\sql\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
        WITH (
            FIRSTROW = 2
            ,FIELDTERMINATOR = ','
            ,TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> ----------------';

-- 2.3. Truncating data from [bronze].[erp_px_cat_g1v2]...
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.erp_px_cat_g1v2';
        TRUNCATE TABLE [bronze].[erp_px_cat_g1v2];

-- Inserting data into [bronze].[erp_px_cat_g1v2]...
        PRINT '>> Inserting Data Into: bronze.erp_px_cat_g1v2';
        BULK INSERT [bronze].[erp_px_cat_g1v2]
        FROM 'D:\Education\Data with Baraa\sql\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
        WITH (
            FIRSTROW = 2
            ,FIELDTERMINATOR = ','
            ,TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> ----------------';

        SET @batch_end_time = GETDATE();
        PRINT '==============================================';
        PRINT 'Loading Bronze Layer is Completed!';
        PRINT '     - Total Load Duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
        PRINT '==============================================';
    END TRY
    BEGIN CATCH
        PRINT '==============================================';
        PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER!';
        PRINT 'ERROR MESSAGE: ' + ERROR_MESSAGE();
        PRINT 'ERROR NUMBER: ' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT 'ERROR STATE: ' + CAST(ERROR_STATE() AS NVARCHAR);
        PRINT '==============================================';
    END CATCH
END

EXEC [bronze].[load_bronze];