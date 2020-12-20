-- Create a new stored procedure called 'SP_InsertPublisher' in schema 'dbo'
-- Drop the stored procedure if it already exists
IF EXISTS (
SELECT *
FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'SP_InsertPublisher'
)
DROP PROCEDURE dbo.SP_InsertPublisher
GO
-- Create the stored procedure in the specified schema
CREATE PROCEDURE dbo.SP_InsertPublisher
    @name NVARCHAR(70),
    @description NVARCHAR(1000) = NULL,
    @foundationYear DATE = NULL,
    @image NVARCHAR(4000) = NULL
AS
-- body of the stored procedure
INSERT INTO dbo.[Publisher]
VALUES
    (dbo.[FN_ProperCase](@name), @description, @foundationYear, @image)
GO
-- example to execute the stored procedure we just created
DELETE FROM dbo.[Publisher]
GO
EXECUTE dbo.SP_InsertPublisher
    @name = N'Türkiye iş bankası yayınları', 
    @description = 'Türkiye İş Bankası Kültür Yayınları, 1956 yılında Hasan Âli Yücel tarafından kuruldu. Hasan Âli Yücel, Milli Eğitim Bakanlığı döneminde başlattığı “dünya klasikleri”nin dilimize kazandırılması ve yaygın olarak okunması çalışmasından aldığı hız ve birikimiyle, Türkiye İş Bankası’ndan aldığı gücü birleştirerek, ülkemizin önemli ve köklü yayınevlerinden birini kurmuş oluyordu.', 
    @foundationYear = '1956', 
    @image = 'publisher/turkiye_is_bankasi_yayinlari.jpg'
GO
EXECUTE dbo.SP_InsertPublisher
@name = N'   iz yayıncIlık', 
@description = N'Türkiye’de entelektüel yayıncılığın önemli kilometre taşlarından biri olan İz Yayıncılık, 1990 senesinde kuruldu. Gerek kitap seçimleri, gerek yaptığı seçimlerin neşrinde gösterdiği titizlik ile en başından itibaren kitap okurunun dikkatini çeken yayınevimiz, başlangıç döneminde yoğun bir şekilde ihmal edilmiş "gelenek"e yönelerek, tek parti dönemi ve darbelerle baskılanmış bir kültürel geçmişi Türk okurlarıyla buluşturmaya başladı. Bu misyonunu önemli ölçüde yerine getirirken, doldurulan boşlukları tamamlayıcı nitelikte çağdaş literatür üzerinde de yoğunlaşan yayınevimiz, kısa sürede haklı bir saygınlığa ulaştı. Ülkemizin önemli kimi entelektüel simalarının toplu eserleri, kültürel birikimimize katkı yapan inceleme-araştırma kitapları, edebiyatımızda kilometre taşı olmuş ustalar, yabancı literatür süreç içerisinde okurlarla buluştu.', 
@foundationYear = '1990', 
@image = 'publisher/iz_yayincilik.jpg'
GO
EXECUTE dbo.SP_InsertPublisher 
@name =N'Can Yayınları',
@description= N'1981’de, Türkiye’nin önde gelen yazarlarından biri olan Erdal Öz tarafından kuruldu ve kısa sürede Türkiye’nin en saygın yayınevlerinden biri haline geldi. Yıllar içinde dünyanın en önemli yazarları, CAN aracılığıyla Türk okuruna ulaştı; Türk edebiyatının en önde gelen, en yetenekli, en heyecan verici kalemleri CAN çatısı altında yer aldı. 21. yüzyılda da CAN klasik, modern ve çağdaş edebiyatta öncü yayınevleri arasındaki konumunu koruyor.', 
@foundationYear = '1981',
@image = N'publisher/can_yayinlari.jpg'
GO
EXECUTE dbo.SP_InsertPublisher 
@name = N'Pegasus Yayınları', 
@description = N'Çiğnenmesi ve sindirilmesi gereken kitapların adresi Pegasus Yayınları 1 Ocak 2006 yılında yayın hayatına başladı. İlk yılımızda daha çok araştırma kitaplarına yönelmemize rağmen son yıllarda okurların yakından takip ettiği seri kitaplarımızla birlikte çok satanlar listesinde her zaman yer edinen romanlarımızla tanınıyoruz.', 
@foundationYear ='2006', 
@image = N'publisher/pegasus_yayinlari.jpg'
GO

SELECT *
FROM dbo.[Publisher]
