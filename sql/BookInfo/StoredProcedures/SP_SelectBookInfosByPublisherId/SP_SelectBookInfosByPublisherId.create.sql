-- Create a new stored procedure called 'SP_SelectBookInfosByPublisherId' in schema 'dbo'
-- Drop the stored procedure if it already exists
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_SelectBookInfosByPublisherId'
)
DROP PROCEDURE dbo.SP_SelectBookInfosByPublisherId
GO
-- Create the stored procedure in the specified schema
CREATE PROCEDURE dbo.SP_SelectBookInfosByPublisherId
    @publisherId INT
-- add more stored procedure parameters here
AS
-- body of the stored procedure
SELECT *
FROM [VW_BookInfoJoinedAll]
WHERE [publisherId] = @publisherId
GO
-- example to execute the stored procedure we just created
EXECUTE dbo.SP_SelectBookInfosByPublisherId 1019
GO