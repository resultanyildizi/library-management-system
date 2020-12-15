-- Create a new stored procedure called 'SP_SelectPublisherByName' in schema 'dbo'
-- Drop the stored procedure if it already exists
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_SelectPublisherByName'
)
DROP PROCEDURE dbo.SP_SelectPublisherByName
GO
-- Create the stored procedure in the specified schema
CREATE PROCEDURE dbo.SP_SelectPublisherByName
    @name NVARCHAR(70)
AS
-- body of the stored procedure
SELECT *
FROM dbo.[Publisher]
WHERE [name] LIKE  '%' + @name + '%'
ORDER BY [name] ASC
GO
-- example to execute the stored procedure we just created
EXECUTE dbo.SP_SelectPublisherByName @name = 'Yayın'
GO