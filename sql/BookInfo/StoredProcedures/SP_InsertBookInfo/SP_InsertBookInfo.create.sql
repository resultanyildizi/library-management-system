-- Create a new stored procedure called 'SP_InsertBookInfo' in schema 'dbo'
-- Drop the stored procedure if it already exists
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_InsertBookInfo'
)
DROP PROCEDURE dbo.SP_InsertBookInfo
GO
-- Create the stored procedure in the specified schema
CREATE PROCEDURE dbo.SP_InsertBookInfo
    @translatorId INT = NULL,
    @publisherId INT = NULL,
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
INSERT INTO dbo.[BookInfo]
    ([translatorId], [publisherId], [languageId], [pageCount], [image],
    [publishYear], [edition], [width], [height],[description], [name])
VALUES
    (@translatorId, @publisherId, @languageId, @pageCount, @image,
        @publishYear, @edition, @width, @height, @description, dbo.FN_ProperCase(@name))

-- Set last inserted book id
SET @bookId = SCOPE_IDENTITY()
GO


SELECT *
FROM dbo.[bookInfo]