-- Drop the stored procedure called 'SP_SelectAllBookInfos' in schema 'dbo'
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_SelectAllBookInfos'
)
DROP PROCEDURE dbo.SP_SelectAllBookInfos
GO