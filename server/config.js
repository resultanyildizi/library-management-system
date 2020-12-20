const dotenv = require("dotenv");

dotenv.config();

const {
  PORT,
  HOST,
  HOST_URL,
  SQL_USER,
  SQL_PASSWORD,
  SQL_DATABASE,
  SQL_SERVER,
} = process.env;

const sqlEncrypt = process.env.SQL_ENCRYPT === "true";
const enableArithAbort = process.env.SQL_ENABLE_ARITHABORT === "true";

module.exports = {
  port: PORT,
  host: HOST,
  hostUrl: HOST_URL,
  sql: {
    user: SQL_USER,
    password: SQL_PASSWORD,
    database: SQL_DATABASE,
    server: SQL_SERVER,
    options: {
      encrypt: sqlEncrypt,
      enableArithAbort: enableArithAbort,
    },
    errors: {
      uniqueConstraint: 2627,
      duplicate: 2601,
    },
  },
};
