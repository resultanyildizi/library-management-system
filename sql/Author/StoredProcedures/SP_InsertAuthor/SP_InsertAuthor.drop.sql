-- Drop the stored procedure called 'SP_InsertAuthor' in schema 'dbo'
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_InsertAuthor'
)
DROP PROCEDURE dbo.SP_InsertAuthor
GO