--! This table references:
--!     BookInfo

-- Create a new table called 'Language' in schema 'dbo'
-- Drop the table if it already exists
IF OBJECT_ID('dbo.Language', 'U') IS NOT NULL
DROP TABLE dbo.Language
GO
-- Create the table in the specified schema
CREATE TABLE dbo.Language
(
    [languageId] INT NOT NULL PRIMARY KEY IDENTITY(6000, 1),
    -- primary key column
    [languageName] [NVARCHAR](50) NOT NULL UNIQUE
);
GO