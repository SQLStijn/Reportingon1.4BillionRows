-- https://docs.microsoft.com/en-us/azure/synapse-analytics/sql/resources-self-help-sql-on-demand
-- Data types
-- Parquet

SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK 'https://synapseinaday.dfs.core.windows.net/raw/TaxiAllString/part-00000-6e259931-a08e-486d-8909-c78b81f4b99d-c000.snappy.parquet',
        FORMAT = 'PARQUET'
    ) AS [result]

-- Check infered data types.
-- https://docs.microsoft.com/en-us/azure/synapse-analytics/sql/best-practices-serverless-sql-pool#check-inferred-data-types
 
  EXEC sp_describe_first_result_set N'
SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK ''https://synapseinaday.dfs.core.windows.net/raw/TaxiAllString/part-00000-6e259931-a08e-486d-8909-c78b81f4b99d-c000.snappy.parquet'',
        FORMAT = ''PARQUET''
    ) AS [result]
    '

-- drop view dbo.TaxiParquet_allstring_Data_type_inferred
Create view dbo.TaxiParquet_allstring_Data_type_inferred
AS
SELECT
    *
FROM
    OPENROWSET(
        BULK 'https://synapseinaday.dfs.core.windows.net/raw/TaxiAllString/*.snappy.parquet',
        FORMAT = 'PARQUET'
    ) AS [result]


-- Show code
select 
c.name, c.column_id, t.name,  c.max_length, c.precision, c.scale
 from sys.views v
inner join sys.columns c on c.object_id = v.object_id
inner join sys.types t on c.system_type_id = t.system_type_id
where v.name like 'TaxiParquet_allstring_Data_type_Inferance'
order by c.column_id asc

---------------------------------------------------------------
-- Create a view over parquet, with specific datatypes.

--drop view dbo.TaxiParquet_allstring_with_datatypes;

Create view dbo.TaxiParquet_allstring_with_datatypes
AS
SELECT
     *
FROM
    OPENROWSET(
        BULK 'https://synapseinaday.dfs.core.windows.net/raw/TaxiAllString/*.snappy.parquet',
        FORMAT = 'PARQUET'
    ) 
with (
[Passenger_Count] int,
[Trip_Distance] float,
[store_and_forward] bit,
[Payment_Type] int,
[mta_tax] numeric(10,2),
[vendorID] int,
[PULocationID] int,
[DOLocationID] int,
[tpep_pickup_datetime] datetime2,
[tpep_dropoff_datetime] datetime2,
[RatecodeID] int,
[Fare_amount] numeric(10,2),
[Extra] float,
[Tip_amount] numeric(10,2),
[Tolls_amount] numeric(10,2),
[Total_amount] numeric(10,2),
[Improvement_surcharge] numeric(10,2),
[congestion_surcharge] int,
[PickupDate] date,
[DropoffDate] date
) AS [result]


-- Show code
select 
c.name, c.column_id, t.name,  c.max_length, c.precision, c.scale
 from sys.views v
inner join sys.columns c on c.object_id = v.object_id
inner join sys.types t on c.system_type_id = t.system_type_id
where v.name like 'TaxiParquet_allstring_with_datatypes'
order by c.column_id asc


