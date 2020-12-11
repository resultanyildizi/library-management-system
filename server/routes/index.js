const auth = require("./auth");

module.exports.register = async (server) => {
  await auth.register(server);

  server.route({
    method: "GET",
    path: "/",
    handler: (req, h) => {
      return { message: "📚 Welcome NRT Library Management System 📚" };
    },
  });
};
