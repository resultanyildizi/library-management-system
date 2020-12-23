-- Create a new view called 'VW_BookInfo_Authors' in schema 'dbo'
-- Drop the view if it already exists
IF EXISTS (
SELECT *
FROM sys.views
    JOIN sys.schemas
    ON sys.views.schema_id = sys.schemas.schema_id
WHERE sys.schemas.name = N'dbo'
    AND sys.views.name = N'VW_BookInfo_Authors'
)
DROP VIEW dbo.VW_BookInfo_Authors
GO
-- Create the view in the specified schema
CREATE VIEW dbo.VW_BookInfo_Authors
AS
    -- body of the view
    SELECT BI_A.*, BI.[name] AS [bookName], A.[fullName] AS [authorName]
    FROM dbo.[BookInfo_Author] AS BI_A
        JOIN dbo.[BookInfo] AS BI
        ON BI_A.[bookInfoId] = BI.[bookInfoId]
        JOIN dbo.[Author] AS A ON BI_A.[authorId] = A.[authorId]
GO