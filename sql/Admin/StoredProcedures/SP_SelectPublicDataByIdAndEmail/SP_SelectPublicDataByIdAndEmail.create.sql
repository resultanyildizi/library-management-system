-- Create a new stored procedure called 'SP_SelectPublicDataByIdAndEmail' in schema 'dbo'
-- Drop the stored procedure if it already exists
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_SelectPublicDataByIdAndEmail'
)
DROP PROCEDURE dbo.[SP_SelectPublicDataByIdAndEmail]
GO
-- Create the stored procedure in the specified schema
CREATE PROCEDURE dbo.[SP_SelectPublicDataByIdAndEmail]
    @adminId INT,
    @email NVARCHAR(60)
AS
BEGIN
    SELECT COUNT([adminId]) AS [Admin Found]
    FROM [VW_SelectPublicData]
    WHERE [adminId] = @adminId
        AND [email] = @email
END
GO

EXEC SP_SelectPublicDataByIdAndEmail @adminId = 3001 , @email='admin@nrt.com'
