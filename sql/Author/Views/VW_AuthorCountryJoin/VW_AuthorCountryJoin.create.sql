-- Create a new view called 'VW_AuthorCountryJoin' in schema 'dbo'
-- Drop the view if it already exists
IF EXISTS (
SELECT *
FROM sys.views
    JOIN sys.schemas
    ON sys.views.schema_id = sys.schemas.schema_id
WHERE sys.schemas.name = N'dbo'
    AND sys.views.name = N'VW_AuthorCountryJoin'
)
DROP VIEW dbo.VW_AuthorCountryJoin
GO
-- Create the view in the specified schema
CREATE VIEW dbo.VW_AuthorCountryJoin
AS
    -- body of the view
    SELECT [Author].[authorId],
        [Author].[fullName],
        dbo.[FN_OnlyYear]([Author].[birthYear]) AS [birthYear],
        COALESCE([Author].[image], N'author/default_profile.jpg') AS [image],
        COALESCE([Country].[countryName], N'Not defined') AS [countryName]
    FROM dbo.[Author]
        LEFT JOIN dbo.[Country]
        ON [Author].[countryId] = [Country].[countryId]

GO
