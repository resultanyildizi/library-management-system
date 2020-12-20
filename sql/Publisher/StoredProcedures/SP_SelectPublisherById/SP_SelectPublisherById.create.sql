-- Create a new stored procedure called 'SP_SelectPublisherById' in schema 'dbo'
-- Drop the stored procedure if it already exists
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_SelectPublisherById'
)
DROP PROCEDURE dbo.SP_SelectPublisherById
GO
-- Create the stored procedure in the specified schema
CREATE PROCEDURE dbo.SP_SelectPublisherById
    @id INT
-- selects a publisher by name
AS
SELECT *
FROM dbo.[Publisher]
WHERE [publisherId] = @id 
GO


EXECUTE dbo.SP_SelectPublisherById @id = 1000
GO