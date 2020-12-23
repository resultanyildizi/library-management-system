-- Create a new stored procedure called 'SP_UpdateCategoryId' in schema 'dbo'
-- Drop the stored procedure if it already exists
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_UpdateCategoryId'
)
DROP PROCEDURE dbo.SP_UpdateCategoryId
GO
-- Create the stored procedure in the specified schema
CREATE PROCEDURE dbo.SP_UpdateCategoryId
    @bookInfoId INT,
    @categoryId INT = NULL
AS
UPDATE dbo.[BookInfo] SET [categoryId] = @categoryId WHERE [bookInfoId] = @bookInfoId
GO

SELECT *
FROM dbo.[BookInfo] 