const Joi = require("joi");
const controller = require("../../controller");

module.exports.register = async (server) => {
  const publisherController = controller.register(server).api.publisher;

  const routes = [
    {
      method: "GET",
      path: "/api/publisher",
      options: {
        handler: publisherController.handlers.getPublisher,
        validate: {
          query: Joi.object({
            name: Joi.string().min(1).max(70).optional(),
          }),
        },
      },
    },
    {
      method: "GET",
      path: "/api/publisher/{id}",
      options: {
        handler: publisherController.handlers.getPublisherById,
        validate: {
          params: publisherController.schema.params,
        },
      },
    },

    {
      method: "POST",
      path: "/api/publisher",
      options: {
        handler: publisherController.handlers.insertPublisher,
        validate: {
          payload: publisherController.schema.payload,
        },
      },
    },

    {
      method: "DELETE",
      path: "/api/publisher/{id}",
      options: {
        handler: publisherController.handlers.deletePublisher,
        validate: {
          params: publisherController.schema.params,
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
