-- Drop the view 'VW_BookInfo_Join_Translator' in schema 'dbo'
IF EXISTS (
    SELECT *
FROM sys.views
    JOIN sys.schemas
    ON sys.views.schema_id = sys.schemas.schema_id
WHERE sys.schemas.name = N'dbo'
    AND sys.views.name = N'VW_BookInfo_Join_Translator'
)
    DROP VIEW dbo.VW_BookInfo_Join_Translator
GO