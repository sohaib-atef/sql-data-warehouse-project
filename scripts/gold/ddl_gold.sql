/*
DDL Script: Create Gold Views

Script Purpose:
    This script creates views for the Gold Layer in the data warehouse.
    The Gold Layer represents the final dimention and fact tables (Star Schema).

    Each view performs transformations and combines data from the Silver Layer
    to produce a clean, enriched, and business-ready dataset.

Usage:
    - These views can be queried directly for analytics and reporting.
*/

CREATE VIEW [gold].[dim_customers] AS 
SELECT
    ROW_NUMBER() OVER(ORDER BY [ci].[cst_create_date]) AS [customer_key]
    ,[ci].[cst_id] AS [customer_id]
    ,[ci].[cst_key] AS [customer_number]
    ,[ci].[cst_firstname] AS [first_name]
    ,[ci].[cst_lastname] AS [last_name]
    ,[la].[cntry] AS [country]
    ,[ci].[cst_marital_status] AS [marital_status]
    ,CASE
        WHEN [ci].[cst_gndr] != TRIM('n/a') THEN [ci].[cst_gndr]
        ELSE COALESCE([ca].[gen], 'n/a')
    END AS [gender]
    ,[ca].[bdate] AS [birthdate]
    ,[ci].[cst_create_date] AS [create_date]
FROM
    [silver].[crm_cust_info] AS [ci]
    LEFT JOIN [silver].[erp_cust_az12] AS [ca] ON [ca].[cid] = [ci].[cst_key]
    LEFT JOIN [silver].[erp_loc_a101] AS [la] ON [la].[cid] = [ci].[cst_key];
GO

CREATE VIEW [gold].[dim_products] AS
SELECT
    ROW_NUMBER() OVER(ORDER BY [pi].[prd_start_dt], [pi].[prd_key]) AS [product_key]
    ,[pi].[prd_id] AS [product_id]
    ,[pi].[prd_key] AS [product_number]
    ,[pi].[prd_nm] AS [product_name]
    ,[pi].[cat_id] AS [category_id]
    ,[pc].[cat] AS [category]
    ,[pc].[subcat] AS [subcategory]
    ,[pc].[maintenance]
    ,[pi].[prd_cost] AS [cost]
    ,[pi].[prd_line] AS [product_line]
    ,[pi].[prd_start_dt] [start_date]
FROM 
    [silver].[crm_prd_info] AS [pi]
    LEFT JOIN [silver].[erp_px_cat_g1v2] AS [pc] ON [pc].[id] = [pi].[cat_id]
WHERE
    [pi].[prd_end_dt] IS NULL; -- This to filter out any historical data and to keep the current data only!
GO


CREATE VIEW [gold].[fact_sales] AS
SELECT 
    [sd].[sls_ord_num] AS [order_number]
    ,[pr].[product_key]
    ,[cs].[customer_key]
    ,[sd].[sls_order_dt] AS [order_date]
    ,[sd].[sls_ship_dt] AS [shipping_date]
    ,[sd].[sls_due_dt] AS [due_date]
    ,[sd].[sls_sales] AS [sales_amount]
    ,[sd].[sls_quantity] AS [quantity]
    ,[sd].[sls_price] AS [price]
FROM
    [silver].[crm_sales_details] AS [sd]
    LEFT JOIN [gold].[dim_customers] AS [cs] ON [cs].[customer_id] = [sd].[sls_cust_id]
    LEFT JOIN [gold].[dim_products] AS [pr] ON [pr].[product_number] = [sd].[sls_prd_key];
GO

