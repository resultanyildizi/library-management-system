-- Create a new stored procedure called 'SP_UpdateAndInsert' in schema 'dbo'
-- Drop the stored procedure if it already exists
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_UpdateAndInsert'
)
DROP PROCEDURE dbo.SP_UpdateAndInsert
GO
-- Create the stored procedure in the specified schema
CREATE PROCEDURE dbo.SP_UpdateAndInsert
    @bookInfoId INT,
    @publisherId INT = NULL,
    @translatorId INT = NULL,
    @authorIdList NVARCHAR(MAX) = NULL
AS
BEGIN TRANSACTION
EXEC dbo.[SP_UpdateTranslatorAndPublisher] @bookInfoId = @bookInfoId, @translatorId = @translatorId, @publisherId = @publisherId
EXEC dbo.[SP_InsertWithIdList] @bookInfoId = @bookInfoId, @authorIdList = @authorIdList
COMMIT TRANSACTION
GO

EXEC dbo.[SP_UpdateAndInsert] 
@bookInfoId = 9000, @translatorId = 2004, 
@publisherId = 1017, @authorIdList= N'[2003, 2004]'
GO

SELECT *
FROM dbo.[BookInfo_Author]

SELECT *
FROM dbo.[BookInfo]

DELETE FROM dbo.[BookInfo_Author]

DELETE FROM dbo.[BookInfo]
