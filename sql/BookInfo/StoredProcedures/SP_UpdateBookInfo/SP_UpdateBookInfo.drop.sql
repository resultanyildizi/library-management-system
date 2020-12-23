-- Drop the stored procedure called 'SP_UpdateBookInfo' in schema 'dbo'
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_UpdateBookInfo'
)
DROP PROCEDURE dbo.SP_UpdateBookInfo
GO