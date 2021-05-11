import Vue from "vue";
import Vuex from "vuex";
import axios from "axios";

import auth from "./auth";
import publisher from "./publisher";
import author from "./author";
import country from "./country";
import category from "./category";
import book from "./book";
import language from "./language";
import bookMark from "./bookMark";
import state from "./state";

Vue.use(Vuex);

export default new Vuex.Store({
  state: {},
  mutations: {},
  actions: {
    uploadImage: async ({ dispatch }, { imageData, fileName }) => {
      try {
        const token = localStorage.getItem("token");
        const bodyFormData = new FormData();
        bodyFormData.append("file", imageData);
        bodyFormData.append("fileName", fileName);
        const request = axios.post(
          "http://localhost:5000/upload",
          bodyFormData,
          {
            headers: {
              "Content-Type": "multipart/form-data",
              Authorization: token,
            },
          }
        );
        return dispatch(
          "auth/validateAndResponse",
          { request },
          { root: true }
        ).then(() => {
          return fileName;
        });
      } catch (err) {
        console.log(err);
      }
    },
  },
  modules: {
    book,
    auth,
    author,
    country,
    category,
    bookMark,
    language,
    publisher,
    state,
  },
});
