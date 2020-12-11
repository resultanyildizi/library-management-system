-- Drop the stored procedure called 'SP_InsertAdmin' in schema 'dbo'
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_InsertAdmin'
)
DROP PROCEDURE dbo.[SP_InsertAdmin]
GO