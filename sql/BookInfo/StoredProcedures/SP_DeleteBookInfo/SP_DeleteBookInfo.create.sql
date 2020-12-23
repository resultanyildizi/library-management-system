-- Create a new stored procedure called 'SP_DeleteBookInfo' in schema 'dbo'
-- Drop the stored procedure if it already exists
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_DeleteBookInfo'
)
DROP PROCEDURE dbo.SP_DeleteBookInfo
GO
-- Create the stored procedure in the specified schema
CREATE PROCEDURE dbo.SP_DeleteBookInfo
    @bookInfoId INT
-- add more stored procedure parameters here
AS
DELETE FROM dbo.[BookInfo] WHERE [bookInfoId] =  @bookInfoId
GO
