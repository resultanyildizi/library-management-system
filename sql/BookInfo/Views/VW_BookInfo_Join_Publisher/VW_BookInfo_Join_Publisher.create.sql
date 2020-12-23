-- Create a new view called 'VW_BookInfo_Join_Publisher' in schema 'dbo'
-- Drop the view if it already exists
IF EXISTS (
SELECT *
FROM sys.views
    JOIN sys.schemas
    ON sys.views.schema_id = sys.schemas.schema_id
WHERE sys.schemas.name = N'dbo'
    AND sys.views.name = N'VW_BookInfo_Join_Publisher'
)
DROP VIEW dbo.VW_BookInfo_Join_Publisher
GO
-- Create the view in the specified schema
CREATE VIEW dbo.VW_BookInfo_Join_Publisher
AS
    -- body of the view
    SELECT [bookInfoId], COALESCE([Publisher].[name], N'Not defined') AS [publisherName]
    FROM dbo.[BookInfo]
        LEFT JOIN dbo.[Publisher]
        ON [BookInfo].[publisherId] = [Publisher].[publisherId]
GO