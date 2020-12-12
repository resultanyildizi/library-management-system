const hapiAuthJwt2 = require("hapi-auth-jwt2");
const controller = require("../controller");

module.exports = {
  name: "auth",
  version: "1.0.0",
  register: async (server) => {
    await server.register(hapiAuthJwt2);
    const authController = (await controller.register(server)).auth;
    server.auth.strategy("jwt", "jwt", {
      key: process.env.JWT_SECRET,
      verifyOptions: {
        algorithm: "HS256",
      },
      validate: authController.handlers.validate,
    });

    server.auth.default("jwt");
  },
};
