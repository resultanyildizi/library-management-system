const Boom = require("@hapi/boom");
const assert = require("assert");
const Joi = require("joi");

module.exports.register = (server) => {
  const schema = {
    payload: Joi.object({
      name: Joi.string().min(1).max(70).required(),
      description: Joi.string().max(1000).optional().allow(null).allow(""),
      foundationYear: Joi.string().min(1).max(4).optional().allow(null),
      image: Joi.string().max(4000).optional().allow(null),
    }),
    params: Joi.object({
      id: Joi.number().min(1).integer().required(),
    }),
    query: Joi.object({
      name: Joi.string().min(1).max(70).optional(),
      orderType: Joi.number().integer().allow(null).optional(),
    }),
  };

  const handlers = {
    insertPublisher: async (req, h) => {
      try {
        const { name, description, foundationYear, image } = req.payload;
        const db = server.plugins.sql.client;
        const result = await db.publisher.insertPublisher({
          name,
          description,
          foundationYear,
          image,
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

    getPublisher: async (req, h) => {
      try {
        const db = server.plugins.sql.client;

        const { name, orderType } = req.query;

        const result = await (name
          ? db.publisher.selectPublisherByName({ name })
          : db.publisher.selectAllPublishers({ orderType }));

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
    deletePublisher: async (req, h) => {
      try {
        const db = server.plugins.sql.client;

        const { id } = req.params;
        const result = await db.publisher.deletePublisherById({ id });

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
    getPublisherById: async (req, h) => {
      try {
        const db = server.plugins.sql.client;

        const { id } = req.params;
        const result = await db.publisher.selectPublisherById({ id });

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
