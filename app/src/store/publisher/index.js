import axios from "axios";
import slugify from "slugify";
import router from "../../router";

const BASE_URL = "http://localhost:5000/api/publisher";
const state = {
  orderType: 1,
  publishers: [],
};
const getters = {
  getPublishers: (state) => state.publishers,
  getPublishersMap: (state) => {
    if (state.publishers) {
      return state.publishers.reduce((map, obj) => {
        map[obj.publisherId] = `${obj.name} #${obj.publisherId}`;
        return map;
      }, {});
    }
  },
  getOrderType: (state) => state.orderType,
};
const actions = {
  bindPublishers: async ({ commit, dispatch, state }) => {
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
      if (result && result.data)
        commit("setPublishers", { publishers: result.data });
    } catch (err) {
      err.message = "In method bindPublishers an error occured: " + err.message;
      router.push({ name: "Error", params: { error: err } });
    }
  },
  addPublisher: async (
    { dispatch },
    { name, foundationYear, description, imageData }
  ) => {
    var image = null;
    const token = localStorage.getItem("token");
    if (imageData) {
      const fileName = `publisher/${slugify(
        name
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
        name,
        foundationYear,
        description,
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
      dispatch("bindPublishers");
    }
  },

  deletePublisher: async ({ dispatch }, { publisherId }) => {
    try {
      const token = localStorage.getItem("token");
      const request = axios.delete(`${BASE_URL}/${publisherId}`, {
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
        dispatch("bindPublishers");
      }
    } catch (err) {
      router.push({ name: "Error", params: { error: err } });
    }
  },

  changeOrderType: async ({ commit, dispatch }, { orderType }) => {
    commit("setOrderType", { orderType });
    await dispatch("bindPublishers");
  },
};
const mutations = {
  setPublishers: (state, { publishers }) => (state.publishers = publishers),
  setOrderType: (state, { orderType }) => (state.orderType = orderType),
};
export default { namespaced: true, state, getters, actions, mutations };
