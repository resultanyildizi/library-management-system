--! This table references:
--!     BookInfo

-- Create a new table called 'Publisher' in schema 'dbo'
-- Drop the table if it already exists
IF OBJECT_ID('dbo.Publisher', 'U') IS NOT NULL
DROP TABLE dbo.Publisher
GO
-- Create the table in the specified schema
CREATE TABLE dbo.Publisher
(
    [publisherId] INT NOT NULL PRIMARY KEY IDENTITY(1000, 1),
    [name] NVARCHAR(70) NOT NULL CHECK(DATALENGTH([name]) > 0),
    [description] NVARCHAR(1000) NULL,
    [foundationYear] DATE NULL,
    [image] NVARCHAR(4000) NULL,
);
GO

CREATE INDEX [IX_Publisher_name] ON dbo.[Publisher]([name])
GO

sp_helpindex Publisher
