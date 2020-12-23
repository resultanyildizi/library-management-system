-- Drop the view 'VW_Publisher_Join_BookInfo' in schema 'dbo'
IF EXISTS (
    SELECT *
FROM sys.views
    JOIN sys.schemas
    ON sys.views.schema_id = sys.schemas.schema_id
WHERE sys.schemas.name = N'dbo'
    AND sys.views.name = N'VW_Publisher_Join_BookInfo'
)
    DROP VIEW dbo.VW_Publisher_Join_BookInfo
GO