-- Create a new stored procedure called 'SP_InsertState' in schema 'dbo'
-- Drop the stored procedure if it already exists
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_InsertState'
)
DROP PROCEDURE dbo.SP_InsertState
GO
CREATE PROCEDURE dbo.SP_InsertState
    @name NVARCHAR(50)
AS
INSERT INTO dbo.[State]
VALUES
    (dbo.[FN_ProperCase](@name))
GO
-- example to execute the stored procedure we just created
EXECUTE dbo.SP_InsertState N'reading'   
GO
EXECUTE dbo.SP_InsertState N'read'
GO
EXECUTE dbo.SP_InsertState N'want to buy'
GO
EXECUTE dbo.SP_InsertState N'lended'
GO

SELECT *
FROM dbo.[State]