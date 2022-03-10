-- https://docs.microsoft.com/en-us/azure/synapse-analytics/sql/resources-self-help-sql-on-demand
-- Data types
--
-- No data types on CSV right? Think again,  PARSER_VERSION = '2.0' helps us.
SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK 'https://synapseinaday.dfs.core.windows.net/raw/TaxiCSV/part-00000-5f36f745-9d55-4a58-ae9c-713a0276f38c-c000.csv',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0'
    ) AS [result]


-- Check infered data types.
-- https://docs.microsoft.com/en-us/azure/synapse-analytics/sql/best-practices-serverless-sql-pool#check-inferred-data-types
 
 EXEC sp_describe_first_result_set N'
 SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK ''https://synapseinaday.dfs.core.windows.net/raw/TaxiCSV/part-00000-5f36f745-9d55-4a58-ae9c-713a0276f38c-c000.csv'',
        FORMAT = ''CSV'',
        PARSER_VERSION = ''2.0''
    ) AS [result]
    '

-- Above is useful, but can we do better
-- drop view dbo.TaxiCSV_Data_type_Inferance 
Create view dbo.TaxiCSV_Data_type_inferred 
AS
SELECT
     *
FROM
    OPENROWSET(
        BULK 'https://synapseinaday.dfs.core.windows.net/raw/TaxiCSV/*.csv',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0'
    ) AS [result]

-- Show view in GUI!

-- Show code
select 
c.name, c.column_id, t.name,  c.max_length, c.precision, c.scale
 from sys.views v
inner join sys.columns c on c.object_id = v.object_id
inner join sys.types t on c.system_type_id = t.system_type_id
where v.name like 'TaxiCSV_Data_type_Inferance'
order by c.column_id asc



