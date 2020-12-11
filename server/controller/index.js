const auth = require("./auth");

module.exports.register = async (server) => {
  return {
    auth: await auth.register(server),
  };
};
