-- Create a new stored procedure called 'SP_SelectAdminByEmail' in schema 'dbo'
-- Drop the stored procedure if it already exists
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_SelectAdminByEmail'
)
DROP PROCEDURE dbo.SP_SelectAdminByEmail
GO
-- Create the stored procedure in the specified schema
CREATE PROCEDURE dbo.SP_SelectAdminByEmail
    @email NVARCHAR(60)
AS
-- selects a record from Admin table by given email
SELECT [adminId], [email], [hashedPassword]
FROM dbo.[Admin]
WHERE [email] = @email
GO
-- example to execute the stored procedure we just created
EXECUTE dbo.SP_SelectAdminByEmail @email = N'admin@nrt.com'
GO