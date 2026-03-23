-- Checking [silver].[crm_cst_info]
-- Check for NULLs or Duplicates in the primary key
-- Expectation: No result
SELECT
    [cst_id]
    ,COUNT(*) [Duplicates]
FROM
    [silver].[crm_cust_info]
GROUP BY
    [cst_id]
HAVING
    COUNT(*) > 1            --> for duplicates
    OR [cst_id] IS NULL;    --> for nulls


-- Check the unwanted spaces
-- Expectation: No result
SELECT
    [cst_lastname]
FROM
    [silver].[crm_cust_info]
WHERE
    [cst_lastname] != TRIM([cst_lastname]);


-- Data standardization & consistency
SELECT DISTINCT
    [cst_gndr]
FROM
    [silver].[crm_cust_info];



-- Checking [silver].[crm_prd_info]...
-- Check for NULLs or Duplicates in the primary key
-- Expectation: No result
SELECT
    [prd_id]
    ,COUNT(*) [Duplicates]
FROM
    [silver].[crm_prd_info]
GROUP BY
    [prd_id]
HAVING
    COUNT(*) > 1
    AND [prd_id] IS NULL;


-- Check the unwanted spaces
-- Expectation: No result
SELECT
    [prd_nm]
FROM
    [silver].[crm_prd_info]
WHERE
    [prd_nm] != TRIM([prd_nm]);


-- Check for nulls of negative numbers
-- Expectation: No results
SELECT
    [prd_cost]
FROM
    [silver].[crm_prd_info]
WHERE
    [prd_cost] < 0
    OR [prd_cost] IS NULL;


-- Data standardization & consistency
SELECT DISTINCT
    [prd_line]
FROM
    [silver].[crm_prd_info];


-- Check for invalid date orders
SELECT *
FROM [silver].[crm_prd_info]
WHERE [prd_end_dt] < [prd_start_dt];


SELECT * FROM [silver].[crm_prd_info];



-- Checking [silver].[crm_sales_details]...
-- Check the unwanted spaces
-- Expectation: No result
SELECT
    *
FROM
    [silver].[crm_sales_details]
WHERE
    sls_ord_num != TRIM([sls_ord_num]);

-- Check the primary key
SELECT
    *
FROM
    [silver].[crm_sales_details]
WHERE
    [sls_prd_key] NOT IN (
        SELECT
            [prd_key]
        FROM
            [silver].[crm_prd_info]
    )

-- Check the primary key
SELECT
    *
FROM
    [silver].[crm_sales_details]
WHERE
    [sls_cust_id] NOT IN (
        SELECT
            [cst_id]
        FROM
            [silver].[crm_cust_info]
    )


-- Check for invalid dates
SELECT
    NULLIF([sls_order_dt], 0) [sls_order_dt]
FROM
    [silver].[crm_sales_details]
WHERE
    [sls_order_dt] <= 0
    OR LEN([sls_order_dt]) != 8
    OR sls_order_dt > 20500101
    OR sls_order_dt < 19000101;


-- Check of invalid date orders
SELECT
    *
FROM
    [silver].[crm_sales_details]
WHERE
    [sls_order_dt] > [sls_ship_dt]
    OR [sls_order_dt] > [sls_due_dt];


-- Check data consistency: between sales, quantity & price
-->> Sales = Quantity X Price
-->> Values must not be NULL, zero or negative
SELECT DISTINCT
    [sls_quantity]
    ,[sls_price] [old_price]
    ,[sls_sales] [old_sales]
    ,CASE
        WHEN
            [sls_sales] IS NULL -- If Sales is negative, zero or null -> derive it using the quantity and the price
            OR [sls_sales] <= 0
            OR [sls_sales] != [sls_quantity] * ABS([sls_price])
        THEN [sls_quantity] * ABS([sls_price])
        ELSE [sls_sales]
    END [sls_sales]
    ,CASE
        WHEN 
            [sls_price] IS NULL -- If Price is zero or null -> calculate it using the sales and quantity
            OR [sls_price] <= 0
        THEN [sls_sales] / NULLIF([sls_quantity], 0)
        ELSE [sls_price]
    END [sls_price]
FROM
    [silver].[crm_sales_details]
WHERE
    [sls_sales] != [sls_quantity] * [sls_price]
    OR [sls_sales] IS NULL
    OR [sls_quantity] IS NULL
    OR [sls_price] IS NULL
    OR [sls_sales] < 0
    OR [sls_quantity] < 0
    OR [sls_price] < 0
ORDER BY
    [old_sales];


-- Checking [silver].[erp_cust_az12]...
-- Check the primary key
SELECT TOP 3
    CASE
        WHEN [cid] LIKE 'NAS%' THEN SUBSTRING([cid], 4, LEN([cid]))
        ELSE [cid]
    END [cid]
    ,[bdate]
    ,[gen]
FROM
    [silver].[erp_cust_az12]
WHERE
    CASE
        WHEN [cid] LIKE 'NAS%' THEN SUBSTRING([cid], 4, LEN([cid]))
        ELSE [cid]
    END NOT IN (
        SELECT DISTINCT
            [cst_key]
        FROM
            [silver].[crm_cust_info]
    );


-- Identify dates out of range
SELECT
    [bdate]
FROM
    [silver].[erp_cust_az12]
WHERE
    [bdate] > GETDATE();


-- Check data standardization & consistency
SELECT DISTINCT
    [gen]
FROM
    [silver].[erp_cust_az12];




-- Checking [silver].[erp_cust_az12]...
-- Check the primary key
SELECT TOP 3
    REPLACE([cid], '-', '') [cid]
    ,[cntry]
FROM
    [silver].[erp_loc_a101]
WHERE
    REPLACE([cid], '-', '') NOT IN (
        SELECT
            [cst_key]
        FROM
            [silver].[crm_cust_info]
    );


-- Check data standardization & consistency
SELECT DISTINCT
    [cntry]
FROM
    [silver].[erp_loc_a101]
ORDER BY
    [cntry];

SELECT * FROM [silver].[erp_loc_a101];



-- Checking [silver].[erp_px_cat_g1v2]...
-- Check the primary key
SELECT
    [id]
FROM
    [bronze].[erp_px_cat_g1v2]
WHERE
    [id] NOT IN (
        SELECT
            [cat_id]
        FROM
            [silver].[crm_prd_info]
    );


-- Check for unwanted spaces
SELECT
    *
FROM
    [bronze].[erp_px_cat_g1v2]
WHERE
    [cat] != TRIM([cat])
    OR [subcat] != TRIM([subcat])
    OR [maintenance] != TRIM([maintenance]);


-- Check data standardization & consistency
SELECT DISTINCT
    [maintenance]
FROM
    [bronze].[erp_px_cat_g1v2];



-- Gold layer
-- Check the gender integration
SELECT DISTINCT
    [ci].[cst_gndr]
    ,[ca].[gen]
    ,CASE
        WHEN [ci].[cst_gndr] != 'n/a' THEN [ci].[cst_gndr]
        ELSE COALESCE([ca].[gen], 'n/a')
    END
FROM
    [silver].[crm_cust_info] [ci]
    LEFT JOIN [silver].[erp_cust_az12] [ca] ON [ca].[cid] = [ci].[cst_key]
    LEFT JOIN [silver].[erp_loc_a101] [la] ON [la].[cid] = [ci].[cst_key]
ORDER BY
    1, 2;


-- Check the uniqueness of the products table in the gold layer
SELECT
    [prd_key]
    ,COUNT(*)
FROM (
    SELECT
        [pi].[prd_id]
        ,[pi].[cat_id]
        ,[pi].[prd_key]
        ,[pi].[prd_nm]
        ,[pi].[prd_cost]
        ,[pi].[prd_line]
        ,[pi].[prd_start_dt]
        ,[pc].[cat]
        ,[pc].[subcat]
        ,[pc].[maintenance]
    FROM 
        [silver].[crm_prd_info] AS [pi]
        LEFT JOIN [silver].[erp_px_cat_g1v2] AS [pc] ON [pc].[id] = [pi].[cat_id]
    WHERE
        [pi].[prd_end_dt] IS NULL
    ) t
GROUP BY
    [prd_key]
HAVING
    COUNT(*) > 1;
