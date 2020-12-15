const auth = require("./auth");
const api = require("./api");

module.exports.register = async (server) => {
  await auth.register(server);
  await api.register(server);

  server.route({
    method: "GET",
    path: "/",
    options: {
      handler: (req, h) => {
        return { message: "📚 Welcome NRT Library Management System 📚" };
      },
    },
  });
};
