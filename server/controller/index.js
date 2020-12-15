const auth = require("./auth");
const api = require("./api");

module.exports.register = (server) => {
  return {
    api: api.register(server),
    auth: auth.register(server),
  };
};
