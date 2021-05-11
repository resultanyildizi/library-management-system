import axios from "axios";
import router from "../../router";
const BASE_URL = "http://localhost:5000/api/bookMark";
const state = {
  bookMarks: [],
};
const getters = {
  getBookMarks: (state) => state.bookMarks,
};
const actions = {
  async bindBookMarks({ dispatch, commit }, { bookInfoId }) {
    try {
      const token = localStorage.getItem("token");
      const request = axios.get(BASE_URL, {
        params: {
          bookInfoId,
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

      if (result && result.status === 200 && result.data) {
        commit("setBookMarks", { bookMarks: result.data });
      }
    } catch (err) {
      router.push({ name: "Error", params: { error: err } });
    }
  },
  async addBookMark({ dispatch }, { bookInfoId, page, note }) {
    const token = localStorage.getItem("token");

    const request = axios.post(
      BASE_URL,
      {
        bookInfoId,
        page,
        note,
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
      dispatch("bindBookMarks", { bookInfoId });
    }
  },
  deleteBookMark: async ({ dispatch }, { bookInfoId, bookMarkId }) => {
    try {
      const token = localStorage.getItem("token");
      const request = axios.delete(`${BASE_URL}/${bookMarkId}`, {
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
        dispatch("bindBookMarks", { bookInfoId });
      }
    } catch (err) {
      router.push({ name: "Error", params: { error: err } });
    }
  },
};
const mutations = {
  setBookMarks: (state, { bookMarks }) => (state.bookMarks = bookMarks),
};
export default { namespaced: true, state, getters, actions, mutations };
