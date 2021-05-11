const publisher = require("./publisher");
const author = require("./author");
const country = require("./country");
const language = require("./language");
const category = require("./category");
const bookInfo = require("./bookInfo");
const bookMark = require("./bookMark");
const state = require("./state");
module.exports.register = (server) => {
  return {
    publisher: publisher.register(server),
    author: author.register(server),
    country: country.register(server),
    language: language.register(server),
    category: category.register(server),
    bookInfo: bookInfo.register(server),
    bookMark: bookMark.register(server),
    state: state.register(server),
  };
};
