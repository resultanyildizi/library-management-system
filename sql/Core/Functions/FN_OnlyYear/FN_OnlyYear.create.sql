-- Create a new function called 'FN_OnlyYear' in schema 'dbo'
-- Drop the function if it already exists
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'FN_OnlyYear'
)
DROP FUNCTION dbo.[FN_OnlyYear]
GO
-- Create the function in the specified schema
CREATE FUNCTION dbo.[FN_OnlyYear](@date DATE)
-- determine the return type
RETURNS NVARCHAR(4)
AS
-- body of the function
BEGIN
    DECLARE @result NVARCHAR(4)

    IF @date IS NOT NULL 
    BEGIN
        DECLARE @year INT
        SET @year = YEAR(@date)
        SET @result = CAST(@year AS NVARCHAR)
    END
    ELSE
        SET @result = N'????'

    RETURN @result
END
GO
-- example to execute the function we just created
SELECT dbo.[FN_OnlyYear](NULL)
GO
