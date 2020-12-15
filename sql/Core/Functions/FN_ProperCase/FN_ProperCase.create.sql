-- Create a new function called 'FN_ProperCase' in schema 'dbo'
-- Drop the function if it already exists
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'FN_ProperCase'
)
DROP FUNCTION dbo.[FN_ProperCase]
GO
-- Create the function in the specified schema
CREATE FUNCTION dbo.[FN_ProperCase](@word NVARCHAR(4000))
-- determine the return type
RETURNS NVARCHAR(4000)
AS
-- converts the word to the proper case
BEGIN
    DECLARE @output NVARCHAR(4000)
    -- output string
    DECLARE @letter NVARCHAR(1)
    -- current letter
    DECLARE @len INT
    -- length of the word
    DECLARE @index INT
    -- current index
    DECLARE @split NVARCHAR(10)
    -- split characters
    DECLARE @flag INT


    SET @word = dbo.[FN_TrimWord](@word)
    SET @output = N''
    SET @index = 1
    SET @len = LEN(@word)
    SET @split = '[' + CHAR(13) + CHAR(10) + CHAR(9) + CHAR(160) + ' ' + ']'
    SET @flag = 1

    WHILE(@index <= @len)
    BEGIN
        SET @letter = SUBSTRING(@word, @index, 1)
        IF(@flag = 1)
        BEGIN
            SET @letter = UPPER(@letter)
            SET @flag = 0
        END
        ELSE
        BEGIN
            SET @letter =  LOWER(@letter)
        END
        SET @output = @output + @letter


        IF(@letter LIKE @split)
        SET @flag = 1

        SET @index = @index + 1
    END

    RETURN @output
END
GO
-- example to execute the function we just created
SELECT dbo.[FN_ProperCase]('  nuRettin RESUL TaNyIlDıZI   ') AS [Proper Case]
GO

