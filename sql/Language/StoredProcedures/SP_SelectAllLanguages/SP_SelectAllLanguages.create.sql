-- Create a new stored procedure called 'SP_SelectAllLanguages' in schema 'dbo'
-- Drop the stored procedure if it already exists
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_SelectAllLanguages'
)
DROP PROCEDURE dbo.SP_SelectAllLanguages
GO
-- Create the stored procedure in the specified schema
CREATE PROCEDURE dbo.SP_SelectAllLanguages
AS
SELECT *
FROM dbo.[Language]
GO
-- example to execute the stored procedure we just created
EXECUTE dbo.SP_SelectAllLanguages
GO