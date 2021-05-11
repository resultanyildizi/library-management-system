-- Create a new view called 'VW_BookInfo_Join_State' in schema 'dbo'
-- Drop the view if it already exists
IF EXISTS (
SELECT *
FROM sys.views
    JOIN sys.schemas
    ON sys.views.schema_id = sys.schemas.schema_id
WHERE sys.schemas.name = N'dbo'
    AND sys.views.name = N'VW_BookInfo_Join_State'
)
DROP VIEW dbo.VW_BookInfo_Join_State
GO
-- Create the view in the specified schema
CREATE VIEW dbo.VW_BookInfo_Join_State
AS
    -- body of the view
    SELECT BI.[bookInfoId],
        S.[stateId],
        COALESCE(S.[name], N'Not defined') AS [stateName]
    FROM dbo.[BookInfo] AS BI
        LEFT JOIN dbo.[State] AS S
        ON BI.[stateId] = S.[stateId]
GO