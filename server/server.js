const Hapi = require("@hapi/hapi");
const routes = require("./routes");
const plugins = require("./plugins");

const app = async (config) => {
  const { host, port } = config;

  const server = Hapi.server({ port, host });
  server.app.config = config;

  await routes.register(server);
  await plugins.register(server);

  return server;
};

module.exports = app;
