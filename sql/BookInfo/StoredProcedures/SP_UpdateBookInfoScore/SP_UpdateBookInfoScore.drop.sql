-- Drop the stored procedure called 'SP_UpdateBookInfoScore' in schema 'dbo'
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_UpdateBookInfoScore'
)
DROP PROCEDURE dbo.SP_UpdateBookInfoScore
GO