-- Create a new stored procedure called 'SP_DeleteState' in schema 'dbo'
-- Drop the stored procedure if it already exists
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_DeleteState'
)
DROP PROCEDURE dbo.SP_DeleteState
GO
-- Create the stored procedure in the specified schema
CREATE PROCEDURE dbo.SP_DeleteState
    @stateId INT
AS
-- body of the stored procedure
DELETE FROM dbo.[State] WHERE [stateId] = @stateId
GO
-- example to execute the stored procedure we just created
EXECUTE dbo.SP_DeleteState 8000
GO

SELECT *
FROM [State]