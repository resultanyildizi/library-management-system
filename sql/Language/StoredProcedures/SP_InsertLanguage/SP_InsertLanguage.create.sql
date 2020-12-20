-- Create a new stored procedure called 'SP_InsertLanguage' in schema 'dbo'
-- Drop the stored procedure if it already exists
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_InsertLanguage'
)
DROP PROCEDURE dbo.SP_InsertLanguage
GO
-- Create the stored procedure in the specified schema
CREATE PROCEDURE dbo.SP_InsertLanguage
    @languageName NVARCHAR(50)
AS
-- body of the stored procedure
INSERT INTO dbo.[Language]
VALUES
    (dbo.[FN_ProperCase](@languageName))
GO

DELETE FROM dbo.[Language]
DBCC CHECKIDENT ('Language', RESEED, 6000)

EXECUTE dbo.SP_InsertLanguage @languageName = N'   turkish' 
GO
EXECUTE dbo.SP_InsertLanguage @languageName = N'English' 
GO
EXECUTE dbo.SP_InsertLanguage @languageName = N' french' 
GO
EXECUTE dbo.SP_InsertLanguage @languageName = N'Spanİsh' 
GO
EXECUTE dbo.SP_InsertLanguage @languageName = N'German' 
GO
SELECT *
FROM dbo.[Language]