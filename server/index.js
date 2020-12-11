const server = require("./server");
const config = require("./config");
const init = async () => {
  try {
    const app = await server(config);
    await app.start();
    console.log("Server running at %s", app.info.uri);
  } catch (err) {
    console.error("Startup error: ", err);
  }
};

init();
