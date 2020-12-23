-- Create a new view called 'VW_BookInfo_Join_Language' in schema 'dbo'
-- Drop the view if it already exists
IF EXISTS (
SELECT *
FROM sys.views
    JOIN sys.schemas
    ON sys.views.schema_id = sys.schemas.schema_id
WHERE sys.schemas.name = N'dbo'
    AND sys.views.name = N'VW_BookInfo_Join_Language'
)
DROP VIEW dbo.VW_BookInfo_Join_Language
GO
-- Create the view in the specified schema
CREATE VIEW dbo.VW_BookInfo_Join_Language
AS
    -- body of the view
    SELECT [bookInfoId], COALESCE([languageName], N'Not defined') AS [languageName]
    FROM dbo.[BookInfo]
        LEFT JOIN dbo.[Language]
        ON [BookInfo].[languageId]= [Language].[languageId] 
GO