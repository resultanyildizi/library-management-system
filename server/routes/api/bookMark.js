const controller = require("../../controller");
module.exports.register = async (server) => {
  const bookMarkController = controller.register(server).api.bookMark;

  const routes = [
    {
      method: "POST",
      path: "/api/bookMark",
      options: {
        handler: bookMarkController.handlers.insertBookMark,
        validate: {
          payload: bookMarkController.schema.payload,
        },
      },
    },
    {
      method: "GET",
      path: "/api/bookMark",
      options: {
        handler: bookMarkController.handlers.getBookMark,
        validate: {
          query: bookMarkController.schema.query,
        },
      },
    },
    {
      method: "DELETE",
      path: "/api/bookMark/{bookMarkId}",
      options: {
        handler: bookMarkController.handlers.deleteBookMark,
        validate: {
          params: bookMarkController.schema.params,
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
