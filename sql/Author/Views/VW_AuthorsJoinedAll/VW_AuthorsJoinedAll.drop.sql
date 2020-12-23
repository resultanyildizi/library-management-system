-- Drop the view 'VW_AuthorsJoinedAll' in schema 'dbo'
IF EXISTS (
    SELECT *
FROM sys.views
    JOIN sys.schemas
    ON sys.views.schema_id = sys.schemas.schema_id
WHERE sys.schemas.name = N'dbo'
    AND sys.views.name = N'VW_AuthorsJoinedAll'
)
    DROP VIEW dbo.VW_AuthorsJoinedAll
GO