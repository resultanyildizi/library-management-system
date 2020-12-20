const Joi = require("joi");
const controller = require("../../controller");

module.exports.register = async (server) => {
  const bookInfoController = controller.register(server).api.bookInfo;

  const routes = [
    {
      method: "POST",
      path: "/api/bookInfo",
      options: {
        handler: bookInfoController.handlers.insertBookInfo,
        validate: {
          payload: bookInfoController.schema.payload,
        },
      },
    },
    {
      method: "POST",
      path: "/api/bookInfo/updateAndInsert",
      options: {
        handler: bookInfoController.handlers.updateAndInsert,
        validate: {
          payload: Joi.object({
            bookInfoId: Joi.number().integer().required(),
            translatorId: Joi.number().integer().allow(null).optional(),
            publisherId: Joi.number().integer().allow(null).optional(),
            authorIdList: Joi.string().min(2).optional().allow(null),
          }),
        },
      },
    },
  ];

  routes.forEach((route) => {
    route.options.cors = {
      origin: ["http://localhost:8080"],
      credentials: true,
    };
  });

  server.route(routes);
};
