-- Create a new stored procedure called 'SP_DeleteAuthorById' in schema 'dbo'
-- Drop the stored procedure if it already exists
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_DeleteAuthorById'
)
DROP PROCEDURE dbo.SP_DeleteAuthorById
GO
-- Create the stored procedure in the specified schema
CREATE PROCEDURE dbo.SP_DeleteAuthorById
    @id INT
AS
-- body of the stored procedure
DELETE FROM dbo.[Author] WHERE [authorId] = @id
GO
-- example to execute the stored procedure we just created
EXECUTE dbo.SP_DeleteAuthorById 4
GO