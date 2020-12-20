const fs = require("fs").promises;

const upload = async (path, bufferData) => {
  await fs.writeFile(path, bufferData);
};
module.exports = {
  upload,
};
