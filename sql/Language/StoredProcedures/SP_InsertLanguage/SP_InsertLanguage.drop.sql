-- Drop the stored procedure called 'SP_InsertLanguage' in schema 'dbo'
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_InsertLanguage'
)
DROP PROCEDURE dbo.SP_InsertLanguage
GO