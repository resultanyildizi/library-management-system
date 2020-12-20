-- Drop the trigger 'TR_DeleteCategoryTrigger' in schema 'dbo'
IF EXISTS (
SELECT *
FROM sys.triggers
WHERE TYPE=N'TR' AND NAME =N'TR_DeleteCategoryTrigger' 
)
DROP TRIGGER dbo.[TR_DeleteCategoryTrigger]
GO