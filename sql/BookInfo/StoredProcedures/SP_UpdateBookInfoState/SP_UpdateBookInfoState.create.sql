-- Create a new stored procedure called 'SP_UpdateBookInfoState' in schema 'dbo'
-- Drop the stored procedure if it already exists
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_UpdateBookInfoState'
)
DROP PROCEDURE dbo.SP_UpdateBookInfoState
GO
-- Create the stored procedure in the specified schema
CREATE PROCEDURE dbo.SP_UpdateBookInfoState
    @bookInfoId INT,
    @stateId INT = NULL
-- add more stored procedure parameters here
AS
UPDATE dbo.[BookInfo] SET [stateId] = @stateId WHERE [bookInfoId] = @bookInfoId
GO