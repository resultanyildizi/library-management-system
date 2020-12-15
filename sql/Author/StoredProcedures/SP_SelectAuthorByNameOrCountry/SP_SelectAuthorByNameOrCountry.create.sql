-- Create a new stored procedure called 'SP_SelectAuthorByNameOrCountry' in schema 'dbo'
-- Drop the stored procedure if it already exists
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_SelectAuthorByNameOrCountry'
)
DROP PROCEDURE dbo.SP_SelectAuthorByNameOrCountry
GO
-- Create the stored procedure in the specified schema
CREATE PROCEDURE dbo.SP_SelectAuthorByNameOrCountry
    @name NVARCHAR(100)
AS
SELECT *
FROM dbo.[VW_AuthorCountryJoin]
WHERE [fullName] LIKE '%' + @name + '%' OR [countryName] LIKE '%' + @name + '%'
ORDER BY [fullName]
GO
-- example to execute the stored procedure we just created
EXECUTE dbo.SP_SelectAuthorByNameOrCountry N'j. k.'
GO
EXECUTE dbo.SP_SelectAuthorByNameOrCountry N'tur'
GO

