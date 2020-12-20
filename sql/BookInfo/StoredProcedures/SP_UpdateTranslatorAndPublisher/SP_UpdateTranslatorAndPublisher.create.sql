-- Create a new stored procedure called 'SP_UpdateTranslatorAndPublisher' in schema 'dbo'
-- Drop the stored procedure if it already exists
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_UpdateTranslatorAndPublisher'
)
DROP PROCEDURE dbo.SP_UpdateTranslatorAndPublisher
GO
-- Create the stored procedure in the specified schema
CREATE PROCEDURE dbo.SP_UpdateTranslatorAndPublisher
    @bookInfoId INT ,
    @translatorId INT = NULL,
    @publisherId INT = NULL
AS
UPDATE dbo.[BookInfo] SET 
    [translatorId] = @translatorId, [publisherId] = @publisherId 
WHERE [bookInfoId] = @bookInfoId
GO


EXECUTE dbo.SP_UpdateTranslatorAndPublisher @publisherId = 1014, @bookInfoId = 9008

SELECT *
FROM [BookInfo]