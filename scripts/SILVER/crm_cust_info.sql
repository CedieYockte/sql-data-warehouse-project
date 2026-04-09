TRUNCATE TABLE SILVER.crm_cust_info;
INSERT INTO SILVER.crm_cust_info(
	cst_id,
	cst_key,
	cst_firstname,
	cst_lastname,
	cst_material_status,
	cst_gndr,
	cst_create_date
)
SELECT
	cst_id,
	cst_key,
	TRIM(COALESCE(cst_firstname, 'unknown')) AS cst_firstname,
	TRIM(COALESCE(cst_lastname,'unknown')) AS cst_firstname,
	CASE 
		WHEN UPPER(TRIM(cst_material_status)) = 'S' THEN 'Single'
		WHEN UPPER(TRIM(cst_material_status)) = 'M' THEN 'Married'
		ELSE 'unknown'
	END cst_material_status,
	CASE 
		WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
		WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
		ELSE 'unknown'
	END cst_gndr,
	cst_create_date
FROM (
	SELECT
	*,
	ROW_NUMBER () OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) as flag_last
	FROM BRONZE.crm_cust_info
	WHERE cst_id IS NOT NULL
)t WHERE flag_last = 1
