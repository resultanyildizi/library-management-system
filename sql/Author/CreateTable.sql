--! This table depends on:
--!     Country

--! This table is referenced by:
--!     BookInfo
--!     BookInfo_Author

-- Create a new table called 'Author' in schema 'dbo'
-- Drop the table if it already exists
IF OBJECT_ID('dbo.Author', 'U') IS NOT NULL
DROP TABLE dbo.Author
GO
-- Create the table in the specified schema
CREATE TABLE dbo.Author
(
    -- primary key column
    [authorId] INT NOT NULL PRIMARY KEY IDENTITY(2000, 1),
    [fullName] NVARCHAR(100) NOT NULL,
    [birthYear] DATE NULL,
    [image] NVARCHAR(4000) NULL,
    [countryId] INT FOREIGN KEY REFERENCES dbo.[Country]([countryId]) NULL
);
GO

CREATE INDEX IX_Author_fullName ON dbo.[Author](fullName)

SELECT *
FROM dbo.[Author]