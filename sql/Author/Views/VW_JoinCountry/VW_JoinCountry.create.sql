-- Create a new view called 'VW_JoinCountry' in schema 'dbo'
-- Drop the view if it already exists
IF EXISTS (
SELECT *
FROM sys.views
    JOIN sys.schemas
    ON sys.views.schema_id = sys.schemas.schema_id
WHERE sys.schemas.name = N'dbo'
    AND sys.views.name = N'VW_JoinCountry'
)
DROP VIEW dbo.VW_JoinCountry
GO
-- Create the view in the specified schema
CREATE VIEW dbo.VW_JoinCountry
AS
    -- body of the view
    SELECT [Author].[authorId],
        COALESCE([Country].[countryName], N'Not defined') AS [countryName]
    FROM dbo.[Author]
        LEFT JOIN dbo.[Country]
        ON [Author].[countryId] = [Country].[countryId]

GO

SELECT *
FROM [VW_JoinCountry]
