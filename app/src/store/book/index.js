import axios from "axios";
// import { setTimeout } from "core-js";
import slugify from "slugify";
const BASE_URL = "http://localhost:5000/api/bookInfo";
const UPDATE_AND_INSERT_URL = `${BASE_URL}/updateAndInsert`;

const state = {
  books: [],
  lastInsertedBookId: null,
};

const getters = {
  getBooks: (state) => state.books,
  getLastInsertedBookId: (state) => state.lastInsertedBookId,
};
const actions = {
  //   bindBooks: async ({ commit, dispatch }) => {
  //     try {
  //       const token = localStorage.getItem("token");
  //       const request = axios.get(BASE_URL, {
  //         headers: {
  //           "Content-Type": "application/json",
  //           Bookization: token,
  //         },
  //       });

  //       const result = await dispatch(
  //         "auth/validateAndResponse",
  //         { request },
  //         { root: true }
  //       );
  //       if (result && result.data) commit("setBooks", { books: result.data });
  //     } catch (err) {
  //       console.log(err);
  //     }
  //   },

  addBook: async (
    { commit, dispatch },
    {
      name,
      publishYear,
      edition,
      pagesCount,
      height,
      width,
      imageData,
      languageId,
      description,
    }
  ) => {
    try {
      var image = null;
      const token = localStorage.getItem("token");
      if (imageData) {
        const fileName = `book/${slugify(
          name
        )}_${Date.now().toString()}.${imageData.name.split(".").pop()}`;

        image = await dispatch(
          "uploadImage",
          { imageData, fileName },
          { root: true }
        );
      }
      const request = axios.post(
        BASE_URL,
        {
          name,
          publishYear,
          edition,
          pagesCount,
          height,
          width,
          image,
          languageId,
          description,
        },
        {
          headers: {
            "Content-Type": "application/json",
            Authorization: token,
          },
        }
      );
      const result = await dispatch(
        "auth/validateAndResponse",
        { request },
        { root: true }
      );
      if (result && result.status === 201) {
        console.log(result.data.output);
        if (result.data && result.data.output && result.data.output.bookId) {
          commit("setLastInsertedBookId", {
            bookId: result.data.output.bookId,
          });
        } else {
          commit("setLastInsertedBookId", { bookId: null });
        }
      }
    } catch (err) {
      console.log(err);
    }
  },

  updateAndInsert: async (
    { dispatch },
    { bookInfoId, translatorId, publisherId, authorIdList }
  ) => {
    try {
      const token = localStorage.getItem("token");
      const request = axios.post(
        UPDATE_AND_INSERT_URL,
        {
          bookInfoId,
          translatorId,
          publisherId,
          authorIdList,
        },
        {
          headers: {
            "Content-Type": "application/json",
            Authorization: token,
          },
        }
      );
      const result = await dispatch(
        "auth/validateAndResponse",
        { request },
        { root: true }
      );
      if (result && result.status === 201) {
        console.log("success");
      }
    } catch (err) {
      console.log(err);
    }
  },
};
const mutations = {
  setBooks: (state, { books }) => (state.books = books),
  setLastInsertedBookId: (state, { bookId }) =>
    (state.lastInsertedBookId = bookId),
};
export default { namespaced: true, state, getters, actions, mutations };
