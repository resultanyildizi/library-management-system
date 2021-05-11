--! This table depends on:
--!     BookInfo

-- Create a new table called 'BookMark' in schema 'dbo'
-- Drop the table if it already exists
IF OBJECT_ID('dbo.BookMark', 'U') IS NOT NULL
DROP TABLE dbo.BookMark
GO
-- Create the table in the specified schema
CREATE TABLE dbo.BookMark
(
    -- primary key column
    [bookMarkId] INT NOT NULL PRIMARY KEY IDENTITY(7000, 1),
    [bookInfoId] INT NOT NULL FOREIGN KEY REFERENCES dbo.[BookInfo]([bookInfoId]),
    [createdAt] DATE DEFAULT(GETDATE()),
    [note] NVARCHAR(4000) NULL,
    [page] INT NULL
);
GO

CREATE INDEX IX_BookMark_CreatedAt ON dbo.[BookMark]([createdAt])

SELECT *
FROM [BookMark]