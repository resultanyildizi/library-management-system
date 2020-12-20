-- Create a new view called 'VW_Authors' in schema 'dbo'
-- Drop the view if it already exists
IF EXISTS (
SELECT *
FROM sys.views
    JOIN sys.schemas
    ON sys.views.schema_id = sys.schemas.schema_id
WHERE sys.schemas.name = N'dbo'
    AND sys.views.name = N'VW_Authors'
)
DROP VIEW dbo.VW_Authors
GO
-- Create the view in the specified schema
CREATE VIEW dbo.VW_Authors
AS
    -- body of the view
    SELECT [authorId],
        [fullName],
        COALESCE(dbo.[FN_OnlyYear]([birthYear]), '???') AS [birthYear],
        COALESCE([image], N'author/default_profile.jpg') AS [image],
        [countryId]
    FROM dbo.[Author]
GO

SELECT *
FROM dbo.[VW_Authors]