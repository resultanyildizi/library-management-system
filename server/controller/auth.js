const bcrypt = require("../services/bcrypt.service");
const jwt = require("../services/jwt.service");
const Boom = require("@hapi/boom");
const Joi = require("joi");

module.exports.register = (server) => {
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
        if (req.query.key !== process.env.SIGNUP_KEY) return Boom.forbidden();
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

        return Boom.internal(err);
      }
    },

    login: async (req, h) => {
      try {
        const { email, password } = req.payload;
        const db = server.plugins.sql.client;
        const result = await db.admin.selectAdminByEmail({ email });

        // * If email is valid, check for the password
        if (result && result.recordset && result.recordset.length > 0) {
          const admin = result.recordset[0];

          //* Check if passwords match
          const isValid = await bcrypt.compareData(
            password,
            admin.hashedPassword
          );

          //* If credentials are valid, create a token
          if (isValid) {
            const { adminId, email } = admin;
            const token = jwt.issue({
              payload: { adminId, email },
              expiresIn: "1d",
            });

            return {
              token,
            };
          }
        }
        return Boom.unauthorized("Invalid login credentials");
      } catch (err) {
        console.error(err);
        return Boom.internal(err);
      }
    },

    validate: async (decoded, req, h) => {
      try {
        const { adminId, email } = decoded;
        const db = server.plugins.sql.client;
        const result = await db.admin.selectPublicDataByIdAndEmail(
          adminId,
          email
        );

        if (result && result.recordset && result.recordset.length === 1) {
          return {
            isValid: true,
            credentials: decoded,
          };
        }
        return { isValid: false };
      } catch (error) {
        console.error(error);
        return Boom.internal(error);
      }
    },
  };

  return {
    schema,
    handlers,
  };
};
