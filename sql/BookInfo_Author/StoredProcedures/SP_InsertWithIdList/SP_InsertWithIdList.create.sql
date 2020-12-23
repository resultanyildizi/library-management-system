-- Create a new stored procedure called 'SP_InsertWithIdList' in schema 'dbo'
-- Drop the stored procedure if it already exists
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_InsertWithIdList'
)
DROP PROCEDURE dbo.SP_InsertWithIdList
GO
-- Create the stored procedure in the specified schema
CREATE PROCEDURE dbo.SP_InsertWithIdList
    @authorIdList NVARCHAR(MAX) = NULL,
    @bookInfoId INT
AS
BEGIN TRANSACTION
DELETE FROM dbo.[BookInfo_Author] WHERE [bookInfoId] = @bookInfoId
INSERT INTO dbo.[BookInfo_Author]
    ([bookInfoId], [authorId])
SELECT [bookInfoId] = @bookInfoId, [id] AS [authorId]
FROM dbo.[FN_ParseAuthorIdList](@authorIdList)
COMMIT TRANSACTION
GO
-- example to execute the stored procedure we just created
EXECUTE dbo.SP_InsertWithIdList @bookInfoId = 9000, @authorIdList = '[2001, 2002]'
GO
EXECUTE dbo.SP_InsertWithIdList @bookInfoId = 9000, @authorIdList = NULL
GO

SELECT *
FROM [BookInfo_Author]
