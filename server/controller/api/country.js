const Boom = require("@hapi/boom");
const assert = require("assert");

module.exports.register = (server) => {
  const handlers = {
    getCountries: async (req, h) => {
      try {
        const db = server.plugins.sql.client;
        const result = await db.country.selectAllCountries();

        assert(result);

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
