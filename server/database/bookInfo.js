module.exports.register = async ({ sql, getConnection }) => {
  const insertBookInfo = async ({
    languageId,
    pageCount,
    image,
    publishYear,
    description,
    edition,
    width,
    height,
    name,
  }) => {
    const connection = await getConnection();
    const request = connection.request();

    request.input("languageId", sql.INT, languageId);
    request.input("pageCount", sql.INT, pageCount);
    request.input("image", sql.NVARCHAR(4000), image);
    request.input("publishYear", sql.DATE, publishYear);
    request.input("description", sql.NVARCHAR(1000), description);
    request.input("edition", sql.INT, edition);
    request.input("width", sql.FLOAT, width);
    request.input("height", sql.FLOAT, height);
    request.input("name", sql.NVARCHAR(200), name);
    request.output("bookId");

    const result = request.execute("SP_InsertBookInfo");

    return result;
  };

  //* Updates translatorId and publisherId of book for given bookInfoId
  //* and inserts records for all author ids in authorIdList to BookInfo_Author table
  const updateAndInsert = async ({
    bookInfoId,
    translatorId,
    publisherId,
    authorIdList,
  }) => {
    const connection = await getConnection();
    const request = connection.request();
    request.input("bookInfoId", sql.INT, bookInfoId);
    request.input("translatorId", sql.INT, translatorId);
    request.input("publisherId", sql.INT, publisherId);
    request.input("authorIdList", sql.NVARCHAR(sql.MAX), authorIdList);

    const result = request.execute("SP_UpdateAndInsert");
    return result;
  };

  return {
    insertBookInfo,
    updateAndInsert,
  };
};
