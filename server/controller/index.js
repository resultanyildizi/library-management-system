const auth = require("./auth");
const api = require("./api");
const core = require("./core");

module.exports.register = (server) => {
  return {
    core: core.register(server),
    api: api.register(server),
    auth: auth.register(server),
  };
};
