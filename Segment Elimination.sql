---- Switch to Notebook Show Statistics of that file


---- Read two rowgroup
SELECT
    sum(Total_amount),vendorID,cast(tpep_pickup_datetime as date)
FROM
    OPENROWSET(
        BULK 'https://synapseinaday.dfs.core.windows.net/precon/Demo2/PULocIDOrderParquet.parquet',
        FORMAT='PARQUET'
    ) AS [result]
    where PULocationID = 3
    group by vendorID,cast(tpep_pickup_datetime as date)


----- Read one rowgroup
SELECT
   sum(Total_amount),vendorID,cast(tpep_pickup_datetime as date)
FROM
    OPENROWSET(
        BULK 'https://synapseinaday.dfs.core.windows.net/precon/Demo2/PULocIDOrderParquet.parquet',
        FORMAT='PARQUET'
    ) AS [result]
    where PULocationID = 2    
GROUP BY vendorID,cast(tpep_pickup_datetime as date);
GO

--- CREATE SORTED VIEW
CREATE VIEW dbo.TaxiSortedPartitioned
AS
SELECT
    *,result.filepath(1) as [Year]
FROM
    OPENROWSET(
        BULK 'https://synapseinaday.dfs.core.windows.net/precon/Demo6/SegmentE4/TheYear=*/',
        FORMAT = 'PARQUET'
    ) AS [result];

GO


---------CREATE VIEW with limited column chunks
ALTER VIEW dbo.TaxiColumnChunks
AS
SELECT tpep_dropoff_datetime,
Passenger_Count,
DropoffDate,
vendorID,
Total_amount,
PULocationID,
Tip_amount,
result.filepath(1) as [Year]
FROM
    OPENROWSET(
        BULK 'https://synapseinaday.dfs.core.windows.net/precon/Demo6/SegmentE4/TheYear=*/',
        FORMAT = 'PARQUET'
    ) AS [result]


--- CREATE SORTED VIEW




