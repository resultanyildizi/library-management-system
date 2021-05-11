const Boom = require("@hapi/boom");
const assert = require("assert");
const Joi = require("joi");

module.exports.register = (server) => {
  const schema = {
    payload: Joi.object({
      name: Joi.string().min(1).max(70).required(),
    }),
    params: Joi.object({
      stateId: Joi.number().min(1).integer().required(),
    }),
  };

  const handlers = {
    insertState: async (req, h) => {
      try {
        const { name } = req.payload;
        const db = server.plugins.sql.client;
        const result = await db.state.insertState({
          name,
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

    getStates: async (req, h) => {
      try {
        const db = server.plugins.sql.client;

        const result = await db.state.selectAllStates();

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

    deleteState: async (req, h) => {
      try {
        const db = server.plugins.sql.client;

        const { stateId } = req.params;
        const result = await db.state.deleteState({ stateId });

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
    updateState: async (req, h) => {
      try {
        const db = server.plugins.sql.client;

        const { stateId } = req.params;
        const { name } = req.payload;
        const result = await db.state.updateState({ stateId, name });

        assert(result);

        if (result && result.rowsAffected && result.rowsAffected[0] === 1) {
          return h.response(result).code(200);
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
