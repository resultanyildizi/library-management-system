-- Create a new view called 'VW_BookInfo_Join_BookInfo_Author' in schema 'dbo'
-- Drop the view if it already exists
IF EXISTS (
SELECT *
FROM sys.views
    JOIN sys.schemas
    ON sys.views.schema_id = sys.schemas.schema_id
WHERE sys.schemas.name = N'dbo'
    AND sys.views.name = N'VW_BookInfo_Join_BookInfo_Author'
)
DROP VIEW dbo.VW_BookInfo_Join_BookInfo_Author
GO
-- Create the view in the specified schema
CREATE VIEW dbo.VW_BookInfo_Join_BookInfo_Author
AS
    -- body of the view
    SELECT [BookInfo].[bookInfoId],
        COALESCE(STRING_AGG(CONVERT(NVARCHAR, [authorName]), ', '), N'Not defined') AS [authorNames],
        STRING_AGG(CONVERT(NVARCHAR, [authorId]), ', ') AS [authorIds]
    FROM dbo.[BookInfo]
        LEFT JOIN dbo.[VW_BookInfo_Authors] AS [BI_A]
        ON [BookInfo].[bookInfoId] = [BI_A].[bookInfoId]
    GROUP BY [BookInfo].[bookInfoId]
GO