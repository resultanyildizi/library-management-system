-- Create a new function called 'FN_ParseAuthorIdList' in schema 'dbo'
-- Drop the function if it already exists
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'FN_ParseAuthorIdList'
)
DROP FUNCTION dbo.[FN_ParseAuthorIdList]
GO
-- Create the function in the specified schema
CREATE FUNCTION dbo.[FN_ParseAuthorIdList](@ProviderList NVARCHAR(MAX))
-- determine the return type
RETURNS TABLE
AS
RETURN
SELECT CAST(p.[Value] AS INT) AS [id]
FROM OPENJSON(@ProviderList) p
GO
-- example to execute the function we just created
SELECT *
FROM dbo.[FN_ParseAuthorIdList]('[1001, 1002]')