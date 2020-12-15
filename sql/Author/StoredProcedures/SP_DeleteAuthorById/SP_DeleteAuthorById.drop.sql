-- Drop the stored procedure called 'SP_DeleteAuthorById' in schema 'dbo'
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_DeleteAuthorById'
)
DROP PROCEDURE dbo.SP_DeleteAuthorById
GO