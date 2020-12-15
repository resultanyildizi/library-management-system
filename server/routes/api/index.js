const publisher = require("./publisher");
module.exports.register = async (server) => {
  await publisher.register(server);
};
