const controller = require("../../controller");
module.exports.register = async (server) => {
  const languageController = controller.register(server).api.language;
  const routes = [
    {
      method: "GET",
      path: "/api/language",
      options: {
        handler: languageController.handlers.getLanguages,
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
