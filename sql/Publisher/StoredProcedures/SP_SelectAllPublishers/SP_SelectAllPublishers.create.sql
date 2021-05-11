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
    @orderType INT = 2
AS
-- body of the stored procedure
SELECT *
FROM [VW_PublishersJoinedAll]
ORDER BY 
(   CASE @orderType WHEN 1 THEN [name] END ) ASC,
(   CASE @orderType WHEN 2 THEN CAST([bookCount] AS NVARCHAR)  END) DESC, [name] ASC
GO
EXECUTE dbo.SP_SelectAllPublishers 2
GO  