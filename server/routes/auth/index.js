const controller = require("../../controller");

module.exports.register = async (server) => {
  const authController = (await controller.register(server)).auth;

  server.route({
    method: "POST",
    path: "/auth/signup",
    options: {
      handler: authController.handlers.signup,
      validate: {
        payload: authController.schema.payload,
      },
    },
  });
};
