-- Drop the stored procedure called 'SP_UpdateBookMark' in schema 'dbo'
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_UpdateBookMark'
)
DROP PROCEDURE dbo.SP_UpdateBookMark
GO