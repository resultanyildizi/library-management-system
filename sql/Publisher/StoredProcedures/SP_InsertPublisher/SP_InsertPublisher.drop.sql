-- Drop the stored procedure called 'SP_InsertPublisher' in schema 'dbo'
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_InsertPublisher'
)
DROP PROCEDURE dbo.SP_InsertPublisher
GO