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
          query: publisherController.schema.query,
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
