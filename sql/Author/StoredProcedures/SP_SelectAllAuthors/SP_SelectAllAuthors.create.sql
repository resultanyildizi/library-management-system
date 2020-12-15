-- Create a new stored procedure called 'SP_SelectAllAuthors' in schema 'dbo'
-- Drop the stored procedure if it already exists
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_SelectAllAuthors'
)
DROP PROCEDURE dbo.SP_SelectAllAuthors
GO
-- Create the stored procedure in the specified schema
CREATE PROCEDURE dbo.SP_SelectAllAuthors
AS
-- body of the stored procedure
SELECT *
FROM dbo.[VW_AuthorCountryJoin]
ORDER BY [fullName]
GO
-- example to execute the stored procedure we just created
EXECUTE dbo.SP_SelectAllAuthors
GO