---- SHOW  DIFFERENT FOLDERS 
---- NP AND PARTITIONED


---- DEFAULT SELECT FROM FILE
SELECT
    count(1)
FROM
    OPENROWSET(
        BULK 'https://synapseinaday.dfs.core.windows.net/raw/Taxi/2010/40509CBA-850E-4C36-AE4B-78AAD36CE960_675_0-1.parquet',
        FORMAT='PARQUET'
    ) AS [result];
GO



---- ALTER WITH WILDCARDS

SELECT
    count(1)
FROM
    OPENROWSET(
        BULK 'https://synapseinaday.dfs.core.windows.net/raw/Taxi/*/*.parquet',
        FORMAT='PARQUET'
    ) AS [result];
GO


---- Filepath function

SELECT
    count(1)
FROM
    OPENROWSET(
        BULK 'https://synapseinaday.dfs.core.windows.net/raw/Taxi/*/',
        FORMAT='PARQUET'
    ) AS [result]
where [result].filepath(1) = 2012;
GO


---- Create a view with the Year Column
USE Demo1;
GO

CREATE VIEW [dbo].[TaxiPartitionedByYear]
	AS 
SELECT
     *,result.filepath(1) as [Year]
FROM
    OPENROWSET(
        BULK 'https://synapseinaday.dfs.core.windows.net/raw/Taxi/*/',
        FORMAT = 'PARQUET'
    ) AS [result]


---- Create View Without the Year Column 

CREATE VIEW dbo.TaxiWithoutYear
AS
SELECT
     *
FROM
    OPENROWSET(
        BULK 'https://synapseinaday.dfs.core.windows.net/raw/TaxiNP/',
        FORMAT='PARQUET'
    ) AS [result];
GO



---- Get two queries by year


SELECT Sum(Total_amount), [Year] FROM TaxiPartitionedByYear WHERE [Year] in (2012,2013) GROUP BY [Year]
--VS
SELECT Sum(Total_amount), YEAR(tpep_pickup_datetime) FROM TaxiWithoutYear WHERE YEAR(tpep_pickup_datetime) in (2012,2013) GROUP BY YEAR(tpep_pickup_datetime)


