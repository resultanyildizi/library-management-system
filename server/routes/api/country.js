const controller = require("../../controller");
module.exports.register = async (server) => {
  const countryController = controller.register(server).api.country;
  const routes = [
    {
      method: "GET",
      path: "/api/country",
      options: {
        handler: countryController.handlers.getCountries,
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
