-- Drop the stored procedure called 'SP_SelectAllCountries' in schema 'dbo'
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_SelectAllCountries'
)
DROP PROCEDURE dbo.SP_SelectAllCountries
GO