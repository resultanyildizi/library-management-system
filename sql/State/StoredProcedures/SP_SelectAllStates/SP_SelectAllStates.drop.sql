-- Drop the stored procedure called 'SP_SelectAllStates' in schema 'dbo'
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_SelectAllStates'
)
DROP PROCEDURE dbo.SP_SelectAllStates
GO