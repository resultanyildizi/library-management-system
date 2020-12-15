-- Create a new stored procedure called 'SP_SelectAllPublishers' in schema 'dbo'
-- Drop the stored procedure if it already exists
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_SelectAllPublishers'
)
DROP PROCEDURE dbo.SP_SelectAllPublishers
GO
-- Create the stored procedure in the specified schema
CREATE PROCEDURE dbo.SP_SelectAllPublishers
AS
-- body of the stored procedure
SELECT
    [publisherId],
    [name],
    COALESCE([description], SPACE(20)) AS [description],
    dbo.[FN_OnlyYear]([foundationYear]) AS [foundationYear],
    COALESCE([image], N'publisher/default_publisher.jpg') AS [image]
FROM dbo.[Publisher]
ORDER BY [name] ASC     
GO
EXECUTE dbo.SP_SelectAllPublishers 
GO