-- Drop the table 'BookInfo_Author' in schema 'db'
IF EXISTS (
    SELECT *
FROM sys.tables
    JOIN sys.schemas
    ON sys.tables.schema_id = sys.schemas.schema_id
WHERE sys.schemas.name = N'db'
    AND sys.tables.name = N'BookInfo_Author'
)
    DROP TABLE db.BookInfo_Author
GO