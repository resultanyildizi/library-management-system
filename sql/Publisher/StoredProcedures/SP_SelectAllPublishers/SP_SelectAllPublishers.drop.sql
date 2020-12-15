-- Drop the stored procedure called 'SP_SelectAllPublishers' in schema 'dbo'
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_SelectAllPublishers'
)
DROP PROCEDURE dbo.SP_SelectAllPublishers
GO