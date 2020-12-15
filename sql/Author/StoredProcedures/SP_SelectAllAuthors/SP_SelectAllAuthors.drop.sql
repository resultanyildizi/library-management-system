-- Drop the stored procedure called 'SP_SelectAllAuthors' in schema 'dbo'
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_SelectAllAuthors'
)
DROP PROCEDURE dbo.SP_SelectAllAuthors
GO