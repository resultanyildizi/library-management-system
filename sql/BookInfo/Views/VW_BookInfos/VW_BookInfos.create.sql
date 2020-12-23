-- Create a new view called 'VW_BookInfos' in schema 'dbo'
-- Drop the view if it already exists
IF EXISTS (
SELECT *
FROM sys.views
    JOIN sys.schemas
    ON sys.views.schema_id = sys.schemas.schema_id
WHERE sys.schemas.name = N'dbo'
    AND sys.views.name = N'VW_BookInfos'
)
DROP VIEW dbo.VW_BookInfos
GO
-- Create the view in the specified schema
CREATE VIEW dbo.VW_BookInfos
AS
    -- body of the view
    SELECT *,
        COALESCE(CAST([pageCount] AS NVARCHAR), N'???') AS [vpageCount],
        COALESCE(CAST([edition] AS NVARCHAR), N'Not defined') AS [vedition],
        COALESCE ([image], N'book/default_book_cover.jpg') AS [vimage],
        COALESCE(dbo.FN_OnlyYear([publishYear]), N'????') AS [vpublishYear],
        COALESCE([description], [name]) AS [vdescription],
        CONCAT(
               COALESCE(CAST([width] AS NVARCHAR), '?'), 
                   N' x ', 
               COALESCE(CAST([height] AS NVARCHAR), '?')) 
               AS [dimensions]
    FROM dbo.[BookInfo]
GO

SELECT [score]
FROM dbo.[VW_BookInfos]