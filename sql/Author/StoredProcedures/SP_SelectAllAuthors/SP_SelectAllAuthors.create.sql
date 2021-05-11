-- Create a new stored procedure called 'SP_SelectAllAuthors' in schema 'dbo'
-- Drop the stored procedure if it already exists
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_SelectAllAuthors'
)
DROP PROCEDURE dbo.SP_SelectAllAuthors
GO
-- Create the stored procedure in the specified schema
CREATE PROCEDURE dbo.SP_SelectAllAuthors
    @orderType INT = 2
AS
-- body of the stored procedure
SELECT *
FROM [VW_AuthorsJoinedAll]
ORDER BY 
(CASE @orderType WHEN 1 THEN [fullName] END) ASC,
(CASE @orderType WHEN 2 THEN CAST([bookCount] AS NVARCHAR) END) DESC,
(CASE @orderType WHEN 3 THEN CAST([translatedCount] AS NVARCHAR) END) DESC, 
(CASE @orderType WHEN 4 THEN [countryName] END) ASC, [fullName] ASC
GO
-- example to execute the stored procedure we just created
EXECUTE dbo.SP_SelectAllAuthors 3
GO