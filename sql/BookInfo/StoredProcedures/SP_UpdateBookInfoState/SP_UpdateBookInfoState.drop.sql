-- Drop the stored procedure called 'SP_UpdateBookInfoState' in schema 'dbo'
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_UpdateBookInfoState'
)
DROP PROCEDURE dbo.SP_UpdateBookInfoState
GO