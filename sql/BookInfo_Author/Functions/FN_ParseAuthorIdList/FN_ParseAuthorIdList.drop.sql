-- Drop the function 'FN_ParseAuthorIdList' in schema 'dbo'
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'FN_ParseAuthorIdList'
)
DROP FUNCTION dbo.[FN_ParseAuthorIdList]
GO