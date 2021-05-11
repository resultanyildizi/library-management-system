const publisher = require("./publisher");
const author = require("./author");
const country = require("./country");
const category = require("./category");
const bookInfo = require("./bookInfo");
const language = require("./language");
const bookMark = require("./bookMark");
const state = require("./state");

module.exports.register = async (server) => {
  await publisher.register(server);
  await author.register(server);
  await country.register(server);
  await category.register(server);
  await bookInfo.register(server);
  await language.register(server);
  await bookMark.register(server);
  await state.register(server);
};
