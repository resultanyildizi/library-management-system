const fup = require("../services/fileUploader.service");
const path = require("path");
const Boom = require("@hapi/boom");

const UPLOAD_PATH = path.join(__dirname, "../../", "/app/upload/img");

module.exports.register = (server) => {
  const handlers = {
    uploadImage: async (req, h) => {
      try {
        if (req.payload.file && req.payload.fileName) {
          const __path = path.join(UPLOAD_PATH, req.payload.fileName);

          await fup.upload(__path, req.payload.file._data);

          return {
            message: "Uploaded ✅",
          };
        } else return Boom.badRequest("Invalid file or file name");
      } catch (err) {
        console.log(err);
        Boom.internal();
      }
    },
  };

  return {
    handlers,
  };
};
