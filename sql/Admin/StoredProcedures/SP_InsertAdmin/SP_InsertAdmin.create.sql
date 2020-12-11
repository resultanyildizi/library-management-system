-- Create a new stored procedure called 'SP_InsertAdmin' in schema 'dbo'
-- Drop the stored procedure if it already exists
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_InsertAdmin'
)
DROP PROCEDURE dbo.[SP_InsertAdmin]
GO
-- Create the stored procedure in the specified schema
CREATE PROCEDURE dbo.[SP_InsertAdmin]
    @email NVARCHAR(60),
    @hashedPassword NVARCHAR(100)
AS
-- Inserts a new admin to the database
INSERT INTO dbo.[Admin]
VALUES
    (@email, @hashedPassword)
GO
-- example to execute the stored procedure we just created
