-- Drop the function 'FN_ProperCase' in schema 'dbo'
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'FN_ProperCase'
)
DROP FUNCTION dbo.[FN_ProperCase]
GO