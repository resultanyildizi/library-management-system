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

  const updateBookInfo = async ({
    bookInfoId,
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

    request.input("bookInfoId", sql.INT, bookInfoId);
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

    const result = request.execute("SP_UpdateBookInfo");

    return result;
  };

  //* Updates translatorId and publisherId of bookInfo for given bookInfoId
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

    const result = await request.execute("SP_UpdateAndInsert");

    console.log(result);
    return result;
  };

  //* Updates categoryId of bookInfo for given bookInfoId
  const updateCategoryId = async ({ bookInfoId, categoryId }) => {
    try {
      const connection = await getConnection();
      const request = connection.request();
      request.input("bookInfoId", sql.INT, bookInfoId);
      request.input("categoryId", sql.INT, categoryId);

      const result = await request.execute("SP_UpdateCategoryId");
      return result;
    } catch (err) {
      console.log(err);
    }
  };

  const selectAllBookInfos = async ({ orderType }) => {
    try {
      const connection = await getConnection();
      const request = connection.request();

      request.input("orderType", sql.INT, orderType);

      const result = await request.execute("SP_SelectAllBookInfos");
      return result;
    } catch (err) {
      console.log(err);
    }
  };
  const deleteBookInfo = async ({ bookInfoId }) => {
    try {
      const connection = await getConnection();
      const request = connection.request();
      request.input("bookInfoId", sql.INT, bookInfoId);
      const result = await request.execute("SP_DeleteBookInfo");
      return result;
    } catch (err) {
      console.log(err);
    }
  };

  const updateBookInfoScore = async ({ bookInfoId, score }) => {
    try {
      const connection = await getConnection();
      const request = connection.request();
      request.input("bookInfoId", sql.INT, bookInfoId);
      request.input("score", sql.INT, score);
      const result = await request.execute("SP_UpdateBookInfoScore");
      return result;
    } catch (err) {
      console.log(err);
    }
  };

  return {
    insertBookInfo,
    updateAndInsert,
    updateCategoryId,
    selectAllBookInfos,
    updateBookInfo,
    deleteBookInfo,
    updateBookInfoScore,
  };
};
