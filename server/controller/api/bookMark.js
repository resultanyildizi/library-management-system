const Joi = require("joi");
const assert = require("assert");
const Boom = require("@hapi/boom");

module.exports.register = (server) => {
  const schema = {
    payload: Joi.object({
      bookInfoId: Joi.number().integer().min(1).required(),
      note: Joi.string().optional().allow(null),
      page: Joi.number().integer().optional().allow(null),
    }),
    query: Joi.object({
      bookInfoId: Joi.number().integer().min(1).required(),
    }),
  };
  const handlers = {
    insertBookMark: async (req, h) => {
      try {
        const db = server.plugins.sql.client;
        const { bookInfoId, note, page } = req.payload;

        const result = await db.bookMark.insertBookMark({
          bookInfoId,
          note,
          page,
        });

        assert(result);

        if (result && result.rowsAffected && result.rowsAffected[0] === 1) {
          return h.response(result).code(201);
        }

        return Boom.internal();
      } catch (err) {
        console.log(err);
        return Boom.internal();
      }
    },
    getBookMark: async (req, h) => {
      try {
        const db = server.plugins.sql.client;
        const { bookInfoId } = req.query;

        const result = await db.bookMark.getBookMark({
          bookInfoId,
        });

        assert(result);

        if (result && result.recordset) {
          return result.recordset;
        }

        return Boom.internal();
      } catch (err) {
        console.log(err);
        return Boom.internal();
      }
    },
    deleteBookMark: async (req, h) => {
      try {
        const db = server.plugins.sql.client;
        const { bookMarkId } = req.params;

        const result = await db.bookMark.deleteBookMark({
          bookMarkId,
        });

        assert(result);

        if (result && result.rowsAffected && result.rowsAffected[0] === 1) {
          return h.response().code(204);
        }

        return Boom.notFound();
      } catch (err) {
        console.log(err);
        return Boom.internal();
      }
    },
  };

  return {
    schema,
    handlers,
  };
};
