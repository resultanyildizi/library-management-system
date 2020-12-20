-- Drop the view 'VW_JoinCountry' in schema 'dbo'
IF EXISTS (
    SELECT *
FROM sys.views
    JOIN sys.schemas
    ON sys.views.schema_id = sys.schemas.schema_id
WHERE sys.schemas.name = N'dbo'
    AND sys.views.name = N'VW_JoinCountry'
)
    DROP VIEW dbo.VW_JoinCountry
GO
