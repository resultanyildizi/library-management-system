import axios from "axios";
import router from "../../router";

const BASE_URL = "http://localhost:5000/api/country";

const state = {
  countries: null,
};
const getters = {
  getCountries: (state) => {
    if (state.countries)
      return state.countries.reduce((map, obj) => {
        map[obj.countryId] = obj.countryName;
        return map;
      }, {});
  },
};
const actions = {
  bindCountries: async ({ commit, dispatch }) => {
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
        commit("setCountries", { countries: result.data });
        return result.data;
      }
    } catch (err) {
      err.message = "In method bindCountries an error occured: " + err.message;
      router.push({ name: "Error", params: { error: err } });
    }
  },
};
const mutations = {
  setCountries: (state, { countries }) => (state.countries = countries),
};
export default { namespaced: true, state, getters, actions, mutations };
