const Boom = require("@hapi/boom");
const Joi = require("joi");

module.exports.register = (server) => {
  const { errors } = server.app.config.sql;

  const schema = {
    payload: Joi.object({
      languageId: Joi.number().integer().allow(null).optional(),
      pagesCount: Joi.number().integer().min(5).allow(null).optional(),
      image: Joi.string().min(1).max(4000).allow(null).optional(),
      publishYear: Joi.string().min(1).max(4).optional().allow(null),
      description: Joi.string().max(1000).optional().allow(null).allow(""),
      edition: Joi.number().integer().min(1).optional().allow(null),
      width: Joi.number().min(5).optional().allow(null),
      height: Joi.number().min(5).optional().allow(null),
      name: Joi.string().min(1).max(200).required(),
    }),
    params: Joi.object({
      bookInfoId: Joi.number().integer().min(1).required(),
    }),
  };

  const handlers = {
    insertBookInfo: async (req, h) => {
      try {
        const {
          languageId,
          pageCount,
          image,
          publishYear,
          description,
          edition,
          width,
          height,
          name,
        } = req.payload;

        const db = server.plugins.sql.client;

        const result = await db.bookInfo.insertBookInfo({
          languageId,
          pageCount,
          image,
          publishYear,
          description,
          edition,
          width,
          height,
          name,
        });

        if (result && result.rowsAffected && result.rowsAffected[0] === 1) {
          return h.response(result).code(201);
        }
        return Boom.internal();
      } catch (err) {
        console.log(err);
        Boom.internal(err);
      }
    },

    updateAndInsert: async (req, h) => {
      try {
        const {
          bookInfoId,
          translatorId,
          publisherId,
          authorIdList,
        } = req.payload;

        const db = server.plugins.sql.client;

        const result = await db.bookInfo.updateAndInsert({
          bookInfoId,
          translatorId,
          publisherId,
          authorIdList,
        });

        if (result && result.rowsAffected && result.rowsAffected[0] === 1) {
          return h.response(result).code(201);
        }

        return Boom.internal();
      } catch (err) {
        if (err.number == errors.duplicate)
          return Boom.conflict(err.message, err);

        return Boom.internal(err);
      }
    },
  };

  return {
    schema,
    handlers,
  };
};
