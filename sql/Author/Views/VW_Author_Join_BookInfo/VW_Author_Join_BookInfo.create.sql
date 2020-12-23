-- Create a new view called 'VW_Author_Join_BookInfo' in schema 'dbo'
-- Drop the view if it already exists
IF EXISTS (
SELECT *
FROM sys.views
    JOIN sys.schemas
    ON sys.views.schema_id = sys.schemas.schema_id
WHERE sys.schemas.name = N'dbo'
    AND sys.views.name = N'VW_Author_Join_BookInfo'
)
DROP VIEW dbo.VW_Author_Join_BookInfo
GO
-- Create the view in the specified schema
CREATE VIEW dbo.VW_Author_Join_BookInfo
AS
    -- body of the view
    SELECT [authorId], COUNT([bookInfoId]) AS [translatedCount]
    FROM dbo.[Author] AS A
        LEFT JOIN dbo.[BookInfo] AS BI
        ON A.[authorId] = BI.[translatorId]
    GROUP  BY [authorId]
GO