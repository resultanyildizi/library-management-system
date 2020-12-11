-- Create a new view called 'VW_SelectPublicData' in schema 'dbo'
-- Drop the view if it already exists
IF EXISTS (
SELECT *
FROM sys.views
    JOIN sys.schemas
    ON sys.views.schema_id = sys.schemas.schema_id
WHERE sys.schemas.name = N'dbo'
    AND sys.views.name = N'VW_SelectPublicData'
)
DROP VIEW dbo.VW_SelectPublicData
GO
-- Create the view in the specified schema
CREATE VIEW dbo.[VW_SelectPublicData]
AS
    -- body of the view
    SELECT
        [adminId],
        [email]
    FROM dbo.[Admin]
GO
-- example to select the view we just created
SELECT *
FROM dbo.[VW_SelectPublicData]