const Boom = require("@hapi/boom");
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

        if (result && result.rowsAffected && result.rowsAffected[0] === 1) {
          return h.response().code(201);
        } else {
          return Boom.internal();
        }
      } catch (err) {
        console.log(err);
        Boom.internal(err);
      }
    },

    getAuthor: async (req, h) => {
      try {
        const db = server.plugins.sql.client;

        const { name } = req.query;

        const result = await (name
          ? db.author.selectAuthorByNameOrCountry({ name })
          : db.author.selectAllAuthors());

        if (result && result.recordset) {
          return result.recordset;
        } else {
          return Boom.internal();
        }
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

        if (result && result.rowsAffected && result.rowsAffected[0] === 1) {
          return h.response().code(204);
        } else return Boom.notFound();
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

        if (result && result.recordset && result.recordset.length > 0) {
          return result.recordset;
        } else return Boom.notFound();
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
