import axios from "axios";
import router from "../../router";

const BASE_URL = "http://localhost:5000/api/state";

const state = {
  states: [],
};
const getters = {
  getStatesObject: (state) => {
    if (state.states)
      return state.states.reduce((map, obj) => {
        map[obj.stateId] = obj.stateName + ` #${obj.stateId}`;
        return map;
      }, {});
  },
  getStates: (state) => {
    return state.states;
  },
};
const actions = {
  bindStates: async ({ commit, dispatch }) => {
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
        commit("setStates", { states: result.data });
        return result.data;
      }
    } catch (err) {
      err.message = "In method bindStates an error occured: " + err.message;
      router.push({ name: "Error", params: { error: err } });
    }
  },
  addState: async ({ dispatch }, { name }) => {
    try {
      const token = localStorage.getItem("token");
      const request = axios.post(
        BASE_URL,
        {
          name,
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

      if (result && result.status > 200 && result.status < 400) {
        dispatch("bindStates");
      }
    } catch (err) {
      err.message = "In method addState an error occured: " + err.message;
      router.push({ name: "Error", params: { error: err } });
    }
  },
  deleteState: async ({ dispatch }, { stateId }) => {
    try {
      const token = localStorage.getItem("token");
      const request = axios.delete(`${BASE_URL}/${stateId}`, {
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

      if (result && result.status >= 200 && result.status < 400) {
        dispatch("bindStates");
      }
    } catch (err) {
      err.message = "In method deleteState an error occured: " + err.message;
      router.push({ name: "Error", params: { error: err } });
    }
  },
  updateState: async ({ dispatch }, { stateId, name }) => {
    try {
      const token = localStorage.getItem("token");
      const request = axios.put(
        `${BASE_URL}/${stateId}`,
        {
          name,
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

      if (result && result.status >= 200 && result.status < 400) {
        dispatch("bindStates");
      }
    } catch (err) {
      err.message = "In method deleteState an error occured: " + err.message;
      router.push({ name: "Error", params: { error: err } });
    }
  },
};
const mutations = {
  setStates: (state, { states }) => (state.states = states),
};
export default { namespaced: true, state, getters, actions, mutations };
