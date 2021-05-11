module.exports.register = async ({ sql, getConnection }) => {
  const insertState = async ({ name }) => {
    const connection = await getConnection();
    const request = connection.request();

    request.input("name", sql.NVARCHAR(50), name);
    const result = request.execute("SP_InsertState");
    return result;
  };

  const selectAllStates = async () => {
    const connection = await getConnection();
    const request = connection.request();

    const result = await request.execute("SP_SelectAllStates");
    return result;
  };

  const deleteState = async ({ stateId }) => {
    const connection = await getConnection();
    const request = connection.request();

    request.input("stateId", sql.INT, stateId);
    const result = await request.execute("SP_DeleteState");
    return result;
  };

  const updateState = async ({ stateId, name }) => {
    const connection = await getConnection();
    const request = connection.request();

    request.input("stateId", sql.INT, stateId);
    request.input("name", sql.NVARCHAR(50), name);
    const result = await request.execute("SP_UpdateState");
    return result;
  };

  return {
    insertState,
    selectAllStates,
    deleteState,
    updateState,
  };
};
