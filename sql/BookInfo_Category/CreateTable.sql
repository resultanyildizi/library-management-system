--! This table depends on:
--!     Category
--!     BookInfo

-- Create a new table called 'Book_Author' in schema 'dbo'
-- Drop the table if it already exists
IF OBJECT_ID('dbo.BookInfo_Category', 'U') IS NOT NULL
DROP TABLE dbo.BookInfo_Category
GO
-- Create the table in the specified schema
CREATE TABLE dbo.BookInfo_Category
(
    [bookInfoId] INT NOT NULL FOREIGN KEY REFERENCES dbo.BookInfo([bookInfoId]) ON DELETE CASCADE,
    [categoryId] INT NOT NULL FOREIGN KEY REFERENCES dbo.Category([categoryId]) ON DELETE CASCADE,
);
GO

CREATE CLUSTERED INDEX [UQ_BookInfo_Category_Keys] ON dbo.[BookInfo_Category]([bookInfoId], [categoryId])


SELECT *
FROM [BookInfo_Category]