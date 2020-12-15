-- Create a new stored procedure called 'SP_SelectAllCountries' in schema 'dbo'
-- Drop the stored procedure if it already exists
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_SelectAllCountries'
)
DROP PROCEDURE dbo.SP_SelectAllCountries
GO
-- Create the stored procedure in the specified schema
CREATE PROCEDURE dbo.SP_SelectAllCountries
AS
SELECT *
FROM dbo.[VW_SelectCountryName]
ORDER BY [countryName] ASC
GO

EXECUTE dbo.[SP_SelectAllCountries]