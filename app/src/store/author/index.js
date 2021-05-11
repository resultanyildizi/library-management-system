import axios from "axios";
import slugify from "slugify";
import router from "../../router";
const BASE_URL = "http://localhost:5000/api/author";
const state = {
  authors: [],
  author: null,
  orderType: 2,
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
  getAuthor: (state) => state.author,
  getOrderType: (state) => state.orderType,
};
const actions = {
  bindAuthors: async ({ commit, dispatch, state }) => {
    try {
      const token = localStorage.getItem("token");
      const request = axios.get(BASE_URL, {
        params: {
          orderType: state.orderType,
        },
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
      err.message = "In method bindAuthors an error occured: " + err.message;
      router.push({ name: "Error", params: { error: err } });
    }
  },

  addAuthor: async (
    { dispatch },
    { fullName, birthYear, countryId, imageData }
  ) => {
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
      dispatch("bindAuthors");
    }
  },

  deleteAuthor: async ({ dispatch }, { authorId }) => {
    try {
      const token = localStorage.getItem("token");
      const request = axios.delete(`${BASE_URL}/${authorId}`, {
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
      if (result && result.status === 204) {
        dispatch("bindAuthors");
      }
    } catch (err) {
      router.push({ name: "Error", params: { error: err } });
    }
  },

  selectAuthor({ commit }, { author }) {
    commit("setAuthor", { author });
  },

  changeOrderType: async ({ commit, dispatch }, { orderType }) => {
    commit("setOrderType", { orderType });
    await dispatch("bindAuthors");
  },
};
const mutations = {
  setAuthors: (state, { authors }) => (state.authors = authors),
  setAuthor: (state, { author }) => (state.author = author),
  setOrderType: (state, { orderType }) => (state.orderType = orderType),
};
export default { namespaced: true, state, getters, actions, mutations };
