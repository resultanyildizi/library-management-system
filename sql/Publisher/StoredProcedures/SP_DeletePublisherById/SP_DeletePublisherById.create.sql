-- Create a new stored procedure called 'SP_DeletePublisherById' in schema 'dbo'
-- Drop the stored procedure if it already exists
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_DeletePublisherById'
)
DROP PROCEDURE dbo.SP_DeletePublisherById
GO
-- Create the stored procedure in the specified schema
CREATE PROCEDURE dbo.SP_DeletePublisherById
    @id INT
AS
-- body of the stored procedure
DELETE FROM dbo.[Publisher] WHERE [publisherId] = @id
GO
-- example to execute the stored procedure we just created
EXECUTE dbo.SP_DeletePublisherById 1000
GO