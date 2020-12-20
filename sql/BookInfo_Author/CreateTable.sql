--! This table depends on:
--!     Author
--!     BookInfo

-- Create a new table called 'Book_Author' in schema 'dbo'
-- Drop the table if it already exists
IF OBJECT_ID('dbo.BookInfo_Author', 'U') IS NOT NULL
DROP TABLE dbo.BookInfo_Author
GO
-- Create the table in the specified schema
CREATE TABLE dbo.BookInfo_Author
(
    [bookInfoId] INT NOT NULL FOREIGN KEY REFERENCES dbo.BookInfo([bookInfoId]) ON DELETE CASCADE,
    [authorId] INT NOT NULL FOREIGN KEY REFERENCES dbo.Author([authorId]) ON DELETE CASCADE,
);
GO

CREATE UNIQUE CLUSTERED INDEX [UQ_BookInfo_Author_Keys] ON dbo.[BookInfo_Author]
([bookInfoId], [authorId])


SELECT *
FROM [BookInfo_Author]

