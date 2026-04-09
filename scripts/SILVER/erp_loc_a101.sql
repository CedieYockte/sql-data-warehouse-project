TRUNCATE TABLE SILVER.erp_loc_a101;
INSERT INTO SILVER.erp_loc_a101 (
	cid,
	cntry
)
SELECT
	REPLACE(cid, '-', '') AS cid, -- removes the hypen in the ID
	CASE
		WHEN TRIM(cntry) IN ('US','USA') THEN 'United States'
		WHEN TRIM(cntry) = 'DE' THEN 'Germany'
		WHEN TRIM(cntry) = '' OR TRIM(cntry) IS NULL THEN 'n/a'
		ELSE TRIM(cntry) 
	END	AS cntry -- Properly setup the country
FROM BRONZE.erp_loc_a101
