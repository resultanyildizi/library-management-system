const controller = require("../../controller");

module.exports.register = async (server) => {
  const bookInfoController = controller.register(server).api.bookInfo;

  const routes = [
    {
      method: "GET",
      path: "/api/bookInfo",
      options: {
        handler: bookInfoController.handlers.getAllBookInfos,
        validate: {
          query: bookInfoController.handlers.query,
        },
      },
    },
    {
      method: "POST",
      path: "/api/bookInfo",
      options: {
        handler: bookInfoController.handlers.insertBookInfo,
        validate: {
          payload: bookInfoController.schema.payload,
        },
      },
    },
    {
      method: "DELETE",
      path: "/api/bookInfo/{bookInfoId}",
      options: {
        handler: bookInfoController.handlers.deleteBookInfo,
        validate: {
          params: bookInfoController.schema.params,
        },
      },
    },
    {
      method: "PUT",
      path: "/api/bookInfo/{bookInfoId}",
      options: {
        handler: bookInfoController.handlers.updateBookInfo,
        validate: {
          payload: bookInfoController.schema.payload,
          params: bookInfoController.schema.params,
        },
      },
    },
    {
      method: "PUT",
      path: "/api/bookInfo/updateAndInsert/{bookInfoId}",
      options: {
        handler: bookInfoController.handlers.updateAndInsert,
        validate: {
          payload: bookInfoController.schema.updateAndInsertPayload,
          params: bookInfoController.schema.params,
        },
      },
    },

    {
      method: "PUT",
      path: "/api/bookInfo/updateScore/{bookInfoId}",
      options: {
        handler: bookInfoController.handlers.updateBookInfoScore,
        validate: {
          payload: bookInfoController.schema.updateBookInfoScorePayload,
          params: bookInfoController.schema.params,
        },
      },
    },
    {
      method: "PUT",
      path: "/api/bookInfo/updateState/{bookInfoId}",
      options: {
        handler: bookInfoController.handlers.updateBookInfoState,
        validate: {
          payload: bookInfoController.schema.updateBookInfoStatePayload,
          params: bookInfoController.schema.params,
        },
      },
    },
    {
      method: "PUT",
      path: "/api/bookInfo/updateCategoryId/{bookInfoId}",
      options: {
        handler: bookInfoController.handlers.updateCategoryId,
        validate: {
          payload: bookInfoController.schema.updateCategoryIdPayload,
          params: bookInfoController.schema.params,
        },
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
