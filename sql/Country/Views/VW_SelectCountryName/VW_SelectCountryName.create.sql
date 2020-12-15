-- Create a new view called 'VW_SelectCountryName' in schema 'dbo'
-- Drop the view if it already exists
IF EXISTS (
SELECT *
FROM sys.views
    JOIN sys.schemas
    ON sys.views.schema_id = sys.schemas.schema_id
WHERE sys.schemas.name = N'dbo'
    AND sys.views.name = N'VW_SelectCountryName'
)
DROP VIEW dbo.VW_SelectCountryName
GO
-- Create the view in the specified schema
CREATE VIEW dbo.VW_SelectCountryName
AS
    -- body of the view
    SELECT [countryId], [countryName]
    FROM dbo.[Country] 
GO

SELECT *
FROM dbo.[VW_SelectCountryName]