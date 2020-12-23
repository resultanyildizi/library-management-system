module.exports.register = async ({ sql, getConnection }) => {
  const selectAllAuthors = async ({ orderType }) => {
    const connection = await getConnection();
    const request = connection.request();

    request.input("orderType", sql.INT, orderType);

    const result = await request.execute("SP_SelectAllAuthors");
    return result;
  };

  const insertAuthor = async ({ fullName, birthYear, image, countryId }) => {
    const connection = await getConnection();
    const request = connection.request();
    request.input("fullName", sql.NVARCHAR(100), fullName);
    request.input("birthYear", sql.DATE, birthYear);
    request.input("image", sql.NVARCHAR(4000), image);
    request.input("countryId", sql.INT, countryId);
    const result = await request.execute("SP_InsertAuthor");
    return result;
  };

  const selectAuthorByNameOrCountry = async ({ name }) => {
    const connection = await getConnection();
    const request = connection.request();
    request.input("name", sql.NVARCHAR(100), name);
    const result = await request.execute("SP_SelectAuthorByNameOrCountry");
    return result;
  };

  const selectAuthorById = async ({ id }) => {
    const connection = await getConnection();
    const request = connection.request();
    request.input("id", sql.INT, id);
    const result = await request.execute("SP_SelectAuthorById");
    return result;
  };

  const deleteAuthorById = async ({ id }) => {
    const connection = await getConnection();
    const request = connection.request();
    request.input("id", sql.INT, id);
    const result = await request.execute("SP_DeleteAuthorById");
    return result;
  };
  return {
    selectAllAuthors,
    selectAuthorByNameOrCountry,
    selectAuthorById,
    insertAuthor,
    deleteAuthorById,
  };
};
