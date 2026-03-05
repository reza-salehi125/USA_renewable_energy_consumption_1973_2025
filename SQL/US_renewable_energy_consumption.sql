CREATE TABLE YOUR_PROJECT_NAME.YOUR_DATASET_NAME.YOUR_DATASET_NAME AS
  WITH tables_combined AS (
    SELECT 
      *
    FROM 
      YOUR_PROJECT_NAME.YOUR_DATASET_NAME.commercial
    UNION ALL
    SELECT 
      *
    FROM 
      YOUR_PROJECT_NAME.YOUR_DATASET_NAME.electric_power
    UNION ALL
    SELECT 
      *
    FROM 
      YOUR_PROJECT_NAME.YOUR_DATASET_NAME.industrial
    UNION ALL
    SELECT 
      *
    FROM 
      YOUR_PROJECT_NAME.YOUR_DATASET_NAME.residential
    UNION ALL
    SELECT 
      *
    FROM 
      YOUR_PROJECT_NAME.YOUR_DATASET_NAME.transportation
  )
  SELECT DISTINCT
    EXTRACT(DATE FROM SAFE.PARSE_TIMESTAMP('%Y-%m-%d %H:%M', date)) AS date,
    EXTRACT(YEAR FROM SAFE.PARSE_TIMESTAMP('%Y-%m-%d %H:%M', date)) AS year,
    CASE
      WHEN EXTRACT(YEAR FROM SAFE.PARSE_TIMESTAMP('%Y-%m-%d %H:%M', date)) >= 1973 AND EXTRACT(YEAR FROM SAFE.PARSE_TIMESTAMP('%Y-%m-%d %H:%M', date)) <= 1989 THEN '1973-1989'
      WHEN EXTRACT(YEAR FROM SAFE.PARSE_TIMESTAMP('%Y-%m-%d %H:%M', date)) >= 1990 AND EXTRACT(YEAR FROM SAFE.PARSE_TIMESTAMP('%Y-%m-%d %H:%M', date)) <= 2007 THEN '1990-2007'
      ELSE '2008-2025'
    END AS time_window,
    sector,
    energy_type,
    ROUND(SAFE_CAST(value_trillion_btu AS FLOAT64), 3) AS value_trillion_btu
  FROM 
    tables_combined
  WHERE
    SAFE_CAST(value_trillion_btu AS FLOAT64) >= 0;

