const sql = require("mssql");

const admin = require("./admin");
const publisher = require("./publisher");
const author = require("./author");
const country = require("./country");
const category = require("./category");
const bookInfo = require("./bookInfo");
const language = require("./language");

const client = async (server, config) => {
  let pool = null;

  const getConnection = async () => {
    try {
      if (pool) {
        return pool;
      }
      pool = await sql.connect(config);
      pool.on("error", async (err) => {
        console.error(err);
        await closeConnection();
      });
      console.log("Connected SQL Server successfully ✔");
      return pool;
    } catch (err) {
      pool = null;
      console.error(err);
    }
  };

  const closeConnection = async () => {
    try {
      await pool.close();
      pool = null;
    } catch (err) {
      pool = null;
      console.error(err);
    }
  };

  return {
    admin: await admin.register({ sql, getConnection }),
    publisher: await publisher.register({ sql, getConnection }),
    author: await author.register({ sql, getConnection }),
    country: await country.register({ sql, getConnection }),
    category: await category.register({ sql, getConnection }),
    bookInfo: await bookInfo.register({ sql, getConnection }),
    language: await language.register({ sql, getConnection }),
  };
};

module.exports = client;
