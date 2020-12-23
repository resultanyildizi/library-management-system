const Boom = require("@hapi/boom");
const Joi = require("joi");
const assert = require("assert");

module.exports.register = (server) => {
  const { errors } = server.app.config.sql;

  const schema = {
    payload: Joi.object({
      languageId: Joi.number().integer().allow(null).optional(),
      pageCount: Joi.number().integer().min(5).allow(null).optional(),
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
    query: Joi.object({
      orderType: Joi.number().integer().allow(null).optional(),
    }),

    updateAndInsertPayload: Joi.object({
      translatorId: Joi.number().integer().allow(null).optional(),
      publisherId: Joi.number().integer().allow(null).optional(),
      authorIdList: Joi.string().min(2).optional().allow(null),
    }),

    updateCategoryIdPayload: Joi.object({
      categoryId: Joi.number().integer().allow(null).optional(),
    }),

    updateBookInfoScorePayload: Joi.object({
      score: Joi.number().integer().required(),
    }),
  };

  const handlers = {
    insertBookInfo: async (req, h) => {
      try {
        const db = server.plugins.sql.client;

        const result = await db.bookInfo.insertBookInfo({
          languageId: req.payload.languageId,
          pageCount: req.payload.pageCount,
          image: req.payload.image,
          publishYear: req.payload.publishYear,
          description: req.payload.description,
          edition: req.payload.edition,
          width: req.payload.width,
          height: req.payload.height,
          name: req.payload.name,
        });

        assert(result);

        if (result && result.rowsAffected && result.rowsAffected[0] === 1) {
          return h.response(result).code(201);
        }

        return Boom.internal("No rows affected");
      } catch (err) {
        console.log(err);
        Boom.internal(err);
      }
    },

    updateBookInfo: async (req, h) => {
      try {
        const db = server.plugins.sql.client;

        const result = await db.bookInfo.updateBookInfo({
          bookInfoId: req.params.bookInfoId,
          languageId: req.payload.languageId,
          pageCount: req.payload.pageCount,
          image: req.payload.image,
          publishYear: req.payload.publishYear,
          description: req.payload.description,
          edition: req.payload.edition,
          width: req.payload.width,
          height: req.payload.height,
          name: req.payload.name,
        });

        assert(result);

        if (result && result.rowsAffected && result.rowsAffected[0] === 1) {
          return h.response(result).code(200);
        }

        return Boom.notFound("No rows affected");
      } catch (err) {
        console.log(err);
        Boom.internal(err);
      }
    },

    updateAndInsert: async (req, h) => {
      try {
        const { translatorId, publisherId, authorIdList } = req.payload;
        const { bookInfoId } = req.params;

        const db = server.plugins.sql.client;

        const result = await db.bookInfo.updateAndInsert({
          bookInfoId,
          translatorId,
          publisherId,
          authorIdList,
        });

        assert(result);

        if (result && result.rowsAffected && result.rowsAffected[0] === 1) {
          return h.response(result).code(201);
        }

        return Boom.notFound("No result or no rows affected", result);
      } catch (err) {
        if (err.number == errors.duplicate)
          return Boom.conflict(err.message, err);

        console.log(err);
        return Boom.internal(err);
      }
    },
    updateCategoryId: async (req, h) => {
      try {
        const { categoryId } = req.payload;
        const { bookInfoId } = req.params;

        const db = server.plugins.sql.client;

        const result = await db.bookInfo.updateCategoryId({
          bookInfoId,
          categoryId,
        });

        assert(result);

        if (result && result.rowsAffected && result.rowsAffected[0] === 1) {
          return h.response(result).code(200);
        }

        return Boom.notFound("No result or no rows affected", result);
      } catch (err) {
        console.error(err);
        return Boom.internal(err);
      }
    },

    getAllBookInfos: async (req, h) => {
      try {
        const db = server.plugins.sql.client;
        const { orderType } = req.query;
        const result = await db.bookInfo.selectAllBookInfos({ orderType });

        assert(result);

        if (result && result.recordset) {
          return result.recordset;
        }

        return Boom.internal();
      } catch (err) {
        console.error(err);
        return Boom.internal(err);
      }
    },

    deleteBookInfo: async (req, h) => {
      try {
        const db = server.plugins.sql.client;
        const { bookInfoId } = req.params;
        const result = await db.bookInfo.deleteBookInfo({ bookInfoId });

        assert.ok(result);

        if (result && result.rowsAffected && result.rowsAffected[0] === 1) {
          return h.response(result).code(204);
        }

        return Boom.notFound("No result or no rows affected", result);
      } catch (err) {
        console.error(err);
        return Boom.internal(err);
      }
    },

    updateBookInfoScore: async (req, h) => {
      try {
        const db = server.plugins.sql.client;
        const { bookInfoId } = req.params;
        const { score } = req.payload;
        const result = await db.bookInfo.updateBookInfoScore({
          bookInfoId,
          score,
        });

        assert.ok(result);

        if (result && result.rowsAffected && result.rowsAffected[0] === 1) {
          return h.response(result).code(204);
        }

        return Boom.notFound("No result or no rows affected", result);
      } catch (err) {
        console.error(err);
        return Boom.internal(err);
      }
    },
  };

  return {
    schema,
    handlers,
  };
};
