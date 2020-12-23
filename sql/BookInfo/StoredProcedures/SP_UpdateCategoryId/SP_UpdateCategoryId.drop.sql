-- Drop the stored procedure called 'SP_UpdateCategory' in schema 'dbo'
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_UpdateCategory'
)
DROP PROCEDURE dbo.SP_UpdateCategory
GO