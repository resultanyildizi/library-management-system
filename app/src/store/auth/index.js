import axios from "axios";
import jwt from "jsonwebtoken";
import router from "@/router";

const LOGIN_PATH = "http://localhost:5000/auth/login";

const state = {
  admin: null,
};
const getters = {
  getAdmin: (state) => state.admin,
};
const actions = {
  login: async ({ commit }, { email, password }) => {
    const result = await axios.post(LOGIN_PATH, {
      email,
      password,
    });
    localStorage.setItem("token", result.data.token);
    const admin = jwt.decode(result.data.token);

    commit("setAdmin", { adminId: admin.adminId, email: admin.email });

    router.push("/books");
  },

  validateToken: () => {
    const token = localStorage.getItem("token");
    if (token) {
      const decoded = jwt.decode(token);
      if (decoded && decoded.exp) {
        const now = Date.now() / 1000;
        return now < decoded.exp;
      }
    }
    return false;
  },

  validateAndResponse: async ({ dispatch }, { request }) => {
    try {
      const isValid = await dispatch("validateToken");
      if (isValid) {
        return await request;
      }
    } catch (err) {
      if (err.response && err.response.status === 401) {
        localStorage.removeItem("token");
        router.push("/");
      } else {
        throw err;
      }
    }
  },

  logout: () => {
    localStorage.clear();
    router.push("/");
  },
};
const mutations = {
  setAdmin: (state, val) => (state.admin = val),
};
export default { namespaced: true, state, getters, actions, mutations };
