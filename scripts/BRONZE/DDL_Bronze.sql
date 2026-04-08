/*
===================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
Script Purpose:
	This stored procedure loads data into the 'bronze' schema from external CSV files.
	It performs the following actions:
	- Truncates the bronze tables before loading data
    - Uses the 'BULK INSERT' command to load data from csv Files to bronze tables.
	- Refreshes and fetch the newly data that has been inserted on the table that included on the Stored Procedure

Parameters:
	None.
	This stored procedure does not accept any parameters or return any values

Usage Example:
	EXEC bronze.load_bronze;
===================================================
*/


CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
	    SET @batch_start_time = GETDATE()
		PRINT '==========================================';
		PRINT 'Loading Bronze Layer';
		PRINT '==========================================';

		PRINT '------------------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating the Table crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info ;

		PRINT '>> Inserting data to Table crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\Cidoy\Downloads\sql-data-warehouse-project (1)\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();

		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' secs'
		PRINT '------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating the Table crm_prod_info';
		TRUNCATE TABLE bronze.crm_prod_info ;

		PRINT '>> Inserting data to Table crm_prod_info';
		BULK INSERT bronze.crm_prod_info
		FROM 'C:\Users\Cidoy\Downloads\sql-data-warehouse-project (1)\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		SET @end_time = GETDATE();

		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' secs'
		PRINT '------------------------------------------';

		SET @end_time = GETDATE();
		PRINT '>> Truncating the Table crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details ;

		PRINT '>> Inserting data to Table crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\Cidoy\Downloads\sql-data-warehouse-project (1)\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();

		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' secs'
		PRINT '------------------------------------------';


		PRINT '------------------------------------------';
		PRINT 'Loading ERP Tables';
		PRINT '------------------------------------------';

		SET @end_time = GETDATE();
		PRINT '>> Truncating the Table erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12 ;

		PRINT '>> Inserting data to Table erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\Cidoy\Downloads\sql-data-warehouse-project (1)\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();

		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' secs'
		PRINT '------------------------------------------';

		SET @end_time = GETDATE();
		PRINT '>> Truncating the Table erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101;

		PRINT '>> Inserting data to Table erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\Cidoy\Downloads\sql-data-warehouse-project (1)\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();

		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' secs'
		PRINT '------------------------------------------';

		SET @end_time = GETDATE();
		PRINT '>> Truncating the Table erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		PRINT '>> Inserting data to Table erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\Cidoy\Downloads\sql-data-warehouse-project (1)\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();

		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' secs'
		PRINT '------------------------------------------';

		SET @batch_end_time = GETDATE()
		PRINT '=========================================='
		PRINT 'Loading Bronze Layer is Completed';
		PRINT '      - Total Load Duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
		PRINT '=========================================='
	END TRY

	BEGIN CATCH
		PRINT '================================';
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
		PRINT 'Error Message: ' + ERROR_MESSAGE();
		PRINT 'Error Number: '  + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error State: '   + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '================================';
	END CATCH
END
