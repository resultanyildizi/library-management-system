-- Create a new view called 'VW_Author_Join_BookInfo_Author' in schema 'dbo'
-- Drop the view if it already exists
IF EXISTS (
SELECT *
FROM sys.views
    JOIN sys.schemas
    ON sys.views.schema_id = sys.schemas.schema_id
WHERE sys.schemas.name = N'dbo'
    AND sys.views.name = N'VW_Author_Join_BookInfo_Author'
)
DROP VIEW dbo.VW_Author_Join_BookInfo_Author
GO
-- Create the view in the specified schema
CREATE VIEW dbo.VW_Author_Join_BookInfo_Author
AS
    SELECT [A].[authorId] AS [authorId], COUNT([BI_A].[bookInfoId]) AS [bookCount]
    FROM dbo.[Author] AS [A]
        LEFT JOIN dbo.[BookInfo_Author] AS [BI_A]
        ON [A].[authorId] = [BI_A].[authorId]
    GROUP BY [A].[authorId], [A].[fullName], [A].[birthYear], [A].[image], [A].[countryId]
GO

SELECT *
FROM dbo.[VW_Author_Join_BookInfo_Author]