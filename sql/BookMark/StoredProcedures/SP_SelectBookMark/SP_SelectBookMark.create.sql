-- Create a new stored procedure called 'SP_SelectBookMark' in schema 'dbo'
-- Drop the stored procedure if it already exists
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_SelectBookMark'
)
DROP PROCEDURE dbo.SP_SelectBookMark
GO
-- Create the stored procedure in the specified schema
CREATE PROCEDURE dbo.SP_SelectBookMark
    @bookInfoId INT
AS
SELECT *
FROM [VW_BookMarks]
WHERE [bookInfoId] = @bookInfoId
ORDER BY [createdAt] DESC
GO
-- example to execute the stored procedure we just created
EXECUTE dbo.SP_SelectBookMark 7000
GO