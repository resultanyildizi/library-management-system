const Joi = require("joi");
const controller = require("../../controller");

module.exports.register = async (server) => {
  const authorController = controller.register(server).api.author;

  const routes = [
    {
      method: "GET",
      path: "/api/author",
      options: {
        handler: authorController.handlers.getAuthor,
        validate: {
          query: Joi.object({
            name: Joi.string().min(1).max(100).optional(),
          }),
        },
      },
    },
    {
      method: "POST",
      path: "/api/author",
      options: {
        handler: authorController.handlers.insertAuthor,
        validate: {
          payload: authorController.schema.payload,
        },
      },
    },
    {
      method: "GET",
      path: "/api/author/{id}",
      options: {
        handler: authorController.handlers.getAuthorById,
        validate: {
          params: authorController.schema.params,
        },
      },
    },
    {
      method: "DELETE",
      path: "/api/author/{id}",
      options: {
        handler: authorController.handlers.deleteAuthor,
        validate: {
          params: authorController.schema.params,
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
