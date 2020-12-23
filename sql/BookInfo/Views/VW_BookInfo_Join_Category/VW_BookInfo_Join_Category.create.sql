-- Create a new view called 'VW_BookInfo_Join_Category' in schema 'dbo'
-- Drop the view if it already exists
IF EXISTS (
SELECT *
FROM sys.views
    JOIN sys.schemas
    ON sys.views.schema_id = sys.schemas.schema_id
WHERE sys.schemas.name = N'dbo'
    AND sys.views.name = N'VW_BookInfo_Join_Category'
)
DROP VIEW dbo.VW_BookInfo_Join_Category
GO
-- Create the view in the specified schema
CREATE VIEW dbo.VW_BookInfo_Join_Category
AS
    -- body of the view
    SELECT [bookInfoId], COALESCE([Category].[name], N'Book') AS [categoryName]
    FROM dbo.[BookInfo]
        LEFT JOIN dbo.[Category]
        ON [BookInfo].[categoryId] = [Category].[categoryId]
GO