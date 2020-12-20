-- Create a new stored procedure called 'SP_SelectCategoryByParentId' in schema 'dbo'
-- Drop the stored procedure if it already exists
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_SelectCategoryByParentId'
)
DROP PROCEDURE dbo.SP_SelectCategoryByParentId
GO
-- Create the stored procedure in the specified schema
CREATE PROCEDURE dbo.SP_SelectCategoryByParentId
    @parentId INT
-- add more stored procedure parameters here
AS
-- body of the stored procedure
IF @parentId IS NULL
    SELECT *
FROM dbo.[Category]
WHERE [parentId] IS NULL
ELSE
    SELECT*
FROM dbo.[Category]
WHERE [parentId] = @parentId
GO
-- example to execute the stored procedure we just created
EXECUTE dbo.SP_SelectCategoryByParentId @parentId = 4003