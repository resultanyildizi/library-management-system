-- Create a new stored procedure called 'SP_SelectAllBookInfos' in schema 'dbo'
-- Drop the stored procedure if it already exists
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_SelectAllBookInfos'
)
DROP PROCEDURE dbo.SP_SelectAllBookInfos
GO
-- Create the stored procedure in the specified schema
CREATE PROCEDURE dbo.SP_SelectAllBookInfos
    @orderType INT = 1
AS
SELECT *
FROM dbo.[VW_BookInfoJoinedAll]
ORDER BY 
    (   CASE @orderType 
        WHEN 1 THEN [name] END) ASC,
    (   CASE @orderType 
        WHEN 2 THEN [categoryName] END) ASC,
    (   CASE @orderType 
        WHEN 3 THEN [authorNames] END ) ASC,
    (   CASE @ordertype 
        WHEN 4 THEN COALESCE(CAST([pageCount]  AS NVARCHAR), 'z') END),
    (   CASE @orderType 
        WHEN 5 THEN CAST([score] AS NVARCHAR) END) DESC, [name] ASC
GO
-- example to execute the stored procedure we just created
EXECUTE dbo.SP_SelectAllBookInfos 5
GO