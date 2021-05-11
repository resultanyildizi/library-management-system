-- Create a new stored procedure called 'SP_SelectAllStates' in schema 'dbo'
-- Drop the stored procedure if it already exists
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_SelectAllStates'
)
DROP PROCEDURE dbo.SP_SelectAllStates
GO
-- Create the stored procedure in the specified schema
CREATE PROCEDURE dbo.SP_SelectAllStates
AS
-- body of the stored procedure
SELECT [stateId], COALESCE([name], N'Not defined') AS [stateName]
FROM dbo.[State]
ORDER BY [stateName]
GO
-- example to execute the stored procedure we just created
EXECUTE dbo.SP_SelectAllStates 
GO