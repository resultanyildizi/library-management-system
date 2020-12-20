module.exports.register = async ({ sql, getConnection }) => {
  const selectAllCountries = async () => {
    const connection = await getConnection();
    const request = connection.request();

    const result = await request.execute("SP_SelectAllCountries");
    return result;
  };

  return {
    selectAllCountries,
  };
};
