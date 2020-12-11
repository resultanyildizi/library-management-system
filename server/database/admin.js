module.exports.register = async ({ sql, getConnection }) => {
  const insertAdmin = async ({ email, hashedPassword }) => {
    const connection = await getConnection();
    const request = connection.request();

    request.input("email", sql.NVARCHAR(60), email);
    request.input("hashedPassword", sql.NVARCHAR(100), hashedPassword);
    const result = request.execute("SP_InsertAdmin");
    return result;
  };

  return {
    insertAdmin,
  };
};
