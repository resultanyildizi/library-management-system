-- Create a new view called 'VW_PublishersJoinedAll' in schema 'dbo'
-- Drop the view if it already exists
IF EXISTS (
SELECT *
FROM sys.views
    JOIN sys.schemas
    ON sys.views.schema_id = sys.schemas.schema_id
WHERE sys.schemas.name = N'dbo'
    AND sys.views.name = N'VW_PublishersJoinedAll'
)
DROP VIEW dbo.VW_PublishersJoinedAll
GO
-- Create the view in the specified schema
CREATE VIEW dbo.VW_PublishersJoinedAll
AS
    SELECT P.*, BI.[bookCount]
    FROM dbo.[VW_Publishers] AS P
        JOIN dbo.[VW_Publisher_Join_BookInfo] AS BI
        ON P.[publisherId] = BI.[publisherId]
GO