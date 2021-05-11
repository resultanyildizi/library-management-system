module.exports.register = async ({ sql, getConnection }) => {
  const getBookMark = async ({ bookInfoId }) => {
    const connection = await getConnection();
    const request = connection.request();

    request.input("bookInfoId", sql.INT, bookInfoId);

    const result = await request.execute("SP_SelectBookMark");
    return result;
  };
  const insertBookMark = async ({ bookInfoId, note, page }) => {
    const connection = await getConnection();
    const request = connection.request();

    request.input("bookInfoId", sql.INT, bookInfoId);
    request.input("note", sql.NVARCHAR(4000), note);
    request.input("page", sql.INT, page);

    const result = await request.execute("SP_InsertBookMark");
    return result;
  };

  const deleteBookMark = async ({ bookMarkId }) => {
    const connection = await getConnection();
    const request = connection.request();

    request.input("bookMarkId", sql.INT, bookMarkId);

    const result = await request.execute("SP_DeleteBookMark");
    return result;
  };

  return { insertBookMark, getBookMark, deleteBookMark };
};
