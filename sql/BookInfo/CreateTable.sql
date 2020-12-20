--! This table depends on:
--!     Author
--!     Publisher
--!     Language

--! This table references:
--!     BookInfo_Author
--!     BookInfo_Category

-- Create a new table called 'BookInfo' in schema 'dbo'
-- Drop the table if it already exists
IF OBJECT_ID('dbo.BookInfo', 'U') IS NOT NULL
DROP TABLE dbo.BookInfo
GO
-- Create the table in the specified schema
CREATE TABLE dbo.BookInfo
(
    -- primary key column
    [bookInfoId] INT NOT NULL PRIMARY KEY IDENTITY(9000,1),
    [translatorId] INT NULL FOREIGN KEY REFERENCES dbo.[Author]([authorId]) ON DELETE SET NULL,
    [publisherId] INT NULL FOREIGN KEY REFERENCES dbo.[Publisher]([publisherId]) ON DELETE SET NULL,
    [languageId] INT NULL FOREIGN KEY REFERENCES dbo.[Language]([languageId]) ON DELETE SET NULL,
    [pageCount] INT NULL CHECK ([pageCount] > 5),
    [image] NVARCHAR (4000) NULL,
    [publishYear] DATE NULL,
    [description] NVARCHAR(1000) NULL,
    [edition] INT NULL CHECK([edition] > 0),
    [width] FLOAT NULL CHECK ([width] > 5),
    [height] FLOAT NULL CHECK ([height] > 5),
    [name] NVARCHAR(200) NOT NULL

);
GO

CREATE INDEX [IX_BookInfo_Name] ON dbo.[BookInfo]([name])

SELECT *
FROM dbo.[BookInfo]