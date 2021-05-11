-- Create a new stored procedure called 'SP_InsertBookMark' in schema 'dbo'
-- Drop the stored procedure if it already exists
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_InsertBookMark'
)
DROP PROCEDURE dbo.SP_InsertBookMark
GO
-- Create the stored procedure in the specified schema
CREATE PROCEDURE dbo.SP_InsertBookMark
    @bookInfoId INT,
    @note NVARCHAR(4000) = NULL,
    @page INT = NULL
AS
-- body of the stored procedure
INSERT INTO dbo.[BookMark]
    ([bookInfoId], [note], [page])
VALUES
    (@bookInfoId, @note, @page)
GO