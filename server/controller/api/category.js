const Boom = require("@hapi/boom");
const assert = require("assert");
const Joi = require("joi");

module.exports.register = (server) => {
  const createCategories = async (categories, parent) => {
    const db = server.plugins.sql.client;
    const result = await db.category.selectCategoryByParentId(
      !parent ? null : parent.categoryId
    );
    if (parent) parent.children = [];
    if (result && result.recordset && result.recordset.length > 0) {
      for (let i = 0; i < result.recordset.length; i++) {
        const record = result.recordset[i];
        if (!parent) {
          categories.push(record);
        } else {
          parent.children.push(record);
        }
        await createCategories(categories, record);
      }
    }
    return categories;
  };

  const schema = {
    payload: Joi.object({
      parentId: Joi.number().integer().optional().allow(null),
      name: Joi.string().min(1).max(50).required(),
    }),
    params: Joi.object({
      categoryId: Joi.number().integer().min(1).required(),
    }),
  };

  const handlers = {
    getAllCategories: async (req, h) => {
      try {
        var categories = [];
        var newCategories = null;
        newCategories = await createCategories(categories, null);

        assert(newCategories);

        if (newCategories) return newCategories;
        else return Boom.internal();
      } catch (err) {
        console.error(err);
        return Boom.internal(err);
      }
    },

    insertCategory: async (req, h) => {
      try {
        const { parentId, name } = req.payload;
        const db = server.plugins.sql.client;
        const result = await db.category.insertCategory({ parentId, name });

        assert(result);

        if (result && result.rowsAffected && result.rowsAffected[0] === 1) {
          return h.response().code(201);
        }
        return Boom.internal();
      } catch (err) {
        console.error(err);
        return Boom.internal(err);
      }
    },

    deleteCategory: async (req, h) => {
      try {
        const { categoryId } = req.params;
        const db = server.plugins.sql.client;
        const result = await db.category.deleteCategory({ categoryId });

        assert(result);

        if (result && result.rowsAffected && result.rowsAffected[0] === 1) {
          return h.response().code(204);
        }
        return Boom.internal();
      } catch (err) {
        console.error(err);
        return Boom.internal(err);
      }
    },
  };

  return {
    handlers,
    schema,
  };
};
