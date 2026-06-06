--duckdb dw_marts.duckdb -c ".read build_dw_marts.sql"

-- Step 1: DW - Create Star Schema Tables
.read 01_create_tables_dw.sql

-- Step 2: DW - Load Data from CSV files into tables
.read 02_load_schema_dw.sql

-- Step 3: Mart - Create Flat Mart
.read 03_create_flat_mart.sql

-- Step 4: Create Skills Demand Mart
.read 04_create_skills_mart.sql

-- Step 5: Mart - Create Priority Mart
.read 05_create_priority_mart.sql

-- Step 6: Mart - Update Priority Roles Mart
.read 06_update_priority_mart.sql