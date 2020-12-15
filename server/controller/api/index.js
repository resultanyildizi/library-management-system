const publisher = require("./publisher");

module.exports.register = (server) => {
  return {
    publisher: publisher.register(server),
  };
};
