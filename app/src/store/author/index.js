import axios from "axios";
import { setTimeout } from "core-js";
import slugify from "slugify";
const BASE_URL = "http://localhost:5000/api/author";
const state = {
  authors: [],
};
const getters = {
  getAuthors: (state) => state.authors,
  getAuthorsMap: (state) => {
    if (state.authors)
      return state.authors.reduce((map, obj) => {
        map[obj.authorId] = `${obj.fullName} #${obj.authorId}`;
        return map;
      }, {});
  },
};
const actions = {
  bindAuthors: async ({ commit, dispatch }) => {
    try {
      const token = localStorage.getItem("token");
      const request = axios.get(BASE_URL, {
        headers: {
          "Content-Type": "application/json",
          Authorization: token,
        },
      });

      const result = await dispatch(
        "auth/validateAndResponse",
        { request },
        { root: true }
      );
      if (result && result.data) commit("setAuthors", { authors: result.data });
    } catch (err) {
      console.log(err);
    }
  },

  addAuthor: async (
    { dispatch },
    { fullName, birthYear, countryId, imageData }
  ) => {
    try {
      var image = null;
      const token = localStorage.getItem("token");
      if (imageData) {
        const fileName = `author/${slugify(
          fullName
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
          fullName,
          birthYear,
          countryId,
          image,
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
        setTimeout(() => {
          dispatch("bindAuthors");
        }, 1000);
      }
    } catch (err) {
      console.log(err);
    }
  },
};
const mutations = {
  setAuthors: (state, { authors }) => (state.authors = authors),
};
export default { namespaced: true, state, getters, actions, mutations };
