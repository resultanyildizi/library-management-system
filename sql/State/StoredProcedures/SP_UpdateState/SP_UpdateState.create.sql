-- Create a new stored procedure called 'SP_UpdateState' in schema 'dbo'
-- Drop the stored procedure if it already exists
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_UpdateState'
)
DROP PROCEDURE dbo.SP_UpdateState
GO
-- Create the stored procedure in the specified schema
CREATE PROCEDURE dbo.SP_UpdateState
    @stateId INT,
    @name NVARCHAR(50)
-- add more stored procedure parameters here
AS
UPDATE dbo.[State] SET [name] = dbo.[FN_ProperCase](@name) WHERE [stateId] = @stateId
GO