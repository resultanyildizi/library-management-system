-- Create a new stored procedure called 'SP_DeleteBookMark' in schema 'dbo'
-- Drop the stored procedure if it already exists
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_DeleteBookMark'
)
DROP PROCEDURE dbo.SP_DeleteBookMark
GO
-- Create the stored procedure in the specified schema
CREATE PROCEDURE dbo.SP_DeleteBookMark
    @bookMarkId INT
AS
DELETE FROM dbo.[BookMark] WHERE [bookMarkId] = @bookMarkId
GO