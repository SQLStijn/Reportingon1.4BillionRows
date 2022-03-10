-- bonus
-- https://github.com/lmoloney/SynapseExternalTableCreator
-- Thanks Luke! :-)

IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'SynapseParquetFormat') 
	CREATE EXTERNAL FILE FORMAT [SynapseParquetFormat] 
	WITH ( FORMAT_TYPE = PARQUET)
GO

IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'raw_synapseinaday_dfs_core_windows_net') 
	CREATE EXTERNAL DATA SOURCE [raw_synapseinaday_dfs_core_windows_net] 
	WITH (
		LOCATION = 'abfss://raw@synapseinaday.dfs.core.windows.net' 
	)
GO

DECLARE @InputFilePath					VARCHAR(MAX),
	@ExternalTableFileLocation		VARCHAR(MAX),
	@ExternalTableFileSource		VARCHAR(MAX),
	@ExternalTableFileFormat		VARCHAR(MAX),
	@ExternalTableSchema			VARCHAR(MAX),
	@ExternalTableName				VARCHAR(MAX)

set      @InputFilePath	='https://synapseinaday.dfs.core.windows.net/raw/TaxiAllString/part-00000-6e259931-a08e-486d-8909-c78b81f4b99d-c000.snappy.parquet';
set 	@ExternalTableFileLocation		='/raw/Sqlbitsdemo/exttable/';
set 	@ExternalTableFileSource		='';
set 	@ExternalTableFileFormat		='SynapseParquetFormat';
set 	@ExternalTableSchema			='dbo';
set 	@ExternalTableName				='sqlbitsexttable';


exec MakeExternalTableFromParquet @InputFilePath, @ExternalTableFileLocation, @ExternalTableFileFormat, @ExternalTableName



