const Boom = require("@hapi/boom");
const assert = require("assert");
const Joi = require("joi");

module.exports.register = (server) => {
  const schema = {
    payload: Joi.object({
      fullName: Joi.string().min(1).max(100).required(),
      birthYear: Joi.string().min(1).max(4).optional().allow(null),
      image: Joi.string().min(1).max(4000).optional().allow(null),
      countryId: Joi.number().integer().min(1).optional().allow(null),
    }),
    params: Joi.object({
      id: Joi.number().integer().min(1).required(),
    }),
    query: Joi.object({
      name: Joi.string().min(1).max(100).optional(),
      orderType: Joi.number().integer().allow(null).optional(),
    }),
  };

  const handlers = {
    insertAuthor: async (req, h) => {
      try {
        const { fullName, birthYear, image, countryId } = req.payload;
        const db = server.plugins.sql.client;
        const result = await db.author.insertAuthor({
          fullName,
          birthYear,
          image,
          countryId,
        });

        assert(result);

        if (result && result.rowsAffected && result.rowsAffected[0] === 1) {
          return h.response().code(201);
        }
        return Boom.internal();
      } catch (err) {
        console.log(err);
        Boom.internal(err);
      }
    },

    getAuthor: async (req, h) => {
      try {
        const db = server.plugins.sql.client;

        const { name, orderType } = req.query;

        const result = await (name
          ? db.author.selectAuthorByNameOrCountry({ name })
          : db.author.selectAllAuthors({ orderType }));

        assert(result);

        if (result && result.recordset) {
          return result.recordset;
        }

        return Boom.internal();
      } catch (err) {
        console.log(err);
        Boom.internal(err);
      }
    },
    deleteAuthor: async (req, h) => {
      try {
        const db = server.plugins.sql.client;

        const { id } = req.params;
        const result = await db.author.deleteAuthorById({ id });

        assert(result);

        if (result && result.rowsAffected && result.rowsAffected[0] === 1) {
          return h.response().code(204);
        }

        return Boom.notFound();
      } catch (err) {
        console.log(err);
        Boom.internal(err);
      }
    },
    getAuthorById: async (req, h) => {
      try {
        const db = server.plugins.sql.client;

        const { id } = req.params;
        const result = await db.author.selectAuthorById({ id });

        assert(result);

        if (result && result.recordset && result.recordset.length > 0) {
          return result.recordset;
        }

        return Boom.notFound();
      } catch (err) {
        console.log(err);
        Boom.internal(err);
      }
    },
  };

  return {
    schema,
    handlers,
  };
};
