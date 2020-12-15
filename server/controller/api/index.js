const publisher = require("./publisher");
const author = require("./author");

module.exports.register = (server) => {
  return {
    publisher: publisher.register(server),
    author: author.register(server),
  };
};
