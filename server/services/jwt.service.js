const jwt = require("jsonwebtoken");

const issue = ({ payload, expiresIn }) => {
  const token = jwt.sign(payload, process.env.JWT_SECRET, {
    expiresIn: expiresIn,
  });

  return token;
};

module.exports = {
  issue,
};
