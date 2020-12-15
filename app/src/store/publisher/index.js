import axios from "axios";
import router from "../../router";
const BASE_URL = "http://localhost:5000/api/publisher";
const state = {
  publishers: [],
};
const getters = {
  getPublishers: (state) => state.publishers,
};
const actions = {
  bindPublishers: async ({ commit }) => {
    const token = localStorage.getItem("token");
    if (token) {
      const result = await axios.get(BASE_URL, {
        headers: {
          "Content-Type": "application/json",
          Authorization: token,
        },
      });
      commit("setPublishers", { publishers: result.data });
      console.log(result.data);
    } else {
      router.push("/login");
    }
  },
};
const mutations = {
  setPublishers: (state, { publishers }) => (state.publishers = publishers),
};
export default { namespaced: true, state, getters, actions, mutations };
