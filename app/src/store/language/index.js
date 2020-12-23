import axios from "axios";
import router from "../../router";

const BASE_URL = "http://localhost:5000/api/language";

const state = {
  languages: null,
};
const getters = {
  getLanguageNames: (state) =>
    state.languages.map((language) => language.languageName),
  getLanguageMap: (state) => {
    if (state.languages)
      return state.languages.reduce((map, obj) => {
        map[obj.languageName] = obj.languageId;
        return map;
      }, {});
  },
};
const actions = {
  bindLanguages: async ({ commit, dispatch }) => {
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

      if (result && result.data) {
        commit("setLanguages", { languages: result.data });
        return result.data;
      }
    } catch (err) {
      err.message = "In method languages an error occured: " + err.message;
      router.push({ name: "Error", params: { error: err } });
    }
  },
};
const mutations = {
  setLanguages: (state, { languages }) => (state.languages = languages),
};
export default { namespaced: true, state, getters, actions, mutations };
