"use strict";

const dbClient = require("../database");

module.exports = {
  name: "sql",
  version: "1.0.0",
  register: async (server) => {
    const config = server.app.config.sql;
    const db = await dbClient(server, config);

    server.expose("client", db);
  },
};
