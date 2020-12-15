module.exports.register = async ({ sql, getConnection }) => {
  const insertPublisher = async ({
    name,
    description,
    foundationYear,
    image,
  }) => {
    const connection = await getConnection();
    const request = connection.request();

    request.input("name", sql.NVARCHAR(70), name);
    request.input("description", sql.NVARCHAR(1000), description);
    request.input("foundationYear", sql.DATE, foundationYear);
    request.input("image", sql.NVARCHAR(4000), image);
    const result = request.execute("SP_InsertPublisher");
    return result;
  };

  const selectAllPublishers = async () => {
    const connection = await getConnection();
    const request = connection.request();

    const result = await request.execute("SP_SelectAllPublishers");
    return result;
  };

  const selectPublisherByName = async ({ name }) => {
    const connection = await getConnection();
    const request = connection.request();

    request.input("name", sql.NVARCHAR(70), name);
    const result = await request.execute("SP_SelectPublisherByName");
    return result;
  };

  const selectPublisherById = async ({ id }) => {
    const connection = await getConnection();
    const request = connection.request();

    request.input("id", sql.NVARCHAR(70), id);
    const result = await request.execute("SP_SelectPublisherById");
    return result;
  };

  const deletePublisherById = async ({ id }) => {
    const connection = await getConnection();
    const request = connection.request();

    request.input("id", sql.NVARCHAR(70), id);
    const result = await request.execute("SP_DeletePublisherById");
    return result;
  };

  return {
    insertPublisher,
    selectAllPublishers,
    selectPublisherByName,
    selectPublisherById,
    deletePublisherById,
  };
};
