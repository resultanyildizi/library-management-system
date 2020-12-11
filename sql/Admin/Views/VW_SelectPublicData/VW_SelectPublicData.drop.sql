-- Drop the view 'VW_SelectPublicData' in schema 'dbo'
IF EXISTS (
    SELECT *
FROM sys.views
    JOIN sys.schemas
    ON sys.views.schema_id = sys.schemas.schema_id
WHERE sys.schemas.name = N'dbo'
    AND sys.views.name = N'VW_SelectPublicData'
)
    DROP VIEW dbo.[VW_SelectPublicData]
GO