-- Create a new view called 'VW_AuthorsJoinedAll' in schema 'dbo'
-- Drop the view if it already exists
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
-- Create the view in the specified schema
CREATE VIEW dbo.VW_AuthorsJoinedAll
AS
    SELECT A.[authorId], [fullName], [birthYear], [image], [countryName], [bookCount], [translatedCount]
    FROM dbo.[VW_Authors] AS [A]
        JOIN [VW_Author_Join_Country] AS [C] ON [A].[authorId] = [C].[authorId]
        JOIN [VW_Author_Join_BookInfo_Author] AS [BI_A] ON [A].[authorId] = [BI_A].[authorId]
        JOIN [VW_Author_Join_BookInfo] AS [BI] ON [A].[authorId] = [BI].[authorId]
GO