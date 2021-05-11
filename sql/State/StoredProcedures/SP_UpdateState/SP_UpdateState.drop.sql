-- Drop the stored procedure called 'SP_UpdateState' in schema 'dbo'
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_UpdateState'
)
DROP PROCEDURE dbo.SP_UpdateState
GO