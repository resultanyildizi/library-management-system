const bcrypt = require("bcrypt");

const hashData = async (password) => {
  return await bcrypt.hash(password, parseInt(process.env.SALT));
};

const compareData = async (password, hashed) => {
  return await bcrypt.compare(password, hashed);
};

module.exports = {
  hashData,
  compareData,
};
