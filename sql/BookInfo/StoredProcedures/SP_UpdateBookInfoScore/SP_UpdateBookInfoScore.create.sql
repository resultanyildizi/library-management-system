-- Create a new stored procedure called 'SP_UpdateBookInfoScore' in schema 'dbo'
-- Drop the stored procedure if it already exists
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_UpdateBookInfoScore'
)
DROP PROCEDURE dbo.SP_UpdateBookInfoScore
GO
-- Create the stored procedure in the specified schema
CREATE PROCEDURE dbo.SP_UpdateBookInfoScore
    @bookInfoId INT,
    @score INT = 0
AS
UPDATE dbo.[BookInfo] SET [score] = @score WHERE [bookInfoId] = @bookInfoId
GO
-- example to execute the stored procedure we just created
EXECUTE dbo.SP_UpdateBookInfoScore 9007, 5
GO