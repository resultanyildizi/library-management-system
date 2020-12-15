-- Drop the stored procedure called 'SP_SelectPublisherByName' in schema 'dbo'
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_SelectPublisherByName'
)
DROP PROCEDURE dbo.SP_SelectPublisherByName
GO