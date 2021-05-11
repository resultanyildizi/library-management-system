-- Drop the view 'VW_BookMarks' in schema 'dbo'
IF EXISTS (
    SELECT *
FROM sys.views
    JOIN sys.schemas
    ON sys.views.schema_id = sys.schemas.schema_id
WHERE sys.schemas.name = N'dbo'
    AND sys.views.name = N'VW_BookMarks'
)
    DROP VIEW dbo.VW_BookMarks
GO