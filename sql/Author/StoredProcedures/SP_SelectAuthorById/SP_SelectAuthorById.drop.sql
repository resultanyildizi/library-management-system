-- Drop the stored procedure called 'SP_SelectAuthorById' in schema 'dbo'
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_SelectAuthorById'
)
DROP PROCEDURE dbo.SP_SelectAuthorById
GO