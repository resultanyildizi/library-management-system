-- Drop the view 'VW_JoinBookInfo_Author' in schema 'dbo'
IF EXISTS (
    SELECT *
FROM sys.views
    JOIN sys.schemas
    ON sys.views.schema_id = sys.schemas.schema_id
WHERE sys.schemas.name = N'dbo'
    AND sys.views.name = N'VW_JoinBookInfo_Author'
)
    DROP VIEW dbo.VW_JoinBookInfo_Author
GO