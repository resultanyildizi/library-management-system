-- Drop the stored procedure called 'SP_DeleteCategoryById' in schema 'dbo'
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_DeleteCategoryById'
)
DROP PROCEDURE dbo.SP_DeleteCategoryById
GO