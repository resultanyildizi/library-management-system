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