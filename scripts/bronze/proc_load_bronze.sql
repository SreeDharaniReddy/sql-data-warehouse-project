/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/

exec Bronze.load_bronze
create or alter procedure Bronze.load_bronze as
begin
    declare @start_time datetime, @end_time datetime, @batch_start_time datetime, @batch_end_time datetime;
    begin try
   
   set @batch_start_time = getdate();
        print '============================================================================';
        print 'Loading Bronze Layer';
        print '============================================================================';

        print '----------------------------------------------------------------------------';
        print 'Loading CRM Tables';
        print '----------------------------------------------------------------------------';

        set @start_time = getdate();       
        PRINT '>> Truncating Table: Bronze.crm_cust_info';
        truncate table Bronze.crm_cust_info;

        PRINT '>> Inserting Data Into: Bronze.crm_cust_info';
        BULK INSERT Bronze.crm_cust_info
        from 'C:\Users\sanap\OneDrive\Desktop\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
        with (
             firstrow = 2,
             fieldterminator = ',',
             tablock
        );
        set @end_time = getdate();
        print '>> Load Duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + ' seconds';
        print '>> ----------------------';

        set @start_time = getdate(); 
        PRINT '>> Truncating Table: Bronze.crm_prd_info';
        truncate table Bronze.crm_prd_info;
        PRINT '>> Inserting Data Into: Bronze.crm_prd_info';
        BULK INSERT Bronze.crm_prd_info
        from 'C:\Users\sanap\OneDrive\Desktop\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
        with (
             firstrow = 2,
             fieldterminator = ',',
             tablock
        );
        set @end_time = getdate();
        print '>> Load Duration: ' + cast(datediff(second, @start_time,@end_time) as nvarchar) + 'seconds';
        print '----------------------';

        set @start_time = getdate(); 
        PRINT '>> Truncating Table: Bronze.crm_sales_details';
        truncate table Bronze.crm_sales_details;
        PRINT '>> Inserting Data Into: Bronze.crm_sales_details';
        BULK INSERT Bronze.crm_sales_details
        from 'C:\Users\sanap\OneDrive\Desktop\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
        with (
             firstrow = 2,
             fieldterminator = ',',
             tablock
        );
        set @end_time = getdate();
        print '>> Load Duration: ' + cast(datediff(second, @start_time,@end_time) as nvarchar) + 'seconds';
        print '----------------------';

        print '----------------------------------------------------------------------------';
        print 'Loading ERP Tables';
        print '----------------------------------------------------------------------------';

        set @start_time = getdate(); 
        PRINT '>> Truncating Table: Bronze.erp_cust_az12';
        truncate table Bronze.erp_cust_az12;
        PRINT '>> Inserting Data Into: Bronze.erp_cust_az12';
        BULK INSERT Bronze.erp_cust_az12
        from 'C:\Users\sanap\OneDrive\Desktop\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
        with (
             firstrow = 2,
             fieldterminator = ',',
             tablock
        );
        set @end_time = getdate();
        print '>> Load Duration: ' + cast(datediff(second, @start_time,@end_time) as nvarchar) + 'seconds';
        print '----------------------';

        set @start_time = getdate(); 
        PRINT '>> Truncating Table: Bronze.erp_loc_a101';
        truncate table Bronze.erp_loc_a101;
        PRINT '>> Inserting Data Into: Bronze.erp_loc_a101';
        BULK INSERT Bronze.erp_loc_a101
        from 'C:\Users\sanap\OneDrive\Desktop\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
        with (
             firstrow = 2,
             fieldterminator = ',',
             tablock
        );
        set @end_time = getdate();
        print '>> Load Duration: ' + cast(datediff(second, @start_time,@end_time) as nvarchar) + 'seconds';
        print '----------------------';

        set @start_time = getdate(); 
        PRINT '>> Truncating Table: Bronze.erp_px_cat_g1v2';
        truncate table Bronze.erp_px_cat_g1v2;
        PRINT '>> Inserting Data Into: Bronze.erp_px_cat_g1v2';
        BULK INSERT Bronze.erp_px_cat_g1v2
        from 'C:\Users\sanap\OneDrive\Desktop\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
        with (
             firstrow = 2,
             fieldterminator = ',',
             tablock
        );
        set @end_time = getdate();
        print '>> Load Duration: ' + cast(datediff(second, @start_time,@end_time) as nvarchar) + 'seconds';
        print '----------------------';
        set @batch_end_time = getdate();
        print '=======================================================';
        print 'Loading Bronze Layer is Completed';
        print '    - Total Load Duration: ' + cast(datediff(second, @batch_start_time, @batch_end_time) as nvarchar) + 'seconds';
        print '=======================================================';
    end try
    begin catch 
        print '=======================================================================';
        print 'Error occured during loading bronze layer';
        print 'Error Message' + error_message();
        print 'Error Message' + cast (error_number() as nvarchar);
        print 'Error Message' + cast (error_state() as nvarchar);
        print '=======================================================================';

    end catch

end
