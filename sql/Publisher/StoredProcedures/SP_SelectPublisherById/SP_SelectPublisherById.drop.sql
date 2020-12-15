-- Drop the stored procedure called 'SP_SelectPublisherById' in schema 'dbo'
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_SelectPublisherById'
)
DROP PROCEDURE dbo.SP_SelectPublisherById
GO