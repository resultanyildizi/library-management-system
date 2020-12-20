module.exports.register = async ({ sql, getConnection }) => {
  const selectCategoryByParentId = async (parentId) => {
    const connection = await getConnection();
    const request = connection.request();
    request.input("parentId", sql.INT, parentId);
    const result = await request.execute("SP_SelectCategoryByParentId");
    return result;
  };
  const insertCategory = async ({ parentId, name }) => {
    const connection = await getConnection();
    const request = connection.request();
    request.input("parentId", sql.INT, parentId);
    request.input("name", sql.NVARCHAR(50), name);
    const result = await request.execute("SP_InsertCategory");
    return result;
  };
  const deleteCategory = async ({ categoryId }) => {
    const connection = await getConnection();
    const request = connection.request();
    request.input("categoryId", sql.INT, categoryId);
    const result = await request.execute("SP_DeleteCategoryById");
    return result;
  };

  return {
    insertCategory,
    selectCategoryByParentId,
    deleteCategory,
  };
};
