-- Drop the stored procedure called 'SP_InsertCategory' in schema 'dbo'
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_InsertCategory'
)
DROP PROCEDURE dbo.SP_InsertCategory
GO