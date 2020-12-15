const publisher = require("./publisher");
const author = require("./author");
module.exports.register = async (server) => {
  await publisher.register(server);
  await author.register(server);
};
