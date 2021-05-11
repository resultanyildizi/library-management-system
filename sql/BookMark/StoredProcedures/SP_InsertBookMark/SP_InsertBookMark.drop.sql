-- Drop the stored procedure called 'SP_InsertBookMark' in schema 'dbo'
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_InsertBookMark'
)
DROP PROCEDURE dbo.SP_InsertBookMark
GO