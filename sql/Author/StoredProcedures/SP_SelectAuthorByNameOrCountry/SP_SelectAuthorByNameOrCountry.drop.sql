-- Drop the stored procedure called 'SP_SelectAuthorByNameOrCountry' in schema 'dbo'
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_SelectAuthorByNameOrCountry'
)
DROP PROCEDURE dbo.SP_SelectAuthorByNameOrCountry
GO