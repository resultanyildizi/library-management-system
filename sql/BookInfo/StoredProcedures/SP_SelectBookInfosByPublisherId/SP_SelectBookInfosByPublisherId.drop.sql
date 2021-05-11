-- Drop the stored procedure called 'SP_SelectBookInfodByPublisherId' in schema 'dbo'
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_SelectBookInfodByPublisherId'
)
DROP PROCEDURE dbo.SP_SelectBookInfodByPublisherId
GO