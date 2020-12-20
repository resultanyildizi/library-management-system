const Boom = require("@hapi/boom");

module.exports.register = (server) => {
  const handlers = {
    getLanguages: async (req, h) => {
      try {
        const db = server.plugins.sql.client;
        const result = await db.language.selectAllLanguages();
        if (result && result.recordset) return result.recordset;

        return Boom.internal();
      } catch (err) {
        console.error(err);
        return Boom.internal(err);
      }
    },
  };

  return {
    handlers,
  };
};
