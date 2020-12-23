-- Create a new view called 'VW_Publishers' in schema 'dbo'
-- Drop the view if it already exists
IF EXISTS (
SELECT *
FROM sys.views
    JOIN sys.schemas
    ON sys.views.schema_id = sys.schemas.schema_id
WHERE sys.schemas.name = N'dbo'
    AND sys.views.name = N'VW_Publishers'
)
DROP VIEW dbo.VW_Publishers
GO
-- Create the view in the specified schema
CREATE VIEW dbo.VW_Publishers
AS
    SELECT
        [publisherId],
        [name],
        COALESCE([description], [name]) AS [description],
        dbo.[FN_OnlyYear]([foundationYear]) AS [foundationYear],
        COALESCE([image], N'publisher/default_publisher.jpg') AS [image]
    FROM dbo.[Publisher]
GO

SELECT *
FROM dbo.[VW_Publishers]