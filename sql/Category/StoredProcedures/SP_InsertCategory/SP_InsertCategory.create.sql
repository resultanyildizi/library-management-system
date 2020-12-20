-- Create a new stored procedure called 'SP_InsertCategory' in schema 'dbo'
-- Drop the stored procedure if it already exists
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_InsertCategory'
)
DROP PROCEDURE dbo.SP_InsertCategory
GO
-- Create the stored procedure in the specified schema
CREATE PROCEDURE dbo.SP_InsertCategory
    @name NVARCHAR(50),
    @parentId INT = NULL
AS
-- body of the stored procedure
INSERT INTO dbo.[Category]
    ([name], [parentId])
VALUES
    (dbo.FN_ProperCase(@name), @parentId)
GO
DELETE FROM dbo.[Category]
DBCC CHECKIDENT ('Category', RESEED, 4000)
-- example to execute the stored procedure we just created
EXECUTE dbo.SP_InsertCategory @name="Felsefe" 
GO
EXECUTE dbo.SP_InsertCategory 
@name="Felsefe Bilimi",
@parentId = 4001
GO
EXECUTE dbo.SP_InsertCategory @name="Edebiyat" 
GO
EXECUTE dbo.SP_InsertCategory 
@name="Roman",
@parentId = 4003
GO
EXECUTE dbo.SP_InsertCategory 
@name="Türkiye Roman",
@parentId = 4004
GO
EXECUTE dbo.SP_InsertCategory 
@name="Dünya Roman",
@parentId = 4004
GO

SELECT *
FROM dbo.[Category]


