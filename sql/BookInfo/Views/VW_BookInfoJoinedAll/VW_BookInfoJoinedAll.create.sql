-- Create a new view called 'VW_BookInfoJoinedAll' in schema 'dbo'
-- Drop the view if it already exists
IF EXISTS (
SELECT *
FROM sys.views
    JOIN sys.schemas
    ON sys.views.schema_id = sys.schemas.schema_id
WHERE sys.schemas.name = N'dbo'
    AND sys.views.name = N'VW_BookInfoJoinedAll'
)
DROP VIEW dbo.VW_BookInfoJoinedAll
GO
-- Create the view in the specified schema
CREATE VIEW dbo.VW_BookInfoJoinedAll
AS
    -- body of the view
    SELECT BI.*,
        [translatorName],
        [authorNames],
        [authorIds],
        [publisherName],
        [categoryName],
        [languageName],
        [stateName]
    FROM [VW_BookInfos] AS BI
        LEFT JOIN [VW_BookInfo_Join_Publisher] AS BI_J_P
        ON BI.[bookInfoId] = BI_J_P.[bookInfoId]
        LEFT JOIN [VW_BookInfo_Join_Translator] AS BI_J_T
        ON BI.[bookInfoId] = BI_J_T.[bookInfoId]
        LEFT JOIN [VW_BookInfo_Join_Category] AS BI_J_C
        ON BI.[bookInfoId] = BI_J_C.[bookInfoId]
        LEFT JOIN [VW_BookInfo_Join_BookInfo_Author] AS BI_J_BI_A
        ON BI.[bookInfoId] = BI_J_BI_A.[bookInfoId]
        LEFT JOIN [VW_BookInfo_Join_Language] AS BI_J_L
        ON BI.[bookInfoId] = BI_J_L.[bookInfoId]
        LEFT JOIN [VW_BookInfo_Join_State] AS BI_J_S
        ON BI.[bookInfoId] = BI_J_S.[bookInfoId]
GO