import axios from "axios";
import router from "@/router";
const LOGIN_PATH = "http://localhost:5000/auth/login";

const state = {
  token: null,
};
const getters = {
  getAdmin: (state) => state.admin,
};
const actions = {
  login: async (context, { email, password }) => {
    const result = await axios.post(LOGIN_PATH, {
      email,
      password,
    });
    localStorage.setItem("token", result.data.token);
    router.push("/");
  },

  logout: () => {
    localStorage.clear();
    router.push("/login");
  },
};
const mutations = {
  setAdmin: (state, val) => (state.admin = val),
};
export default { namespaced: true, state, getters, actions, mutations };
