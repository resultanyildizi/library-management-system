-- Drop the stored procedure called 'SP_DeleteBookInfo' in schema 'dbo'
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_DeleteBookInfo'
)
DROP PROCEDURE dbo.SP_DeleteBookInfo
GO