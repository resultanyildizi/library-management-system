--! This table references:
--!     BookInfo_Category

-- Create a new table called 'Category' in schema 'dbo'
-- Drop the table if it already exists
IF OBJECT_ID('dbo.BookInfo_Category', 'U') IS NOT NULL
DROP TABLE dbo.BookInfo_Category
IF OBJECT_ID('dbo.Category', 'U') IS NOT NULL
DROP TABLE dbo.Category
GO
-- Create the table in the specified schema
CREATE TABLE dbo.Category
(
    -- primary key column
    [categoryId] INT NOT NULL PRIMARY KEY IDENTITY(4000, 1),
    [parentId] INT NULL,
    [name] [NVARCHAR](50) NOT NULL,
);
GO


SELECT *
FROM dbo.[Category]