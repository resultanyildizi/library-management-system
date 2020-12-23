-- Create a new stored procedure called 'SP_UpdateBookInfo' in schema 'dbo'
-- Drop the stored procedure if it already exists
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_UpdateBookInfo'
)
DROP PROCEDURE dbo.SP_UpdateBookInfo
GO
-- Create the stored procedure in the specified schema
CREATE PROCEDURE dbo.SP_UpdateBookInfo
    @bookInfoId INT,
    @languageId INT = NULL,
    @pageCount INT = NULL,
    @image NVARCHAR(4000) = NULL,
    @publishYear DATE = NULL,
    @edition INT = NULL,
    @width FLOAT = NULL,
    @height FLOAT = NULL,
    @description NVARCHAR(1000) = NULL,
    @name NVARCHAR(200),
    @bookId INT OUTPUT
AS
UPDATE dbo.[BookInfo] SET
        [languageId] = @languageId, 
        [pageCount] = @pageCount, 
        [image] = @image,
        [publishYear] = @publishYear, 
        [edition] = @edition, 
        [width] =@width, 
        [height] = @height, 
        [description] = @description, 
        [name] = dbo.FN_ProperCase(@name)
        WHERE [bookInfoId] = @bookInfoId

-- Set last inserted book id
SET @bookId = @bookInfoId
GO