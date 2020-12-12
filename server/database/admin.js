module.exports.register = async ({ sql, getConnection }) => {
  const insertAdmin = async ({ email, hashedPassword }) => {
    const connection = await getConnection();
    const request = connection.request();

    request.input("email", sql.NVARCHAR(60), email);
    request.input("hashedPassword", sql.NVARCHAR(100), hashedPassword);
    const result = request.execute("SP_InsertAdmin");
    return result;
  };

  const selectAdminByEmail = async ({ email }) => {
    const connection = await getConnection();
    const request = connection.request();

    request.input("email", sql.NVARCHAR(60), email);
    const result = await request.execute("SP_SelectAdminByEmail");
    return result;
  };

  const selectPublicDataByIdAndEmail = async ({ adminId, email }) => {
    const connection = await getConnection();
    const request = connection.request();

    request.input("adminId", sql.INT, adminId);
    request.input("email", sql.NVARCHAR(60), email);
    const result = await request.execute("SP_SelectPublicDataByIdAndEmail");
    return result;
  };

  return {
    insertAdmin,
    selectAdminByEmail,
    selectPublicDataByIdAndEmail,
  };
};
