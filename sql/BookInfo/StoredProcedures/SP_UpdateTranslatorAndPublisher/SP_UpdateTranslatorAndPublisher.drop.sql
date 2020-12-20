-- Drop the stored procedure called 'SP_UpdateTranslatorAndPublisher' in schema 'dbo'
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_UpdateTranslatorAndPublisher'
)
DROP PROCEDURE dbo.SP_UpdateTranslatorAndPublisher
GO