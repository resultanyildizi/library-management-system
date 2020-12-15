-- Create a new function called 'FN_TrimWord' in schema 'dbo'
-- Drop the function if it already exists
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'FN_TrimWord'
)
DROP FUNCTION dbo.[FN_TrimWord]
GO
-- Create the function in the specified schema
CREATE FUNCTION dbo.[FN_TrimWord](@word NVARCHAR(4000))
-- determine the return type
RETURNS NVARCHAR(4000)
AS
-- trims a word and returns it
BEGIN
    SET @word = RTRIM(LTRIM(@word))
    RETURN @word
END
GO
-- example to execute the function we just created
SELECT dbo.[FN_TrimWord]('    This is a junky text.      ')
SELECT ('    This is a junky text.      ')
GO