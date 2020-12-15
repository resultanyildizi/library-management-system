const controller = require("../../controller");

module.exports.register = async (server) => {
  const authController = controller.register(server).auth;

  const routes = [
    {
      method: "POST",
      path: "/auth/signup",
      options: {
        handler: authController.handlers.signup,
        validate: {
          payload: authController.schema.payload,
        },
        auth: false,
      },
    },

    {
      method: "POST",
      path: "/auth/login",
      options: {
        handler: authController.handlers.login,
        validate: {
          payload: authController.schema.payload,
        },
        cors: {
          origin: ["http://localhost:8080"],
          credentials: true,
        },
        auth: false,
      },
    },
  ];

  server.route(routes);
};
