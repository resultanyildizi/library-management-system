const controller = require("../../controller");
module.exports.register = async (server) => {
  const categoryController = controller.register(server).api.category;
  const routes = [
    {
      method: "GET",
      path: "/api/category",
      options: {
        handler: categoryController.handlers.getAllCategories,
      },
    },
    {
      method: "POST",
      path: "/api/category",
      options: {
        handler: categoryController.handlers.insertCategory,
        validate: {
          payload: categoryController.schema.payload,
        },
      },
    },
    {
      method: "DELETE",
      path: "/api/category/{categoryId}",
      options: {
        handler: categoryController.handlers.deleteCategory,
        validate: {
          params: categoryController.schema.params,
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
