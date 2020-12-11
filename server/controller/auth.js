const bcrypt = require("../services/bcrypt.service");
const Boom = require("@hapi/boom");
const Joi = require("joi");

module.exports.register = async (server) => {
  const schema = {
    payload: Joi.object({
      email: Joi.string().email().required(),
      password: Joi.string().pattern(
        new RegExp("^(?=.*d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$")
      ),
    }),
  };
  const { errors } = server.app.config.sql;

  const handlers = {
    signup: async (req, h) => {
      try {
        if (process.env.NODE_ENV === "production") return Boom.forbidden();
        const { email, password } = req.payload;
        const db = server.plugins.sql.client;

        const hashedPassword = await bcrypt.hashData(password);

        const result = await db.admin.insertAdmin({ email, hashedPassword });

        return result.rowsAffected[0] === 1
          ? h.response().code(201)
          : Boom.internal();
      } catch (err) {
        if (err.number == errors.uniqueConstraint)
          return Boom.conflict(err.message, err);
      }
    },

    login: async (req, h) => {},
  };

  return {
    schema,
    handlers,
  };
};
