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
SELECT P.*, BI.[bookCount]
FROM dbo.[VW_Publishers] AS P
    JOIN dbo.[VW_JoinBookInfo] AS BI
    ON P.[publisherId] = BI.[publisherId]
ORDER BY [name] ASC     
GO
EXECUTE dbo.SP_SelectAllPublishers 
GO