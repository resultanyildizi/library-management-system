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
AS
-- body of the stored procedure
SELECT A.[authorId], [fullName], [birthYear], [image], [countryName], [bookCount]
FROM dbo.[VW_Authors] AS [A]
    JOIN [VW_JoinCountry] AS [C] ON [A].[authorId] = [C].[authorId]
    JOIN [VW_JoinBookInfo_Author] AS [BI_A] ON [A].[authorId] = [BI_A].[authorId]
ORDER BY [fullName]
GO
-- example to execute the stored procedure we just created
EXECUTE dbo.SP_SelectAllAuthors
GO