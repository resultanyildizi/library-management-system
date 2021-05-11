-- Drop the stored procedure called 'SP_SelectBookInfosByAuthorId' in schema 'SchemaName'
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'SchemaName'
    AND SPECIFIC_NAME = N'SP_SelectBookInfosByAuthorId'
)
DROP PROCEDURE SchemaName.SP_SelectBookInfosByAuthorId
GO