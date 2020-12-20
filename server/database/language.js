module.exports.register = async ({ sql, getConnection }) => {
  const selectAllLanguages = async () => {
    const connection = await getConnection();
    const request = connection.request();

    const result = await request.execute("SP_SelectAllLanguages");
    return result;
  };

  return {
    selectAllLanguages,
  };
};
