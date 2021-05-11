-- Drop the stored procedure called 'SP_SelectBookMark' in schema 'dbo'
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_SelectBookMar'
)
DROP PROCEDURE dbo.SP_SelectBookMar
GO