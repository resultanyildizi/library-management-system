-- Drop the stored procedure called 'SP_InsertState' in schema 'dbo'
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_InsertState'
)
DROP PROCEDURE dbo.SP_InsertState
GO