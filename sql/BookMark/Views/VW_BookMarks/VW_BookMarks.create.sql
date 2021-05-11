-- Create a new view called 'VW_BookMarks' in schema 'dbo'
-- Drop the view if it already exists
IF EXISTS (
SELECT *
FROM sys.views
    JOIN sys.schemas
    ON sys.views.schema_id = sys.schemas.schema_id
WHERE sys.schemas.name = N'dbo'
    AND sys.views.name = N'VW_BookMarks'
)
DROP VIEW dbo.VW_BookMarks
GO
-- Create the view in the specified schema
CREATE VIEW dbo.VW_BookMarks
AS
    SELECT
        [bookMarkId],
        [bookInfoId],
        COALESCE([note], N'...') AS [note],
        COALESCE([page], N'Not defined') AS [page],
        FORMAT([createdAt], 'dd-MM-yy') AS [createdAt]
    FROM dbo.[BookMark]
GO