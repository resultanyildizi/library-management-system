-- Create a new table called 'State' in schema 'dbo'
-- Drop the table if it already exists
IF OBJECT_ID('dbo.State', 'U') IS NOT NULL
DROP TABLE dbo.State
GO
-- Create the table in the specified schema
CREATE TABLE dbo.State
(
    [stateId] INT NOT NULL PRIMARY KEY IDENTITY(8000, 1),
    [name] [NVARCHAR](50) NOT NULL,
);
GO