-- This is auto-generated code
SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK 'https://synapseinaday.dfs.core.windows.net/raw/TaxiNP/40509CBA-850E-4C36-AE4B-78AAD36CE960_675_0-1.parquet',
        FORMAT = 'PARQUET'
    ) AS [result]

-- Check inferred data types.
-- https://docs.microsoft.com/en-us/azure/synapse-analytics/sql/best-practices-serverless-sql-pool#check-inferred-data-types
 
  EXEC sp_describe_first_result_set N'
SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK ''https://synapseinaday.dfs.core.windows.net/raw/TaxiNP/40509CBA-850E-4C36-AE4B-78AAD36CE960_675_0-1.parquet'',
        FORMAT = ''PARQUET''
    ) AS [result]
    '


-- drop view dbo.TaxiParquet_np
Create view dbo.TaxiParquet_np
AS
SELECT
     *
FROM
    OPENROWSET(
        BULK 'https://synapseinaday.dfs.core.windows.net/raw/TaxiNP/40509CBA-850E-4C36-AE4B-78AAD36CE960_675_0-1.parquet',
        FORMAT = 'PARQUET'
    ) AS [result]


-- Show code
select 
c.name, c.column_id, t.name,  c.max_length, c.precision, c.scale
 from sys.views v
inner join sys.columns c on c.object_id = v.object_id
inner join sys.types t on c.system_type_id = t.system_type_id
where v.name like 'TaxiParquet_np'
order by c.column_id asc

/*
select 
'[' + c.name + '] ' + t.name + 
case t.name
when 'int'   then ''
when 'datetime2'   then ''
when 'float'   then ''
when 'bit'   then ''
when 'numeric' then '(' + convert(varchar(50),c.precision) + ',' + convert(varchar(50),c.scale) + ')' 
when 'varchar' then '(' + convert(varchar(50),c.max_length) + ')' 
else  ''  end + ',' as lent
--, c.precision, c.scale
 from sys.views v
inner join sys.columns c on c.object_id = v.object_id
inner join sys.types t on c.system_type_id = t.system_type_id
where v.name like 'TaxiParquet_np'
order by c.column_id asc
*/
