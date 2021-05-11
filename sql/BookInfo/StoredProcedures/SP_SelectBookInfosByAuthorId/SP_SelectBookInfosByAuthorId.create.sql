-- Create a new stored procedure called 'SP_SelectBookInfosByAuthorId' in schema 'dbo'
-- Drop the stored procedure if it already exists
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_SelectBookInfosByAuthorId'
)
DROP PROCEDURE dbo.SP_SelectBookInfosByAuthorId
GO
-- Create the stored procedure in the specified schema
CREATE PROCEDURE dbo.SP_SelectBookInfosByAuthorId
    @authorId INT
-- add more stored procedure parameters here
AS
-- body of the stored procedure
SELECT BI_JA.*
FROM [BookInfo_Author] BI_A
    JOIN [VW_BookInfoJoinedAll] BI_JA
    ON [BI_A].[bookInfoId] = [BI_JA].[bookInfoId]
WHERE [authorId] = @authorId OR [translatorId] = @authorId
GO
-- example to execute the stored procedure we just created
EXECUTE dbo.SP_SelectBookInfosByAuthorId 2038