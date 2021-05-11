-- Create a new stored procedure called 'SP_UpdateBookMark' in schema 'dbo'
-- Drop the stored procedure if it already exists
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_UpdateBookMark'
)
DROP PROCEDURE dbo.SP_UpdateBookMark
GO
-- Create the stored procedure in the specified schema
CREATE PROCEDURE dbo.SP_UpdateBookMark
    @bookMarkId INT,
    @note NVARCHAR(4000) = NULL,
    @page INT = NULL
AS
-- body of the stored procedure
UPDATE dbo.[BookMark] 
SET 
[note] = @note, 
[page] = @page 
WHERE [bookMarkId]  = @bookMarkId

GO

SELECT *
FROM dbo.[BookInfo]