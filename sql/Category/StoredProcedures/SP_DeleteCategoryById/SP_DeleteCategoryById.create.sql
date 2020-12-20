-- Create a new stored procedure called 'SP_DeleteCategoryById' in schema 'dbo'
-- Drop the stored procedure if it already exists
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_DeleteCategoryById'
)
DROP PROCEDURE dbo.SP_DeleteCategoryById
GO
-- Create the stored procedure in the specified schema
CREATE PROCEDURE dbo.SP_DeleteCategoryById
    @categoryId INT
AS
DELETE FROM dbo.[Category] WHERE [categoryId] = @categoryId
GO

EXECUTE SP_DeleteCategoryById @categoryId = 4003
SELECT *
FROM dbo.[Category]

