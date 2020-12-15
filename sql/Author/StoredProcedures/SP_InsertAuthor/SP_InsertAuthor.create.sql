-- Create a new stored procedure called 'SP_InsertAuthor' in schema 'dbo'
-- Drop the stored procedure if it already exists
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_InsertAuthor'
)
DROP PROCEDURE dbo.SP_InsertAuthor
GO
-- Create the stored procedure in the specified schema
CREATE PROCEDURE dbo.SP_InsertAuthor
    @fullName NVARCHAR(100),
    @birthYear DATE,
    @image NVARCHAR(4000) = NULL,
    @countryId INT = NULL

AS
-- body of the stored procedure
INSERT INTO dbo.[Author]
VALUES
    (dbo.FN_ProperCase(@fullName), @birthYear, @image, @countryId)
GO

DELETE FROM dbo.[Author]
GO

-- example to execute the stored procedure we just created
EXECUTE dbo.SP_InsertAuthor @fullName = N'ahmed arif', @birthYear= '1927', @image= N'author/ahmed_arif.jpg', @countryId = 228
GO
EXECUTE dbo.SP_InsertAuthor @fullName = N'michelle de montaigne', @birthYear= '1533', @image= N'author/montaigne.jpg', @countryId = 76
GO
EXECUTE dbo.SP_InsertAuthor @fullName = N'J. K. Rowling', @birthYear= '1965', @image= N'author/j_k_rowling.jpg'
GO
EXECUTE dbo.SP_InsertAuthor @fullName = N'Sabahattin Ali', @birthYear= '1907', @countryId = 228
GO

SELECT *
FROM dbo.[Author]
GO