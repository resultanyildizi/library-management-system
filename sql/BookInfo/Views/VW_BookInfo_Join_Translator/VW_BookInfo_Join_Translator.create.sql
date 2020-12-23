-- Create a new view called 'VW_BookInfo_Join_Translator' in schema 'dbo'
-- Drop the view if it already exists
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
-- Create the view in the specified schema
CREATE VIEW dbo.VW_BookInfo_Join_Translator
AS
    -- body of the view
    SELECT [bookInfoId], COALESCE([Author].[fullName], N'Not defined') AS [translatorName]
    FROM dbo.[BookInfo]
        LEFT JOIN dbo.[Author]
        ON [BookInfo].[translatorId] = [Author].[authorId]
GO