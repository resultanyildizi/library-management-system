-- Create the trigger 'TR_DeleteCategoryTrigger' in schema 'dbo'
-- Drop the trigger if it already exists
IF EXISTS (
SELECT *
FROM sys.triggers
WHERE TYPE=N'TR' AND NAME =N'TR_DeleteCategoryTrigger' 
)
DROP TRIGGER dbo.[TR_DeleteCategoryTrigger]
GO
CREATE TRIGGER [TR_DeleteCategoryTrigger] 
ON dbo.[Category] 
AFTER DELETE
AS 
BEGIN
    SET NOCOUNT ON

    DECLARE @deletedId INT
    DECLARE @newParentId INT

    SELECT @deletedId = [categoryId], @newParentId = [parentId]
    FROM DELETED

    SET NOCOUNT ON

    UPDATE
    dbo.[Category]
    SET [parentId] = @newParentId
    WHERE [parentId] = @deletedId

END 
GO


SELECT *
FROM [category]