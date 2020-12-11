-- Drop the stored procedure called 'SP_SelectAdminById' in schema 'dbo'
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_SelectAdminById'
)
DROP PROCEDURE dbo.SP_SelectAdminById
GO