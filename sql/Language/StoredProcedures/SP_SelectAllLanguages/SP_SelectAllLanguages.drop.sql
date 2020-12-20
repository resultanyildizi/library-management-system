-- Drop the stored procedure called 'SP_SelectAllLanguages' in schema 'dbo'
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_SelectAllLanguages'
)
DROP PROCEDURE dbo.SP_SelectAllLanguages
GO