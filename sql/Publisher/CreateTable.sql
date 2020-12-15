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
    [foundationYear] DATE NOT NULL,
    [image] NVARCHAR(4000) NULL,
);
GO

CREATE INDEX [IX_Publisher_name] ON dbo.[Publisher]([name])
GO

sp_helpindex Publisher

INSERT INTO dbo.[Publisher]
VALUES
    (N'Can Yayınları', N'1981’de, Türkiye’nin önde gelen yazarlarından biri olan Erdal Öz tarafından kuruldu ve kısa sürede Türkiye’nin en saygın yayınevlerinden biri haline geldi. Yıllar içinde dünyanın en önemli yazarları, CAN aracılığıyla Türk okuruna ulaştı; Türk edebiyatının en önde gelen, en yetenekli, en heyecan verici kalemleri CAN çatısı altında yer aldı. 21. yüzyılda da CAN klasik, modern ve çağdaş edebiyatta öncü yayınevleri arasındaki konumunu koruyor.', '1981', N'publisher/can_yayinlari.jpg'),

    (N'Pegasus Yayınları', N'Çiğnenmesi ve sindirilmesi gereken kitapların adresi Pegasus Yayınları 1 Ocak 2006 yılında yayın hayatına başladı. İlk yılımızda daha çok araştırma kitaplarına yönelmemize rağmen son yıllarda okurların yakından takip ettiği seri kitaplarımızla birlikte çok satanlar listesinde her zaman yer edinen romanlarımızla tanınıyoruz.', '2006', 'publisher/pegasus_yayinlari.jpg')
    

SELECT *
FROM [Publisher]