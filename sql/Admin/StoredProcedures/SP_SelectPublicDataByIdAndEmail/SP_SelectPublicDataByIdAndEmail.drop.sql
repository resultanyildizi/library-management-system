-- Drop the stored procedure called 'SP_SelectPublicDataByIdAndEmail' in schema 'dbo'
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_SelectPublicDataByIdAndEmail'
)
DROP PROCEDURE dbo.[SP_SelectPublicDataByIdAndEmail]
GO