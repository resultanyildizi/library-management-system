-- Create a new stored procedure called 'SP_SelectAuthorById' in schema 'dbo'
-- Drop the stored procedure if it already exists
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_SelectAuthorById'
)
DROP PROCEDURE dbo.SP_SelectAuthorById
GO
-- Create the stored procedure in the specified schema
CREATE PROCEDURE dbo.SP_SelectAuthorById
    @id INT
AS
SELECT *
FROM dbo.[VW_AuthorCountryJoin]
WHERE [authorId] = @id
GO
-- example to execute the stored procedure we just created
EXECUTE dbo.SP_SelectAuthorById 2005
GO