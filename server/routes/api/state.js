const controller = require("../../controller");

module.exports.register = async (server) => {
  const stateController = controller.register(server).api.state;

  const routes = [
    {
      method: "GET",
      path: "/api/state",
      options: {
        handler: stateController.handlers.getStates,
      },
    },

    {
      method: "POST",
      path: "/api/state",
      options: {
        handler: stateController.handlers.insertState,
        validate: {
          payload: stateController.schema.payload,
        },
      },
    },

    {
      method: "DELETE",
      path: "/api/state/{stateId}",
      options: {
        handler: stateController.handlers.deleteState,
        validate: {
          params: stateController.schema.params,
        },
      },
    },
    {
      method: "PUT",
      path: "/api/state/{stateId}",
      options: {
        handler: stateController.handlers.updateState,
        validate: {
          params: stateController.schema.params,
          payload: stateController.schema.payload,
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
