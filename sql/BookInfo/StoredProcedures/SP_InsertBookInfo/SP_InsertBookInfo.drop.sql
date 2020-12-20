-- Drop the stored procedure called 'SP_InsertBookInfo' in schema 'dbo'
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_InsertBookInfo'
)
DROP PROCEDURE dbo.SP_InsertBookInfo
GO