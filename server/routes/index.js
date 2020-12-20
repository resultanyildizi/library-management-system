const auth = require("./auth");
const api = require("./api");
const controller = require("../controller");

module.exports.register = async (server) => {
  await auth.register(server);
  await api.register(server);

  const coreController = controller.register(server).core;

  server.route({
    method: "GET",
    path: "/",
    options: {
      handler: (req, h) => {
        return { message: "📚 Welcome NRT Library Management System 📚" };
      },
    },
  });

  server.route({
    method: "POST",
    path: "/upload",
    options: {
      handler: coreController.handlers.uploadImage,
      payload: {
        output: "stream",
        maxBytes: 1048576 * 5,
        parse: true,
        allow: "multipart/form-data",
        multipart: true,
      },
      cors: {
        origin: ["http://localhost:8080"],
        credentials: true,
      },
    },
  });
};
