-- Create a new table called 'Admin' in schema 'dbo'
-- Drop the table if it already exists
IF OBJECT_ID('dbo.Admin', 'U') IS NOT NULL
DROP TABLE dbo.[Admin]
GO
-- Create the table in the specified schema
CREATE TABLE dbo.[Admin]
(
    [adminId] INT NOT NULL PRIMARY KEY IDENTITY(3000, 1),
    -- primary key column
    [email] NVARCHAR(60) NOT NULL UNIQUE ,
    [hashedPassword] NVARCHAR (100) NOT NULL
);
GO


ALTER TABLE dbo.[Admin]
ADD CONSTRAINT [CK__Admin__Email__78509AD9]
CHECK(DATALENGTH([email]) > 0)

ALTER TABLE dbo.[Admin]
ADD CONSTRAINT [CK__Admin__HashPwd__78509AD9]
CHECK(DATALENGTH([hashedPassword]) > 0)
