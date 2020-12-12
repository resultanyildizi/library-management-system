const sql = require("./sql");
const auth = require("./auth");
module.exports.register = async (server) => {
  await server.register([auth, sql]);
};
